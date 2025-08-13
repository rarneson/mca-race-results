require_relative '../base_mca_parser'

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
          result = parse_redhead_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def parse_redhead_result_line(line, division)
      return nil if line.strip.empty?
      
      # Redhead format has concatenated text like "HazelWoeste HopkinsHS"
      # Use rider number and plate as anchors to work backwards
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
      
      # Split concatenated name and team - look for team patterns
      full_name, team_name = split_redhead_name_team(name_team_text)
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_redhead_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Parse times from after_laps_section
      # Look for MM:SS.S pattern times
      time_pattern = /\d{2}:\d{2}:\d+\.\d+/
      times = after_laps_section.scan(time_pattern)
      
      # First time is total, rest are lap times
      total_time = times.first
      lap_times = times[1..-1] || []
      
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
      # Use better patterns that match the actual concatenated format
      team_patterns = [
        # Specific team patterns (most specific first)
        /StillwaterMountainBike/i,       # "StillwaterMountainBike"
        /StillwaterMountain/i,           # "StillwaterMountain"
        /St\.?Michael\/Albertville/i,    # "StMichael/Albertville"
        /St\.?Paul.*Composite.*North/i,  # "StPaulComposite-North"
        /St\.?Paul.*Composite.*South/i,  # "StPaulComposite-South"
        /St\.?Paul.*Composite/i,         # "StPaulComposite"
        /Minneapolis.*Roosevelt.*HS/i,   # "MinneapolisRooseveltHS"
        /Minneapolis.*Southwest.*HS/i,   # "MinneapolisSouthwestHS"
        /Minneapolis.*Washburn.*HS/i,    # "MinneapolisWashburnHS"
        /Minneapolis.*South.*HS/i,       # "MinneapolisSouthHS"
        /Minneapolis.*Southside/i,       # "MinneapolisSouthside"
        /Minneapolis.*\w+/i,             # Generic "MinneapolisSomething"
        /BloomingtonJefferson/i,         # "BloomingtonJefferson"
        /Cloquet-?Esko-?Carlton/i,      # "Cloquet-Esko-Carlton"
        /RochesterArea/i,                # "RochesterArea"
        /TiogaTrailblazers/i,           # "TiogaTrailblazers"
        /LakeAreaComposite/i,           # "LakeAreaComposite"
        /TotinoGrace-?Irondale/i,        # "TotinoGrace-Irondale"
        /MinnesotaValley/i,             # "MinnesotaValley"
        /NewPragueMSandHS/i,            # "NewPragueMSandHS"
        /NewPragueMS/i,                 # "NewPragueMS"
        /AlexandriaYouthCycling/i,      # "AlexandriaYouthCycling"
        /ArmstrongCycle/i,              # "ArmstrongCycle"
        /EdinaCycling/i,                # "EdinaCycling"
        /WayzataMountainBike/i,         # "WayzataMountainBike"
        /AppleValleyHS/i,               # "AppleValleyHS"
        /LakevilleNorthHS/i,            # "LakevilleNorthHS"
        /LakevilleSouthHS/i,            # "LakevilleSouthHS"
        /MoundsViewHS/i,                # "MoundsViewHS"
        /MinnetonkaHS/i,                # "MinnetonkaHS"
        /BrainerdHS/i,                  # "BrainerdHS"
        /Crosby-?IrontonHS/i,           # "Crosby-IrontonHS"
        /PriorLakeHS/i,                 # "PriorLakeHS"
        /WoodburyHS/i,                  # "WoodburyHS"
        /ShakopeeHS/i,                  # "ShakopeeHS"
        /HopkinsHS/i,                   # "HopkinsHS"
        /EastviewHS/i,                  # "EastviewHS" 
        /EastRidgeHS/i,                 # "EastRidgeHS"
        /MapleGroveHS/i,                # "MapleGroveHS"
        /EaganHS/i,                     # "EaganHS"
        /ElkRiver/i,                    # "ElkRiver"
        /RockRidge/i,                   # "RockRidge"
        /StCloud/i,                     # "StCloud"
        /Roseville/i,                   # "Roseville"
        /Winona/i,                      # "Winona"
        /Borealis/i,                    # "Borealis"
        /Rockford/i,                    # "Rockford"
        /\w+HS$/i,                      # Generic "SomethingHS"
        /\w+MS$/i,                      # Generic "SomethingMS"
        /MountainBike$/i,               # "MountainBike"
        /Bike$/i,                       # "Bike"
        /River$/i,                      # "River"
        /Elk$/i                         # "Elk" (for ElkRiver)
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
      
      [full_name || "", team_name || ""]
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