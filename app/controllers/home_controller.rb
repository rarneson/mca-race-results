class HomeController < ApplicationController
  layout "hud"

  def index
    @available_years = Race.available_years
    @selected_year = parse_selected_year(params[:year], @available_years)

    races_in_year = Race.in_year(@selected_year).order(race_date: :asc)
    @season_races = races_in_year.to_a

    @season_race_count = @season_races.size
    @season_racer_count = Racer.active_in_year(@selected_year).count
    @season_team_count = Team.joins(racers: { racer_seasons: { race_results: :race } })
                              .merge(Race.in_year(@selected_year))
                              .distinct
                              .count
  end

  private

  def parse_selected_year(param, available_years)
    requested = param.to_i
    return requested if available_years.include?(requested)
    available_years.first || Date.current.year
  end
end
