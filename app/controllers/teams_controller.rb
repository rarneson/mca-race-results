class TeamsController < ApplicationController
  include TeamsHelper
  include BackNavigable
  layout "hud"
  before_action :set_team, only: %i[ show ]

  # GET /teams or /teams.json
  def index
    # Get available years for the dropdown
    @available_years = Race.available_years

    # Get selected year or default to most recent year with data
    @selected_year = params[:year]&.to_i || @available_years.first || Date.current.year

    # Get teams that had racers compete in the selected year
    teams_in_year = Team.where(id: Team.joins(racers: { racer_seasons: { race_results: :race } })
                                       .merge(Race.in_year(@selected_year))
                                       .select(:id))

    # Apply search filter within the selected year if present
    if params[:search].present?
      @search_query = params[:search].strip
      teams_in_year = teams_in_year.where("teams.name LIKE ?", "%#{@search_query}%")
    end

    filtered_team_ids = teams_in_year.pluck(:id)

    # Get teams with racer counts for the year
    @teams = Team.where(id: filtered_team_ids)
                 .left_joins(racers: { racer_seasons: { race_results: :race } })
                 .merge(Race.in_year(@selected_year))
                 .group("teams.id")
                 .select("teams.*, COUNT(DISTINCT racers.id) as racers_count")
                 .order("teams.name")

    # Calculate overall statistics for the selected year, scoped to the search
    @total_teams = filtered_team_ids.count
    racers_in_year = Racer.active_in_year(@selected_year)
    racers_in_year = racers_in_year.where(team_id: filtered_team_ids) if @search_query.present?
    @total_racers = racers_in_year.count

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            "teams_table",
            partial: "teams/teams_table",
            locals: { teams: @teams, selected_year: @selected_year, search_query: @search_query }
          ),
          turbo_stream.update(
            "teams_count",
            partial: "teams/teams_count",
            locals: { total_teams: @total_teams, total_racers: @total_racers, selected_year: @selected_year }
          ),
          turbo_stream.update(
            "teams_filters",
            partial: "teams/teams_filters",
            locals: { available_years: @available_years, selected_year: @selected_year, search_query: @search_query }
          )
        ], content_type: "text/vnd.turbo-stream.html"
      end
    end
  end

  # GET /teams/1 or /teams/1.json
  def show
    # Load team and eager-load associations to avoid N+1 queries
    @team = Team.includes(racers: [
      { race_results: [ :category, :race ] }
    ]).find_by!(slug: params[:id])

    # Get available years for the dropdown
    @available_years = Race.available_years

    # Get selected year or default to most recent year with data
    @selected_year = params[:year]&.to_i || @available_years.first || Date.current.year

    # Calculate team statistics for the selected year
    @team_stats = calculate_team_stats(@team, @selected_year)

    # Group racers by category for roster display, filtered by year
    @racers_by_category = group_racers_by_category(@team.racers.active_in_year(@selected_year), @selected_year)

    @back_path, @back_text = determine_back_path(default_path: teams_path, default_text: "Back to Teams")
  end

  private

  def set_team
    @team = Team.find_by!(slug: params.expect(:id))
  end

  def calculate_team_stats(team, year = Date.current.year)
    # Filter race results by year
    all_race_results = team.racers.flat_map do |racer|
      racer.race_results.joins(:race).merge(Race.in_year(year))
    end

    racers_in_year = team.racers.active_in_year(year)

    stats = {
      total_racers: racers_in_year.count,
      total_wins: all_race_results.count { |result| result.place == 1 },
      total_podiums: all_race_results.count { |result| result.place && result.place <= 5 },
      best_finish: all_race_results.map(&:place).compact.min || nil
    }

    stats
  end
end
