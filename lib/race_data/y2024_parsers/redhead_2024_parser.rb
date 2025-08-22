require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class Redhead2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race7Readhead-OfficialResults") && 
      text.include?("10/12/2024-10/13/2024") &&
      text.include?("RaceTiming&ResultsbyPrecisionRaceLLC")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_redhead_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_redhead_race_info(text)
      {
        name: "Race 7 - Redhead Official Results",
        race_date: Date.parse("October 12, 2024"),
        location: "Redhead",
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
          raw_division = line.sub("Division:", "").strip
          current_division = convert_concatenated_division_to_category(raw_division)
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
          parsed_results = parse_redhead_result_line_with_splits(line, current_division)
          results.concat(parsed_results) if parsed_results.any?
        end
      end
      
      results
    end

    def parse_redhead_result_line_with_splits(line, division)
      # Check if line contains multiple rider numbers (indicating multiple racers on one line)
      rider_numbers = line.scan(/\d{8,9}/)
      
      if rider_numbers.length <= 1
        # Single racer line - use original parsing
        result = parse_redhead_result_line(line, division)
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
              result = parse_redhead_result_line(clean_racer_line, division)
              results << result if result
            end
          end
        end
        
        return results
      end
    end

    def parse_redhead_result_line(line, division)
      return nil if line.strip.empty?
      
      # Redhead format has concatenated text like "HazelWoeste HopkinsHS"
      # Use rider number and plate as anchors to work backwards
      rider_match = line.match(/(\d{9})\s+(\d{1,4})\s+(\d+)/)
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
      
      # Split concatenated name and team - look for team patterns
      full_name, team_name = split_redhead_name_team(name_team_text)
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_redhead_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Parse times from after_laps_section
      # CRITICAL FIX: The line may contain multiple racers - stop at next rider number pattern
      # Find the end of this racer's data by looking for the next rider number
      next_rider_pattern = /\s+\d{9}\s+\d{1,4}\s+\d+/
      next_rider_match = after_laps_section.match(next_rider_pattern)
      
      if next_rider_match
        # Truncate to only this racer's data
        racer_section = after_laps_section[0...next_rider_match.begin(0)]
      else
        racer_section = after_laps_section
      end
      
      # Look for MM:SS.S pattern times in this racer's section only
      time_pattern = /\d{2}:\d{2}:\d+\.\d+/
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
        elsif after_laps_section.include?("DQ")
          total_time = ""
          status = "dsq"
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

    def split_redhead_name_team(name_team_text)
      # Redhead has concatenated text like "LoganFuchsStMichael/Albertville"
      # Handle special cases with Mc/Mac prefixes first
      
      # Special handling for Mc/Mac names that are being split incorrectly
      # These patterns match the problematic cases we found
      if name_team_text.match(/^(\w+)Mc([A-Z][a-z]+)(.+)$/)
        # Pattern: FirstnameMcLastnameTeam (e.g., "EthanMcDonaldMoundWestonka")
        first_name = $1
        mc_lastname = "Mc#{$2}"
        team_part = $3
        
        # Clean up team part
        team_name = clean_redhead_team_name(team_part)
        full_name = "#{first_name} #{mc_lastname}"
        
        return [full_name, team_name]
      elsif name_team_text.match(/^(\w+)Mac([A-Z][a-z]+)(.+)$/)
        # Pattern: FirstnameMacLastnameTeam (e.g., "RylanMacAdamsBloomington")
        first_name = $1
        mac_lastname = "Mac#{$2}"
        team_part = $3
        
        # Clean up team part
        team_name = clean_redhead_team_name(team_part)
        full_name = "#{first_name} #{mac_lastname}"
        
        return [full_name, team_name]
      end
      
      # Use better patterns that match the actual concatenated format
      team_patterns = [
        # Specific team patterns (most specific first)
        /StillwaterMountainBike/i,       # "StillwaterMountainBike"
        /StillwaterMountain/i,           # "StillwaterMountain"
        /St\.?Michael\/Albertville/i,    # "StMichael/Albertville"
        /St\.?Paul.*Composite.*North/i,  # "StPaulComposite-North"
        /St\.?Paul.*Composite.*South/i,  # "StPaulComposite-South"
        /St\.?Paul.*Composite/i,         # "StPaulComposite"
        /St\.?Paul.*Central/i,           # "StPaulCentral"
        /Minneapolis.*Roosevelt.*HS/i,   # "MinneapolisRooseveltHS"
        /Minneapolis.*Southwest.*HS/i,   # "MinneapolisSouthwestHS"
        /Minneapolis.*Washburn.*HS/i,    # "MinneapolisWashburnHS"
        /Minneapolis.*South.*HS/i,       # "MinneapolisSouthHS"
        /Minneapolis.*Southside/i,       # "MinneapolisSouthside"
        /Minneapolis.*\w+/i,             # Generic "MinneapolisSomething"
        /BloomingtonJefferson/i,         # "BloomingtonJefferson"
        /Bloomington/i,                  # "Bloomington"
        /Cloquet-?Esko-?Carlton/i,       # "Cloquet-Esko-Carlton"
        /RochesterArea/i,                # "RochesterArea"
        /TiogaTrailblazers/i,            # "TiogaTrailblazers"
        /LakeAreaComposite/i,            # "LakeAreaComposite"
        /TotinoGrace-?Irondale/i,        # "TotinoGrace-Irondale"
        /MinnesotaValley/i,              # "MinnesotaValley"
        /NewPragueMSandHS/i,             # "NewPragueMSandHS"
        /NewPragueMS/i,                  # "NewPragueMS"
        /AlexandriaYouthCycling/i,       # "AlexandriaYouthCycling"
        /ArmstrongCycle/i,               # "ArmstrongCycle"
        /EdinaCycling/i,                 # "EdinaCycling"
        /WayzataMountainBike/i,          # "WayzataMountainBike"
        /MoundWestonka/i,                # "MoundWestonka"
        /AppleValleyHS/i,                # "AppleValleyHS"
        /LakevilleNorthHS/i,             # "LakevilleNorthHS"
        /LakevilleSouthHS/i,             # "LakevilleSouthHS"
        /MoundsViewHS/i,                 # "MoundsViewHS"
        /MinnetonkaHS/i,                 # "MinnetonkaHS"
        /BrainerdHS/i,                   # "BrainerdHS"
        /Crosby-?IrontonHS/i,            # "Crosby-IrontonHS"
        /PriorLakeHS/i,                  # "PriorLakeHS"
        /WoodburyHS/i,                   # "WoodburyHS"
        /ShakopeeHS/i,                   # "ShakopeeHS"
        /HopkinsHS/i,                    # "HopkinsHS"
        /EastviewHS/i,                   # "EastviewHS" 
        /EastRidgeHS/i,                  # "EastRidgeHS"
        /MapleGroveHS/i,                 # "MapleGroveHS"
        /EaganHS/i,                      # "EaganHS"
        /ElkRiver/i,                     # "ElkRiver"
        /RockRidge/i,                    # "RockRidge"
        /StCloud/i,                      # "StCloud"
        /Roseville/i,                    # "Roseville"
        /Winona/i,                       # "Winona"
        /Borealis/i,                     # "Borealis"
        /Rockford/i,                     # "Rockford"
        /Hastings/i,                     # "Hastings"
        /Bemidji/i,                      # "Bemidji"
        /Kerkhoven/i,                    # "Kerkhoven"
        /\w+HS$/i,                       # Generic "SomethingHS"
        /\w+MS$/i,                       # Generic "SomethingMS"
        /MountainBike$/i,                # "MountainBike"
        /Bike$/i,                        # "Bike"
        /River$/i,                       # "River"
        /Elk$/i                          # "Elk" (for ElkRiver)
      ]
      
      # Find the first team pattern match
      team_start_pos = nil
      team_match = nil
      
      team_patterns.each do |pattern|
        if match_data = name_team_text.match(pattern)
          team_start_pos = match_data.begin(0)
          team_match = match_data[0]
          break
        end
      end
      
      if team_start_pos && team_start_pos > 0
        # Found a team pattern, split there
        full_name = name_team_text[0...team_start_pos]
        team_name = team_match
        
        # Clean up team name format
        team_name = clean_redhead_team_name(team_name)
        
        # Insert spaces in camelCase names
        full_name = full_name.gsub(/([a-z])([A-Z])/, '\1 \2')
      else
        # Fallback: Handle concatenated text without clear team patterns
        # Split on capital letters to identify word boundaries
        words = name_team_text.split(/(?=[A-Z][a-z])/).reject(&:empty?)
        
        if words.length >= 2
          # Common case: FirstnameLastname or FirstnameLastnameTeamname
          if words.length == 2
            # Just FirstnameLastname - no team found
            full_name = words.join(" ")
            team_name = ""
          elsif words.length >= 3
            # FirstnameLastnameTeamname - assume first 2 are name
            full_name = words[0..1].join(" ")
            remaining_words = words[2..-1]
            
            # Check if remaining words might be a team
            potential_team = remaining_words.join("")
            if potential_team.length > 2
              team_name = remaining_words.join(" ")
            else
              # Very short remaining text, probably part of name
              full_name = words.join(" ")
              team_name = ""
            end
          end
        else
          # Single word or can't split properly
          full_name = name_team_text
          team_name = ""
        end
      end
      
      # Use TeamNameExtractor as final validation/fallback
      if team_name.present? && team_name.length <= 10 && !team_name.match(/HS$|Bike$|Cycling$|Composite$/)
        # Team name looks suspicious (too short, no common endings)
        # Try TeamNameExtractor on the full text
        extracted_team = TeamNameExtractor.extract_team_name(name_team_text)
        if extracted_team && extracted_team != team_name
          # TeamNameExtractor found a better match
          team_name = extracted_team
          # Recalculate name by removing the extracted team
          full_name = name_team_text.gsub(extracted_team, '').strip.gsub(/\s+/, ' ')
        end
      end
      
      [full_name || "", team_name || ""]
    end

    def convert_concatenated_division_to_category(raw_division)
      # Convert concatenated division names like "6thGradeGirls" to "6th Grade Girls"
      case raw_division
      when "6thGradeGirls"
        "6th Grade Girls"
      when "6thGradeBoysD1"
        "6th Grade Boys D1"
      when "6thGradeBoysD2"
        "6th Grade Boys D2"
      when "7thGradeGirls"
        "7th Grade Girls"
      when "7thGradeBoysD1"
        "7th Grade Boys D1"
      when "7thGradeBoysD2"
        "7th Grade Boys D2"
      when "8thGradeGirls"
        "8th Grade Girls"
      when "8thGradeBoysD1"
        "8th Grade Boys D1"
      when "8thGradeBoysD2"
        "8th Grade Boys D2"
      when "FreshmanGirls"
        "Freshman Girls"
      when "FreshmanBoysD1"
        "Freshman Boys D1"
      when "FreshmanBoysD2"
        "Freshman Boys D2"
      when "JV2Girls"
        "JV2 Girls"
      when "JV2BoysD1"
        "JV2 Boys D1"
      when "JV2BoysD2"
        "JV2 Boys D2"
      when "JV3Girls"
        "JV3 Girls"
      when "JV3Boys"
        "JV3 Boys"
      when "VarsityGirls"
        "Varsity Girls"
      when "VarsityBoys"
        "Varsity Boys"
      else
        # Fallback: try to add spaces between camelCase words
        raw_division.gsub(/([a-z])([A-Z])/, '\1 \2')
      end
    end

    def clean_redhead_name(name)
      # Redhead uses proper case, convert to uppercase for consistency
      # Also clean up any concatenation artifacts
      cleaned = name.strip.upcase
      
      # Fix common concatenation issues
      cleaned = cleaned.gsub(/([a-z])([A-Z])/, '\1 \2') # Add space between camelCase
      
      cleaned
    end

    def clean_redhead_team_name(team_name)
      # Convert concatenated team names to proper format
      case team_name.downcase
      when /stillwatermountainbike/i
        "Stillwater Mountain Bike"
      when /stillwatermountain/i
        "Stillwater Mountain Bike"
      when /st\.?michael\/albertville/i
        "St Michael/Albertville"
      when /st\.?paul.*composite.*north/i
        "St Paul Composite - North"
      when /st\.?paul.*composite.*south/i
        "St Paul Composite - South"
      when /st\.?paul.*composite/i
        "St Paul Composite"
      when /minneapolis.*roosevelt.*hs/i
        "Minneapolis Roosevelt HS"
      when /minneapolis.*southwest.*hs/i
        "Minneapolis Southwest HS"
      when /minneapolis.*washburn.*hs/i
        "Minneapolis Washburn HS"
      when /minneapolis.*south.*hs/i
        "Minneapolis South HS"
      when /minneapolis.*southside/i
        "Minneapolis Southside"
      when /minneapolis/i
        "Minneapolis"
      when /elkriver/i
        "Elk River"
      when /elk/i
        "Elk River"
      when /wayzatamountainbike/i
        "Wayzata Mountain Bike"
      when /hopkinshs/i
        "Hopkins HS"
      when /eastviewhs/i
        "Eastview HS"
      when /eastridgehs/i
        "East Ridge HS"
      when /rockridge/i
        "Rock Ridge"
      when /armstrongcycle/i
        "Armstrong Cycle"
      when /edinacycling/i
        "Edina Cycling"
      when /bloomingtonjefferson/i
        "Bloomington Jefferson"
      when /stcloud/i
        "St Cloud"
      when /rochesterarea/i
        "Rochester Area"
      when /tiogatrailblazers/i
        "Tioga Trailblazers"
      when /lakeareacomposite/i
        "Lake Area Composite"
      when /totinograce-?irondale/i
        "Totino Grace-Irondale"
      when /minnesotavalley/i
        "Minnesota Valley"
      when /newpraguems/i, /newpraguemsandhs/i
        "New Prague MS and HS"
      when /applevalleyhs/i
        "Apple Valley HS"
      when /lakevillenorthhs/i
        "Lakeville North HS"
      when /lakevillesouthhs/i
        "Lakeville South HS"
      when /moundsviewhs/i
        "Mounds View HS"
      when /shakopeehs/i
        "Shakopee HS"
      when /minnetonkahs/i
        "Minnetonka HS"
      when /brainerdhs/i
        "Brainerd HS"
      when /crosby-?irontonhs/i
        "Crosby-Ironton HS"
      when /priorlakehs/i
        "Prior Lake HS"
      when /woodburyhs/i
        "Woodbury HS"
      when /eaganhs/i
        "Eagan HS"
      when /maplegrovehs/i
        "Maple Grove HS"
      when /alexandriayouthcycling/i
        "Alexandria Youth Cycling"
      when /moundwestonka/i
        "Mound Westonka"
      when /bloomington/i
        "Bloomington"
      when /hastings/i
        "Hastings"
      when /bemidji/i
        "Bemidji"
      when /kerkhoven/i
        "Kerkhoven"
      when /roseville/i
        "Roseville"
      when /winona/i
        "Winona"
      when /borealis/i
        "Borealis"
      when /rockford/i
        "Rockford"
      when /mountainbike/i
        "Mountain Bike"
      when /bike/i
        "Bike"
      when /river/i
        "River"
      else
        # For unrecognized patterns, try to add spaces between camelCase
        team_name.gsub(/([a-z])([A-Z])/, '\1 \2')
      end
    end
  end
end