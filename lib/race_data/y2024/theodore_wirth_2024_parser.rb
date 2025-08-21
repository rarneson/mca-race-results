require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class TheodoreWirth2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 4N - Theodore Wirth Park Official Results") && 
      text.include?("September 21-22, 2024") &&
      text.include?("Division:")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_wirth_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_wirth_race_info(text)
      {
        name: "Race 4N - Theodore Wirth Park Official Results",
        race_date: Date.parse("September 21, 2024"),
        location: "Theodore Wirth Park",
        year: 2024,
        series: "Minnesota Cycling Association"
      }
    end

    def extract_results(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      results = []
      current_division = nil
      in_results_section = false
      
      lines.each_with_index do |line, index|
        # Check for new division
        if line.start_with?("Division:")
          current_division = line.sub("Division:", "").strip
          in_results_section = false
          next
        end
        
        # Skip header line after division (Place Name Team Name etc.)
        if current_division && line.include?("Place") && line.include?("Name") && line.include?("Team")
          in_results_section = true
          next
        end
        
        # Parse result lines (start with place number and have racer data)
        if in_results_section && current_division && line.match?(/^\s*\d+\s+/)
          # Handle lines that may contain multiple racers due to PDF extraction issues
          parsed_results = parse_wirth_result_line_with_splits(line, current_division)
          results.concat(parsed_results) if parsed_results.any?
        end
      end
      
      results
    end

    def parse_wirth_result_line_with_splits(line, division)
      # Check if line contains multiple rider numbers (indicating multiple racers on one line)
      rider_numbers = line.scan(/\d{8,9}/)
      
      if rider_numbers.length <= 1
        # Single racer line - use original parsing
        result = parse_wirth_result_line(line, division)
        return result ? [result] : []
      else
        # Multiple racers on one line - split them
        results = []
        
        # Split the line at each rider number boundary
        rider_numbers.each_with_index do |rider_number, idx|
          # Find the start position of this rider's data
          start_pos = line.index(rider_number)
          next unless start_pos
          
          # Find the end position (start of next rider or end of line)
          if idx < rider_numbers.length - 1
            next_rider_start = line.index(rider_numbers[idx + 1])
            racer_line = line[0...next_rider_start].strip
          else
            racer_line = line.strip
          end
          
          # Extract just this racer's data by finding place number before the rider number
          place_match = racer_line.match(/(\d+)\s+.*?#{Regexp.escape(rider_number)}/)
          if place_match
            # Reconstruct a clean line for this racer starting from the place number
            place_start = racer_line.rindex(place_match[1], start_pos)
            if place_start
              clean_racer_line = racer_line[place_start..-1]
              result = parse_wirth_result_line(clean_racer_line, division)
              results << result if result
            end
          end
        end
        
        return results
      end
    end

    def parse_wirth_result_line(line, division)
      return nil if line.strip.empty?
      
      # Theodore Wirth format: Place Name Team Rider# Plate Laps Penalty Comment Total Lap1...
      # Same as Mt Kato: Proper case names, 00:MM:SS.s time format
      match = line.match(/^\s*(\d+)\s+([A-Za-z\s\-\.]+?)\s{2,}([A-Za-z\s\-\.]+?)\s+(\d{8,9})\s+(\d{4})\s+(\d+)\s.*?(00:\d+:\d+\.\d+|\d+:\d+\.\d+)(.*)$/)
      
      return nil unless match
      
      place = match[1].to_i
      full_name = match[2].strip
      # Extract team using improved logic
      name_and_team_text = match[2].strip + ' ' + match[3].strip
      team_name = TeamNameExtractor.extract_team_name(name_and_team_text) || match[3].strip
      rider_number = match[4]
      plate_number = match[5]
      laps = match[6].to_i
      total_time = match[7]
      lap_times_text = match[8]&.strip
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_wirth_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Clean time format (remove leading 00: if present)
      cleaned_total_time = total_time.sub(/^00:/, "")
      
      # Determine status
      status = determine_status(line, laps)
      
      {
        place: place,
        first_name: first_name,
        last_name: last_name,
        total_time: cleaned_total_time,
        team_name: team_name,
        racer_number: rider_number,
        category: division,
        plate_number: plate_number,
        laps_completed: laps,
        status: status,
        division: extract_division_from_category(division),
        lap_times: parse_wirth_lap_times(lap_times_text)
      }
    end

    def clean_wirth_name(name)
      # Theodore Wirth uses proper case, convert to uppercase for consistency
      name.strip.upcase
    end

    def parse_wirth_lap_times(lap_times_text)
      return [] if lap_times_text.blank?
      
      # Extract time patterns, handling both 00:MM:SS.s and MM:SS.s formats
      time_pattern = /(00:\d+:\d+\.\d+|\d+:\d+\.\d+)/
      lap_times = lap_times_text.scan(time_pattern).flatten
      
      # Clean up times (remove 00: prefix) and return
      lap_times.uniq.map { |time| time.sub(/^00:/, "") }
    end
  end
end