module RaceData
  class Importer
    def initialize(normalized_data)
      @normalized_data = normalized_data
    end

    def import!
      ActiveRecord::Base.transaction do
        race = create_or_find_race(@normalized_data[:race])
        
        @normalized_data[:results].each do |result_data|
          import_result(race, result_data)
        end
        
        race
      end
    end

    private

    def create_or_find_race(race_data)
      Race.find_or_create_by(
        name: race_data[:name],
        race_date: race_data[:race_date]
      ) do |race|
        race.location = race_data[:location]
        race.year = race_data[:year]
      end
    end

    def import_result(race, result_data)
      team = find_or_create_team(result_data[:team], result_data[:division])
      racer = find_or_create_racer(result_data[:racer], team)
      racer_season = find_or_create_racer_season(racer, race.year, result_data[:result])
      
      # Find the appropriate racer_season_assignment for the race date
      assignment = find_assignment_for_date(racer_season, race.race_date)
      
      race_result = create_race_result(race, racer_season, assignment, result_data[:result])
      
      # Import lap times if available
      create_lap_times(race_result, result_data[:lap_times])
      
      race_result
    end

    def find_or_create_team(team_data, division)
      return nil if team_data[:name].blank?
      
      Team.find_or_create_by(name: team_data[:name]) do |team|
        # Only set division if it's explicitly provided (D1/D2 categories)
        team.division = division if division
      end
    end

    def find_or_create_racer(racer_data, team)
      Racer.find_or_create_by(
        first_name: racer_data[:first_name],
        last_name: racer_data[:last_name],
        team: team
      ) do |racer|
        racer.number = racer_data[:number]
      end
    end

    def find_or_create_racer_season(racer, year, result_data)
      RacerSeason.find_or_create_by(
        racer: racer,
        year: year
      ) do |season|
        season.category = result_data[:category_snapshot]
        season.plate_number = result_data[:plate_number_snapshot]
      end
    end

    def find_assignment_for_date(racer_season, race_date)
      # Find the assignment that was active on the race date
      assignment = racer_season.racer_season_assignments
        .where("start_on <= ? AND (end_on IS NULL OR end_on >= ?)", race_date, race_date)
        .first
      
      # If no assignment exists, create a default one
      if assignment.nil?
        assignment = racer_season.racer_season_assignments.create!(
          category: racer_season.category,
          start_on: Date.new(racer_season.year, 1, 1),
          end_on: Date.new(racer_season.year, 12, 31),
          reason: "Default season assignment"
        )
      end
      
      assignment
    end

    def create_race_result(race, racer_season, assignment, result_data)
      RaceResult.find_or_create_by(
        race: race,
        racer_season: racer_season
      ) do |race_result|
        race_result.racer_season_assignment = assignment
        race_result.place = result_data[:place]
        race_result.total_time_ms = result_data[:total_time_ms]
        race_result.total_time_raw = result_data[:total_time_raw]
        race_result.laps_completed = result_data[:laps_completed]
        race_result.laps_expected = result_data[:laps_expected]
        race_result.status = result_data[:status]
        race_result.category_snapshot = result_data[:category_snapshot]
        race_result.plate_number_snapshot = result_data[:plate_number_snapshot]
      end
    end

    def create_lap_times(race_result, lap_times_data)
      return if lap_times_data.blank?
      
      cumulative_time = 0
      
      lap_times_data.each do |lap_data|
        cumulative_time += lap_data[:lap_time_ms] if lap_data[:lap_time_ms]
        
        RaceResultLap.create!(
          race_result: race_result,
          lap_number: lap_data[:lap_number],
          lap_time_ms: lap_data[:lap_time_ms],
          lap_time_raw: lap_data[:lap_time_raw],
          cumulative_time_ms: cumulative_time,
          cumulative_time_raw: format_time_ms(cumulative_time)
        )
      end
    end

    private

    def format_time_ms(time_ms)
      return nil if time_ms.nil? || time_ms == 0
      
      total_seconds = time_ms / 1000.0
      minutes = (total_seconds / 60).to_i
      seconds = total_seconds % 60
      
      if minutes >= 60
        hours = minutes / 60
        minutes = minutes % 60
        sprintf("%d:%02d:%04.1f", hours, minutes, seconds)
      else
        sprintf("%d:%04.1f", minutes, seconds)
      end
    end
  end
end