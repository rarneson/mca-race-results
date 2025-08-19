require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class PineValley2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 6 - Pine Valley Cloquet MN - Official Results") && 
      text.include?("Oct 5-6 2024") &&
      text.include?("Division:")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_pine_valley_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_pine_valley_race_info(text)
      {
        name: "Race 6 - Pine Valley Cloquet MN - Official Results",
        race_date: Date.parse("October 5, 2024"),
        location: "Pine Valley Cloquet MN",
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
          result = parse_pine_valley_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def parse_pine_valley_result_line(line, division)
      return nil if line.strip.empty?
      
      # Pine Valley format: Place Name Team Rider# Plate Laps Penalty Comment Total Lap1 [Lap2...]
      # Use rider number (9-digit) and plate number (4-digit) as anchors for parsing
      # Pattern: Place + Name + Team + RiderNumber + Plate + Laps + [Penalty] + [Comment] + Times...
      
      # First, try to find the rider number and plate number to establish boundaries
      rider_match = line.match(/(\d{9})\s+(\d{4})\s+(\d+)/)
      return nil unless rider_match
      
      rider_number = rider_match[1]
      plate_number = rider_match[2]
      laps = rider_match[3].to_i
      
      # Find position of rider number in the line
      rider_pos = line.index(rider_number)
      name_team_section = line[0...rider_pos].strip
      after_laps_section = line[(rider_match.end(0))..-1].strip
      
      # Parse name and team from the beginning section
      # Look for place number at start
      place_match = name_team_section.match(/^(\d+)\s+(.+)/)
      return nil unless place_match
      
      place = place_match[1].to_i
      name_team_text = place_match[2].strip
      
      # Pine Valley has very wide spacing between name and team
      # Look for multiple consecutive spaces (usually 3+ spaces separate name from team)
      if name_team_text.match(/^(.+?)\s{3,}(.+)$/)
        full_name = $1.strip
        team_name = $2.strip
      else
        # Fallback: try to identify team names by known patterns and work backwards
        team_patterns = [
          /\bEast\s+Ridge\s+HS\b/,        # "East Ridge HS" (full match)
          /\bHopkins\s+HS\b/,             # "Hopkins HS"
          /\bEastview\s+HS\b/,            # "Eastview HS"
          /\bBloomington\s+Jefferson\b/,   # "Bloomington Jefferson"
          /\bCloquet-Esko-Carlton\b/,     # "Cloquet-Esko-Carlton"
          /\bMounds\s+View\s+HS\b/,       # "Mounds View HS"
          /\bCrosby-Ironton\s+HS\b/,      # "Crosby-Ironton HS"
          /\bPrior\s+Lake\s+HS\b/,        # "Prior Lake HS"
          /\bApple\s+Valley\s+HS\b/,      # "Apple Valley HS"
          /\bSt\s+Paul\s+Composite\s+-\s+\w+\b/, # "St Paul Composite - North/South"
          /\bTioga\s+Trailblazers\b/,     # "Tioga Trailblazers"
          /\bLake\s+Area\s+Composite\b/,  # "Lake Area Composite"
          /\bTotino\s+Grace-Irondale\b/,  # "Totino Grace-Irondale"
          /\bRochester\s+Area\b/,         # "Rochester Area"
          /\bArmstrong\s+Cycle\b/,        # "Armstrong Cycle"
          /\bEdina\s+Cycling\b/,          # "Edina Cycling"
          /\b\w+\s+HS\b/,                 # Generic "Something HS"
          /\b\w+\s+MS\b/,                 # Generic "Something MS"
          /\bSt\s+Cloud\b/,               # "St Cloud"
          /\bRock\s+Ridge\b/,             # "Rock Ridge"
          /\bBorealis\b/,                 # "Borealis"
          /\bRoseville\b/,                # "Roseville"
          /\bWinona\b/,                   # "Winona"
          /\bOrono\b/,                    # "Orono"
          /\bRockford\b/,                 # "Rockford"
          /\bEagan\b/                     # "Eagan"
        ]
        
        team_start_pos = nil
        team_pattern_match = nil
        
        # Find the rightmost (last) team pattern match
        team_patterns.each do |pattern|
          if match_data = name_team_text.match(pattern)
            if team_start_pos.nil? || match_data.begin(0) > team_start_pos
              team_start_pos = match_data.begin(0)
              team_pattern_match = match_data[0]
            end
          end
        end
        
        if team_start_pos && team_start_pos > 0
          # Found a team pattern, split there
          full_name = name_team_text[0...team_start_pos].strip
          team_name = name_team_text[team_start_pos..-1].strip
        else
          # Try TeamNameExtractor for better team extraction
          extracted_team = TeamNameExtractor.extract_team_name(name_team_text)
          if extracted_team && name_team_text.include?(extracted_team)
            # Remove team name to get racer name
            full_name = name_team_text.gsub(extracted_team, '').strip.gsub(/\s+/, ' ')
            team_name = extracted_team
          else
            # Last resort: split at approximately 2/3 point or after first 2 words
            words = name_team_text.split(/\s+/)
            if words.length >= 3
              # Assume first 2 words are name, rest is team
              full_name = words[0..1].join(" ")
              team_name = words[2..-1].join(" ")
            else
              full_name = words[0] || ""
              team_name = words[1..-1]&.join(" ") || ""
            end
          end
        end
      end
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_pine_valley_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Parse times from after_laps_section
      # CRITICAL FIX: The line may contain multiple racers - stop at next rider number pattern
      # Find the end of this racer's data by looking for the next rider number
      next_rider_pattern = /\s+\d{9}\s+\d{4}\s+\d+/
      next_rider_match = after_laps_section.match(next_rider_pattern)
      
      if next_rider_match
        # Truncate to only this racer's data
        racer_section = after_laps_section[0...next_rider_match.begin(0)]
      else
        racer_section = after_laps_section
      end
      
      # Look for HH:MM:SS.s pattern times in this racer's section only
      time_pattern = /\d{2}:\d{2}:\d{2}\.\d+/
      times = racer_section.scan(time_pattern)
      
      # First time is total, rest are lap times (should match expected lap count)
      total_time = times.first
      expected_lap_times = times[1..laps] || []  # Take exactly 'laps' number of lap times
      lap_times = expected_lap_times
      
      # Handle DNF/DNS cases where there might be no times
      if total_time.nil?
        if after_laps_section.include?("DNF")
          total_time = ""
          status = "dnf"
        elsif after_laps_section.include?("DNS")
          total_time = ""
          status = "dns"
        else
          return nil # Skip malformed lines
        end
      else
        status = determine_status(line, laps)
      end
      
      # Clean time format (remove leading 00: if present for consistency)
      cleaned_total_time = total_time.sub(/^00:/, "") if total_time.present?
      cleaned_lap_times = lap_times.map { |time| time.sub(/^00:/, "") }
      
      {
        place: place,
        first_name: first_name,
        last_name: last_name,
        total_time: cleaned_total_time || "",
        team_name: team_name,
        racer_number: rider_number,
        category: division,
        plate_number: plate_number,
        laps_completed: laps,
        status: status,
        division: extract_division_from_category(division),
        lap_times: cleaned_lap_times
      }
    end

    def clean_pine_valley_name(name)
      # Pine Valley uses proper case, convert to uppercase for consistency
      name.strip.upcase
    end
  end
end