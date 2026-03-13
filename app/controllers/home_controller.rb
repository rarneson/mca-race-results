class HomeController < ApplicationController
  def index
    @total_races = Race.count
    @total_racers = Racer.count
    @total_teams = Team.count
    @seasons = Race.available_years
    @races_by_year = Race.all.order(race_date: :desc).group_by { |race| race.race_date.year }
  end
end
