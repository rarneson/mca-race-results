require 'set'
require_relative 'team_name_extractor'

module RaceData
  class Importer
    def initialize(normalized_data)
      @normalized_data = normalized_data
      @unmatched_teams = Set.new
      @orphaned_racers = []
    end

    def import!
      ActiveRecord::Base.transaction do
        race = create_or_find_race(@normalized_data[:race])
        
        @normalized_data[:results].each do |result_data|
          import_result(race, result_data)
        end
        
        # Print summary after import
        print_import_summary(race)
        
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
      team = find_team(result_data[:team], result_data[:division])
      racer = find_or_create_racer(result_data[:racer], team)
      
      # Set racer gender from category if not already set
      if racer.gender.blank? && result_data[:result][:category_snapshot]
        racer.update!(gender: result_data[:result][:category_snapshot].gender)
      end
      
      racer_season = find_or_create_racer_season(racer, race.year, result_data[:result])
      
      # Find the appropriate racer_season_assignment for the race date
      assignment = find_assignment_for_date(racer_season, race.race_date)
      
      race_result = create_race_result(race, racer_season, assignment, result_data[:result])
      
      # Import lap times if available
      create_lap_times(race_result, result_data[:lap_times])
      
      race_result
    end

    def find_team(team_data, division)
      return nil if team_data[:name].blank?
      
      # First try exact match
      team = Team.find_by(name: team_data[:name])
      return team if team
      
      # Try using TeamNameExtractor to find a matching team
      extracted_team_name = RaceData::TeamNameExtractor.extract_team_name(team_data[:name])
      if extracted_team_name
        team = Team.find_by(name: extracted_team_name)
        return team if team
      end
      
      # Track unmatched team for summary
      @unmatched_teams.add(team_data[:name])
      
      # Return nil - racer will be orphaned
      nil
    end

    def find_or_create_racer(racer_data, team)
      racer = Racer.find_or_create_by(
        first_name: racer_data[:first_name],
        last_name: racer_data[:last_name],
        team: team
      ) do |new_racer|
        new_racer.number = racer_data[:number]
      end
      
      # Track orphaned racers for summary
      if team.nil? && !@orphaned_racers.any? { |r| r[:first_name] == racer_data[:first_name] && r[:last_name] == racer_data[:last_name] }
        @orphaned_racers << {
          first_name: racer_data[:first_name],
          last_name: racer_data[:last_name],
          number: racer_data[:number]
        }
      end
      
      racer
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

    def print_import_summary(race)
      puts "\n" + "="*60
      puts "RACE IMPORT SUMMARY"
      puts "="*60
      puts "Race: #{race.name} (#{race.race_date})"
      puts "Results imported: #{race.race_results.count}"
      
      if @unmatched_teams.any?
        puts "\n⚠️  UNMATCHED TEAMS FOUND (#{@unmatched_teams.size}):"
        puts "The following team names could not be matched to existing teams:"
        @unmatched_teams.sort.each do |team_name|
          puts "  - '#{team_name}'"
        end
        puts "\nConsider adding these to db/seeds.rb if they are legitimate teams."
      end
      
      if @orphaned_racers.any?
        puts "\n👤 ORPHANED RACERS (#{@orphaned_racers.size}):"
        puts "The following racers could not be assigned to teams:"
        @orphaned_racers.each do |racer|
          puts "  - #{racer[:first_name]} #{racer[:last_name]}"
        end
        puts "\nThese racers can be manually assigned to teams later."
      end
      
      if @unmatched_teams.empty? && @orphaned_racers.empty?
        puts "\n✅ All racers successfully matched to existing teams!"
      end
      
      puts "="*60
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