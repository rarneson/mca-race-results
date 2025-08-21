require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class Whitetail2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 5N - Whitetail Ridge Official Results") && 
      text.include?("Sept 28-29 2024") &&
      text.include?("Division:")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_whitetail_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_whitetail_race_info(text)
      {
        name: "Race 5N - Whitetail Ridge Official Results",
        race_date: Date.parse("September 28, 2024"),
        location: "Whitetail Ridge",
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
          parsed_results = parse_whitetail_result_line_with_splits(line, current_division)
          results.concat(parsed_results) if parsed_results.any?
        end
      end
      
      results
    end

    def parse_whitetail_result_line_with_splits(line, division)
      # Check if line contains multiple rider numbers (indicating multiple racers on one line)
      rider_numbers = line.scan(/\d{8,9}/)
      
      if rider_numbers.length <= 1
        # Single racer line - use original parsing
        result = parse_whitetail_result_line(line, division)
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
              result = parse_whitetail_result_line(clean_racer_line, division)
              results << result if result
            end
          end
        end
        
        return results
      end
    end

    def parse_whitetail_result_line(line, division)
      return nil if line.strip.empty?
      
      # Whitetail format has two patterns:
      # Single lap: Place Name Team Rider# Plate Laps Adjust Comment Total Lap1
      # Multi lap: Place Name Team Rider# Plate Laps Total Lap1 Lap2 [Lap3] [Lap4]
      
      # Use improved parsing approach - find rider number first
      rider_match = line.match(/(\d{8,9})\s+(\d{4})\s+(\d+)\s+(.*?)$/)
      return nil unless rider_match
      
      rider_number = rider_match[1]
      plate_number = rider_match[2]
      laps = rider_match[3].to_i
      remaining_text = rider_match[4].strip
      
      # Extract place and name/team before rider number
      prefix_match = line.match(/^\s*(\d+)\s+(.+?)\s+#{Regexp.escape(rider_number)}/)
      return nil unless prefix_match
      
      place = prefix_match[1].to_i
      name_and_team_text = prefix_match[2].strip
      
      # Use TeamNameExtractor for better team extraction
      team_name = TeamNameExtractor.extract_team_name(name_and_team_text)
      
      # Extract name by removing team from the original text
      if team_name && name_and_team_text.include?(team_name)
        name_text = name_and_team_text.gsub(team_name, '').strip.gsub(/\s+/, ' ')
        full_name = name_text
      else
        # Fallback
        parts = name_and_team_text.split(/\s{2,}/)
        full_name = parts.first || name_and_team_text
        team_name ||= parts.last || "Unknown Team"
      end
      
      # Determine format based on remaining text structure
      if remaining_text.match?(/^\s*[^\s]*\s+[^\s]*\s+(00:\d+:\d+\.\d+)\s+(00:\d+:\d+\.\d+)\s*$/)
        # Single lap format
        return parse_single_lap_result_improved(place, full_name, team_name, rider_number, plate_number, laps, remaining_text, division, line)
      else
        # Multi-lap format  
        return parse_multi_lap_result_improved(place, full_name, team_name, rider_number, plate_number, laps, remaining_text, division, line)
      end
      
      nil
    end

    def parse_single_lap_result_improved(place, full_name, team_name, rider_number, plate_number, laps, remaining_text, division, line)
      # Extract times from remaining text for single lap format
      times_match = remaining_text.match(/^\s*([^\s]*)\s+([^\s]*)\s+(00:\d+:\d+\.\d+)\s+(00:\d+:\d+\.\d+)\s*$/)
      return nil unless times_match
      
      adjust = times_match[1]
      comment = times_match[2] 
      total_time = times_match[3]
      lap1_time = times_match[4]
      
      build_result_hash(place, full_name, team_name, rider_number, plate_number, laps, total_time, [lap1_time], division, line)
    end

    def parse_multi_lap_result_improved(place, full_name, team_name, rider_number, plate_number, laps, remaining_text, division, line)
      # Extract times for multi-lap format
      times_match = remaining_text.match(/^\s*(00:\d+:\d+\.\d+)(.*)$/)
      return nil unless times_match
      
      total_time = times_match[1]
      lap_times_text = times_match[2].strip
      
      # Extract individual lap times
      lap_times = lap_times_text.scan(/00:\d+:\d+\.\d+/)
      
      build_result_hash(place, full_name, team_name, rider_number, plate_number, laps, total_time, lap_times, division, line)
    end

    def build_result_hash(place, full_name, team_name, rider_number, plate_number, laps, total_time, lap_times, division, line)
      # Split name into first/last
      name_parts = full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      status = determine_status(line, laps)
      
      {
        place: place,
        first_name: first_name,
        last_name: last_name,
        team_name: team_name,
        rider_number: rider_number,
        plate_number: plate_number,
        total_time_raw: total_time,
        total_time_ms: parse_time_to_ms(total_time),
        laps_completed: laps,
        status: status,
        division: division,
        lap_times: lap_times.map.with_index(1) do |lap_time, lap_num|
          {
            lap_number: lap_num,
            lap_time_raw: lap_time,
            lap_time_ms: parse_time_to_ms(lap_time)
          }
        end
      }
    end

    def parse_single_lap_result(match, division, line)
      place = match[1].to_i
      full_name = match[2].strip
      team_name = match[3].strip
      rider_number = match[4]
      plate_number = match[5]
      laps = match[6].to_i
      adjust = match[7]  # Whitetail-specific Adjust column
      comment = match[8] # Whitetail-specific Comment column
      total_time = match[9]
      lap_time = match[10]
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_whitetail_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Clean time format (remove leading 00: if present)
      cleaned_total_time = total_time.sub(/^00:/, "")
      cleaned_lap_time = lap_time.sub(/^00:/, "")
      
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
        lap_times: [cleaned_lap_time]
      }
    end

    def parse_multi_lap_result(match, division, line)
      place = match[1].to_i
      full_name = match[2].strip
      team_name = match[3].strip
      rider_number = match[4]
      plate_number = match[5]
      laps = match[6].to_i
      total_time = match[7]
      lap_times_text = match[8]&.strip
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_whitetail_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Clean time format (remove leading 00: if present)
      cleaned_total_time = total_time.sub(/^00:/, "")
      
      # Parse lap times
      lap_times = parse_whitetail_lap_times(lap_times_text)
      
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
        lap_times: lap_times
      }
    end

    def clean_whitetail_name(name)
      # Whitetail uses proper case, convert to uppercase for consistency
      name.strip.upcase
    end

    def parse_whitetail_lap_times(lap_times_text)
      return [] if lap_times_text.blank?
      
      # Extract time patterns for 00:MM:SS.s format
      time_pattern = /00:\d+:\d+\.\d+/
      lap_times = lap_times_text.scan(time_pattern)
      
      # Clean up times (remove 00: prefix) and return
      lap_times.map { |time| time.sub(/^00:/, "") }
    end
  end
end