class RacesController < ApplicationController
  include BackNavigable
  layout "hud"

  TOP_FINISHERS_FOR_LAP_CHART = 5

  def index
    races = Race.all.order(race_date: :asc)
    @races_by_year = races.group_by { |race| race.race_date.year }
  end

  def show
    @race = Race.includes(race_results: [ racer_season: [ racer: :team ], category: [], race_result_laps: [] ])
                .find_by!(slug: params[:id])

    # Get all race results for stats calculation
    all_race_results = @race.race_results
                            .joins(racer_season: :racer)
                            .includes(racer_season: [ racer: :team ], category: [], race_result_laps: [])
                            .order(Arel.sql("CASE WHEN place IS NULL THEN 1 ELSE 0 END, place"))

    # Filter by category if specified, otherwise show first category with results
    @selected_category = params[:category]
    if @selected_category.present?
      @race_results = all_race_results.joins(:category)
                                      .where(categories: { name: @selected_category })
    else
      # Default to first category with results
      first_category = all_race_results.joins(:category)
                                      .group("categories.name")
                                      .order("categories.name")
                                      .limit(1)
                                      .pluck("categories.name")
                                      .first

      if first_category
        @selected_category = first_category
        @race_results = all_race_results.joins(:category)
                                        .where(categories: { name: @selected_category })
      else
        @race_results = all_race_results
        @selected_category = "Unknown"
      end
    end

    @overall_winner = @race_results.first
    @fastest_lap = find_fastest_lap(@race_results)
    @average_time = calculate_average_time(@race_results)
    @participants_count = @race_results.count
    @finished_count = @race_results.finished.count
    @dnf_dns_count = @participants_count - @finished_count

    @category_stats = calculate_category_stats(all_race_results)

    @back_path, @back_text = determine_back_path(default_path: races_path, default_text: "Back to Races")

    # Calculate maximum number of laps for dynamic lap columns based on filtered results
    @max_laps = @race_results.joins(:race_result_laps)
                             .maximum("race_result_laps.lap_number") || 0
  end

  def compare
    @race = Race.find_by!(slug: params[:id])

    requested_ids = Array(params[:racer_season_ids]).map(&:to_i).reject(&:zero?).uniq.first(2)

    @results = if requested_ids.size == 2
      @race.race_results
           .where(racer_season_id: requested_ids)
           .includes(racer_season: { racer: :team }, category: [], race_result_laps: [])
           .to_a
           .sort_by { |r| requested_ids.index(r.racer_season_id) || 99 }
    else
      []
    end

    @back_category = compare_referer_category || compare_shared_category(@results)
    @back_path, @back_text = determine_back_path(default_path: race_path(@race), default_text: "Back to Race")
    if @back_text == "Back to Race" && @back_category.present?
      @back_path = race_path(@race, category: @back_category)
    end

    if @results.size < 2
      @comparison_ready = false
      return
    end

    @comparison_ready = true
    @racer_a, @racer_b = @results
    @laps_a = @racer_a.race_result_laps.sort_by(&:lap_number)
    @laps_b = @racer_b.race_result_laps.sort_by(&:lap_number)
    @max_compare_laps = [ @laps_a.size, @laps_b.size ].max
    @min_compare_laps = [ @laps_a.size, @laps_b.size ].min
    @cross_category = @racer_a.category_id.present? && @racer_b.category_id.present? && @racer_a.category_id != @racer_b.category_id
  end

  private

  def compare_referer_category
    referer = request.referer
    return nil if referer.blank?
    uri = begin
      URI.parse(referer)
    rescue URI::InvalidURIError
      return nil
    end
    return nil unless uri.path == race_path(@race)
    Rack::Utils.parse_nested_query(uri.query.to_s)["category"].presence
  end

  def compare_shared_category(results)
    return nil if results.size != 2
    cat_a = results[0].category&.name
    cat_b = results[1].category&.name
    cat_a if cat_a.present? && cat_a == cat_b
  end

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
    times = race_results.select { |r| r.finished? && r.total_time_ms }.map(&:total_time_ms)
    return 0 if times.empty?

    times.sum / times.size
  end

  def calculate_category_stats(race_results)
    stats = {}

    # Initialize all categories with zero counts, respecting sort_order
    Category.by_sort_order.each do |category|
      stats[category.name] = { count: 0, winner: nil, winner_time: Float::INFINITY }
    end

    # Count race results for each category
    race_results.each do |result|
      category_name = result.category&.name || "Unknown"
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
