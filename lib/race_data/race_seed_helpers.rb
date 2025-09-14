module RaceData
  module RaceSeedHelpers
    # Time processing helpers
    def parse_time_to_ms(time_str)
      return nil if time_str.blank?
      
      time_str = time_str.to_s.strip
      
      # Extract hours, minutes, seconds, milliseconds
      if time_str.match(/(\d+):(\d+):(\d+)\.?(\d+)?/) # H:M:S.ms
        hours, minutes, seconds, ms = $1.to_i, $2.to_i, $3.to_i, ($4 || "0").ljust(3, '0')[0..2].to_i
        (hours * 3600 + minutes * 60 + seconds) * 1000 + ms
      elsif time_str.match(/(\d+):(\d+)\.?(\d+)?/) # M:S.ms
        minutes, seconds, ms = $1.to_i, $2.to_i, ($3 || "0").ljust(3, '0')[0..2].to_i
        (minutes * 60 + seconds) * 1000 + ms
      elsif time_str.match(/(\d+)\.?(\d+)?/) # S.ms
        seconds, ms = $1.to_i, ($2 || "0").ljust(3, '0')[0..2].to_i
        seconds * 1000 + ms
      else
        nil
      end
    end

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

    # Main import method for a division
    def import_division_results(race, category_name, results_data, expected_laps)
      puts "Creating #{race.name.split(' - ').first} #{category_name} results..."
      
      category = Category.find_by!(name: category_name)
      
      results_data.each do |result_data|
        import_single_result(race, category, result_data, expected_laps)
        print "."
      end
      
      puts "\n✓ #{race.name.split(' - ').first} #{category_name} results: #{results_data.count} racers imported"
    end

    private

    def import_single_result(race, category, result_data, expected_laps)
      # Handle flexible parameter formats - normalize the data
      place, first_name, last_name, team_name, rider_number, plate, laps, total_time, *lap_times, status = normalize_result_data(result_data, expected_laps)
      
      # Team lookup with error handling
      team = find_team_with_error_handling(team_name, first_name, last_name)
      return if team.nil?
      
      # Racer and season creation
      racer = find_or_create_racer(first_name, last_name, team, rider_number)
      racer_season = find_or_create_racer_season(racer, race.year, plate)
      
      # Race result creation  
      race_result = create_race_result(race, racer_season, category, place, total_time, laps, expected_laps, status, plate)
      
      # Lap processing
      create_lap_times(race_result, lap_times) if lap_times.any?
    end

    def normalize_result_data(result_data, expected_laps)
      # Handle different data formats
      if result_data.length > 11
        # New format: [place, first_name, last_name, team_name, rider_number, plate, points, total_time, lap1_time, lap2_time, lap3_time, status]
        place, first_name, last_name, team_name, rider_number, plate, points, total_time, *lap_times_and_status = result_data
        status = lap_times_and_status.pop
        lap_times = lap_times_and_status.compact
        laps = lap_times.length > 0 ? lap_times.length : expected_laps
      else
        # Standard format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
        place, first_name, last_name, team_name, rider_number, plate, laps, total_time, *lap_times_and_status = result_data
        status = lap_times_and_status.pop
        lap_times = lap_times_and_status.compact
      end
      
      [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, *lap_times, status]
    end

    def find_team_with_error_handling(team_name, first_name, last_name)
      team = Team.find_by(name: team_name)
      if team.nil?
        puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
        return nil
      end
      team
    end

    def find_or_create_racer(first_name, last_name, team, rider_number)
      Racer.find_or_create_by!(
        first_name: first_name,
        last_name: last_name,
        team: team
      ) do |r|
        r.number = rider_number
      end
    end

    def find_or_create_racer_season(racer, year, plate)
      RacerSeason.find_or_create_by!(
        racer: racer,
        year: year
      ) do |season|
        season.plate_number = plate
      end
    end

    def create_race_result(race, racer_season, category, place, total_time, laps, expected_laps, status, plate)
      RaceResult.find_or_create_by!(
        race: race,
        racer_season: racer_season
      ) do |result|
        result.place = place
        result.total_time_ms = parse_time_to_ms(total_time)
        result.total_time_raw = total_time
        result.laps_completed = laps
        result.laps_expected = expected_laps
        result.status = status
        result.category = category
        result.plate_number_snapshot = plate
      end
    end

    def create_lap_times(race_result, lap_times)
      cumulative_time = 0
      
      lap_times.each_with_index do |lap_time, index|
        next unless lap_time
        
        lap_number = index + 1
        lap_time_ms = parse_time_to_ms(lap_time)
        next if lap_time_ms.nil?  # Skip if time parsing failed
        
        cumulative_time += lap_time_ms
        
        RaceResultLap.find_or_create_by!(
          race_result: race_result,
          lap_number: lap_number
        ) do |lap|
          lap.lap_time_ms = lap_time_ms
          lap.lap_time_raw = lap_time
          lap.cumulative_time_ms = cumulative_time
          lap.cumulative_time_raw = format_time_ms(cumulative_time)
        end
      end
    end
  end
end