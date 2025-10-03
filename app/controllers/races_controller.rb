class RacesController < ApplicationController
  def index
    races = Race.all.order(race_date: :desc)
    @races_by_year = races.group_by { |race| race.race_date.year }
  end

  def show
    @race = Race.includes(race_results: [racer_season: [racer: :team], category: [], race_result_laps: []])
                .find(params[:id])
    
    # Get all race results for stats calculation
    all_race_results = @race.race_results
                            .joins(racer_season: :racer)
                            .includes(racer_season: [racer: :team], category: [], race_result_laps: [])
                            .order(:place)
    
    # Filter by category if specified, otherwise show first category with results
    @selected_category = params[:category]
    if @selected_category.present?
      @race_results = all_race_results.joins(:category)
                                      .where(categories: { name: @selected_category })
    else
      # Default to first category with results
      first_category = all_race_results.joins(:category)
                                      .group('categories.name')
                                      .order('categories.name')
                                      .limit(1)
                                      .pluck('categories.name')
                                      .first
      
      if first_category
        @selected_category = first_category
        @race_results = all_race_results.joins(:category)
                                        .where(categories: { name: @selected_category })
      else
        @race_results = all_race_results
        @selected_category = 'Unknown'
      end
    end
    
    @overall_winner = all_race_results.first
    @fastest_lap = find_fastest_lap(all_race_results)
    @average_time = calculate_average_time(all_race_results)
    @participants_count = all_race_results.count
    @finished_count = all_race_results.where(status: 'FINISHED').count
    @dnf_dns_count = @participants_count - @finished_count
    
    @category_stats = calculate_category_stats(all_race_results)
    
    # Calculate maximum number of laps for dynamic lap columns based on filtered results
    @max_laps = @race_results.joins(:race_result_laps)
                             .maximum('race_result_laps.lap_number') || 0
  end

  private

  def find_fastest_lap(race_results)
    fastest_lap_result = nil
    fastest_time = Float::INFINITY
    
    race_results.each do |result|
      result.race_result_laps.each do |lap|
        if lap.lap_time_ms && lap.lap_time_ms < fastest_time
          fastest_time = lap.lap_time_ms
          fastest_lap_result = { result: result, lap: lap }
        end
      end
    end
    
    fastest_lap_result
  end

  def calculate_average_time(race_results)
    finished_results = race_results.where(status: 'FINISHED')
    return 0 if finished_results.empty?
    
    total_time = finished_results.sum(:total_time_ms)
    total_time / finished_results.count
  end

  def calculate_category_stats(race_results)
    stats = {}
    
    # Initialize all categories with zero counts, respecting sort_order
    Category.by_sort_order.each do |category|
      stats[category.name] = { count: 0, winner: nil, winner_time: Float::INFINITY }
    end
    
    # Count race results for each category
    race_results.each do |result|
      category_name = result.category&.name || 'Unknown'
      if stats[category_name]
        stats[category_name][:count] += 1
        
        if result.total_time_ms && result.total_time_ms < stats[category_name][:winner_time]
          stats[category_name][:winner] = result
          stats[category_name][:winner_time] = result.total_time_ms
        end
      else
        # Handle unknown categories (categories not in the Category table)
        stats[category_name] = { count: 1, winner: result, winner_time: result.total_time_ms || Float::INFINITY }
      end
    end
    
    stats
  end
end