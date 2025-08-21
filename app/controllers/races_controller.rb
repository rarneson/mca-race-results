class RacesController < ApplicationController
  def index
    @races = Race.all.order(race_date: :desc)
  end

  def show
    @race = Race.includes(race_results: [racer_season: [racer: :team], category_snapshot: [], race_result_laps: []])
                .find(params[:id])
    
    # Get all race results for stats calculation
    all_race_results = @race.race_results
                            .joins(racer_season: :racer)
                            .includes(racer_season: [racer: :team], category_snapshot: [], race_result_laps: [])
                            .order(:place)
    
    # Filter by category if specified
    @selected_category = params[:category]
    if @selected_category.present? && @selected_category != 'all'
      @race_results = all_race_results.joins(:category_snapshot)
                                      .where(categories: { name: @selected_category })
    else
      @race_results = all_race_results
      @selected_category = 'all'
    end
    
    @overall_winner = all_race_results.first
    @fastest_lap = find_fastest_lap(all_race_results)
    @average_time = calculate_average_time(all_race_results)
    @participants_count = all_race_results.count
    @finished_count = all_race_results.where(status: 'FINISHED').count
    @dnf_dns_count = @participants_count - @finished_count
    
    @category_stats = calculate_category_stats(all_race_results)
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
    
    race_results.each do |result|
      category_name = result.category_snapshot&.name || 'Unknown'
      stats[category_name] ||= { count: 0, winner: nil, winner_time: Float::INFINITY }
      stats[category_name][:count] += 1
      
      if result.total_time_ms && result.total_time_ms < stats[category_name][:winner_time]
        stats[category_name][:winner] = result
        stats[category_name][:winner_time] = result.total_time_ms
      end
    end
    
    stats
  end
end