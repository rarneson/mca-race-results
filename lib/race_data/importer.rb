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
        race.series = race_data[:series]
      end
    end

    def import_result(race, result_data)
      team = find_or_create_team(result_data[:team])
      racer = find_or_create_racer(result_data[:racer], team)
      racer_season = find_or_create_racer_season(racer, race.year, result_data[:result])
      
      # Find the appropriate racer_season_assignment for the race date
      assignment = find_assignment_for_date(racer_season, race.race_date)
      
      race_result = create_race_result(race, racer_season, assignment, result_data[:result])
      
      # Import lap times if available
      create_lap_times(race_result, result_data[:lap_times])
      
      race_result
    end

    def find_or_create_team(team_data)
      return nil if team_data[:name].blank?
      
      Team.find_or_create_by(name: team_data[:name])
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
      RaceResult.create!(
        race: race,
        racer_season: racer_season,
        racer_season_assignment: assignment,
        place: result_data[:place],
        total_time_ms: result_data[:total_time_ms],
        total_time_raw: result_data[:total_time_raw],
        laps_completed: result_data[:laps_completed],
        laps_expected: result_data[:laps_expected],
        status: result_data[:status],
        category_snapshot: result_data[:category_snapshot],
        plate_number_snapshot: result_data[:plate_number_snapshot]
      )
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
          cumulative_time_ms: cumulative_time
        )
      end
    end
  end
end