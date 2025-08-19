require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class LakeRebecca2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 2 - Lake Rebecca") && 
      text.include?("September 7-8, 2024") &&
      (text.include?("Division:") || text.include?("Divsion:"))
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_results(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      results = []
      current_division = nil
      in_results_section = false
      
      lines.each_with_index do |line, index|
        # Check for new division (handle typos)
        if line.start_with?("Division:") || line.start_with?("Divsion:")
          current_division = line.sub(/Divs?ion:\s*/, "").strip
          in_results_section = false
          next
        end
        
        # Skip header line after division (handle "Pace Nam e" artifact)
        if current_division && (line.include?("Place") || line.include?("Pace")) && line.include?("Name") && line.include?("Team")
          in_results_section = true
          next
        end
        
        # Parse result lines (start with place number and have racer data)
        if in_results_section && current_division && line.match?(/^\s*\d+\s+/)
          result = parse_rebecca_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def parse_rebecca_result_line(line, division)
      return nil if line.strip.empty?
      
      # Lake Rebecca uses fixed-width columns - much simpler than complex regex
      # Format: Place(4) Name(32) Team(24) Rider#(10) Bib(5) Laps(2) ... Times
      
      # Extract place number from start
      place_match = line.match(/^\s*(\d+)\s+/)
      return nil unless place_match
      
      place = place_match[1].to_i
      remaining_line = line[place_match.end(0)..-1]
      
      # Find rider number (9 digits) as our main anchor point
      rider_match = remaining_line.match(/(\d{9})\s+(\d{4})\s+(\d+)/)
      return nil unless rider_match
      
      rider_number = rider_match[1]
      plate_number = rider_match[2]
      laps = rider_match[3].to_i
      
      # Everything before rider number contains name and team
      name_team_section = remaining_line[0...rider_match.begin(0)].strip
      
      # Everything after laps contains times
      times_section = remaining_line[rider_match.end(0)..-1].strip
      
      # Parse name and team from fixed-width section
      # Name typically takes first ~32 chars, team takes next ~24 chars
      full_name, team_name = parse_fixed_width_name_team(name_team_section)
      
      # Clean up PDF extraction artifacts in the name
      cleaned_full_name = clean_rebecca_name_artifacts(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Parse times from times section
      # CRITICAL FIX: The line may contain multiple racers - stop at next rider number pattern
      # Find the end of this racer's data by looking for the next rider number
      next_rider_pattern = /\s+\d{9}\s+\d{4}\s+\d+/
      next_rider_match = times_section.match(next_rider_pattern)
      
      if next_rider_match
        # Truncate to only this racer's data
        racer_section = times_section[0...next_rider_match.begin(0)]
      else
        racer_section = times_section
      end
      
      time_pattern = /\d+:\d+\.\d+/
      times = racer_section.scan(time_pattern)
      total_time = times.first
      expected_lap_times = times[1..laps] || []  # Take exactly 'laps' number of lap times
      lap_times = expected_lap_times
      
      # Determine status
      status = determine_status(line, laps)
      
      {
        place: place,
        first_name: first_name,
        last_name: last_name,
        total_time: total_time || "",
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

    def parse_fixed_width_name_team(name_team_section)
      # Lake Rebecca has approximately fixed-width columns
      # Name is roughly first 30-35 characters, team follows
      
      # Clean up obvious corrupted patterns first
      cleaned_section = name_team_section
      
      # Fix corrupted name-team combinations where extra data bleeds in
      cleaned_section = cleaned_section.gsub(/^(.+?)(NBERG\s+|GAN\s+\w+\s+|LIN\s+)(.+)$/, '\1\3')
      
      # Look for multiple consecutive spaces that separate name from team
      if cleaned_section.match(/^(.+?)\s{2,}(.+)$/)
        name_part = $1.strip
        team_part = $2.strip
        return [name_part, normalize_team_name(team_part)]
      end
      
      # Fallback: try to identify team using known patterns and split there
      # Use the seeds.rb team list to identify valid teams
      team_patterns = [
        "East Ridge HS", "Stillwater Mountain Bike", "Stillwater Mntain Bike", "Hopkins HS",
        "Maple Grove HS", "Lakeville South HS", "Winona", "Brainerd HS", "Eastview HS",
        "Minnetonka HS", "Chanhassen HS", "Woodbury HS", "Rockford", "St Paul Central",
        "St Louis Park HS", "Mankato", "St Cloud", "Apple Valley HS", "Borealis",
        "Lake Area Composite", "Minnesota Valley", "Totino Grace-Irondale",
        "New Prague MS and HS", "Rochester Area", "Tioga Trailblazers",
        "St Michael / Albertville", "Armstrong Cycle", "Edina Cycling", "St Croix",
        "Hudson HS", "River Falls HS", "Orono HS", "Austin HS", "Chaska HS",
        "Eden Prairie HS", "Osseo Composite", "Crosby-Ironton HS", "Hutchinson Tigers",
        "Mounds View HS", "Eagan HS", "Breck", "Waconia HS", "Rosemount HS",
        "Champlin Park HS", "Eastview HS"
      ]
      
      # Also check for common abbreviated versions in the PDF
      abbreviated_teams = [
        "Maple Grove S", "Lakeville SouHS", "Stillwater Motain Bike", 
        "St Paul Centla", "Stillwater Mntain Bike", "Apple ValleySH",
        "Eden PrairieSH", "Osseo Compo ste", "Crosby-IronnoHS", 
        "Crosby-IrontoHS", "Hutchinson Tigrs", "Rosemount H S",
        "St Louis ParS H", "Champlin Park S", "Totino Gracerondale"
      ]
      
      all_team_patterns = team_patterns + abbreviated_teams
      
      # Find the longest team name that appears in the text
      best_team = nil
      best_position = nil
      
      all_team_patterns.each do |team|
        # Check for exact match (case insensitive)
        if (pos = cleaned_section.downcase.index(team.downcase))
          if best_team.nil? || team.length > best_team.length
            best_team = team
            best_position = pos
          end
        end
      end
      
      if best_team && best_position
        name_part = cleaned_section[0...best_position].strip
        team_part = best_team
        return [name_part, normalize_team_name(team_part)]
      end
      
      # Last resort: use TeamNameExtractor
      extracted_team = TeamNameExtractor.extract_team_name(cleaned_section)
      if extracted_team
        name_part = cleaned_section.gsub(extracted_team, '').strip.gsub(/\s+/, ' ')
        return [name_part, extracted_team]
      end
      
      # If all else fails, assume the entire thing is just a name
      [cleaned_section, ""]
    end

    def clean_rebecca_name_artifacts(name)
      return "" if name.nil? || name.strip.empty?
      
      cleaned = name.strip.upcase
      
      # Fix the main PDF extraction artifacts - names split with spaces
      # These are the most common patterns found in Lake Rebecca data
      name_fixes = {
        # Common first names with space artifacts
        "AME LIA" => "AMELIA",
        "HA ZEL" => "HAZEL", 
        "GEM M A" => "GEMMA",
        "HAR RIET" => "HARRIET",
        "AVER Y" => "AVERY",
        "NOR A" => "NORA",
        "GWE N" => "GWEN",
        "MA RIELLA" => "MARIELLA",
        "HAR TLEY" => "HARTLEY",
        "GRA CE" => "GRACE",
        "NOR AH" => "NORAH",
        "NA TALIA" => "NATALIA",
        "NA TALIE" => "NATALIE",
        "EMI N" => "EMIN",
        "OWE N" => "OWEN",
        "MA RCUS" => "MARCUS",
        "GAVI N" => "GAVIN",
        "MER RICK" => "MERRICK",
        "LINCO LN" => "LINCOLN",
        "JAM ESON" => "JAMESON",
        "EVE RETT" => "EVERETT",
        "CART ER" => "CARTER",
        "MOR GAN" => "MORGAN",
        "EVA N" => "EVAN",
        "GRE YLIN" => "GREYLIN",
        "COL E" => "COLE",
        "HU DSON" => "HUDSON",
        "CON N OR" => "CONNOR",
        "QUIN CY" => "QUINCY",
        "ASHE R" => "ASHER",
        "GA BRIEL" => "GABRIEL",
        "QUIN N" => "QUINN",
        "WY ATT" => "WYATT",
        "NOL AN" => "NOLAN",
        "LUCA S" => "LUCAS",
        "HEN RIK" => "HENRIK",
        "ROM A N" => "ROMAN",
        "LOCH LAN" => "LOCHLAN",
        
        # Fix specific problematic patterns found in validation
        "EFRA M" => "EFRAM",
        "RH ONE" => "RHONE", 
        "ZAN DER" => "ZANDER",
        "ME RRICK" => "MERRICK",
        "ABB EY" => "ABBEY",
        "SIMO NE" => "SIMONE", 
        "MAR GOT" => "MARGOT",
        "WILLO W" => "WILLOW",
        "ASH TON" => "ASHTON",
        "TAY DEN" => "TAYDEN",
        "CH ASE" => "CHASE",
        "NAT HAN" => "NATHAN",
        
        # Fix full name combinations that appear corrupted
        "INGRID WIDENBRAN T" => "INGRID WIDENBRANT",
        "OWE OWE" => "OWEN BERG",  # Common corruption pattern
        "FRITZFREY FRITZFREY" => "FRITZ FREY",
        "MOR MOR" => "MORGAN PATTERSON",
        "SILASBODEN SILASBODEN" => "SILAS BODEN",
        "LEIFREED LEIFREED" => "LEIF REED",
        "OBUJOLD OBUJOLD" => "OLIN BUJOLD"
      }
      
      # Apply name fixes
      name_fixes.each do |broken, fixed|
        cleaned = cleaned.gsub(/\b#{Regexp.escape(broken)}\b/, fixed)
      end
      
      # Fix any remaining single letter + space patterns (like "E MILAN" -> "EMILAN")
      cleaned = cleaned.gsub(/\b([A-Z])\s+([A-Z][a-z]+)\b/, '\1\2')
      
      cleaned
    end

    def normalize_team_name(team)
      # Convert abbreviated team names to full names
      case team.downcase.strip
      when /maple grove s/i
        "Maple Grove HS"
      when /lakeville souhs/i
        "Lakeville South HS"
      when /stillwater motain bike/i, /stillwater mntain bike/i
        "Stillwater Mountain Bike"
      when /st paul centla/i
        "St Paul Central"
      when /st louis pars h/i
        "St Louis Park HS"
      when /apple valleysh/i
        "Apple Valley HS"
      when /eden prairiehs/i
        "Eden Prairie HS"
      when /osseo compo ste/i
        "Osseo Composite"
      when /crosby-ironnohs/i, /crosby-irontohs/i
        "Crosby-Ironton HS"
      when /hutchinson tigrs/i
        "Hutchinson Tigers"
      when /rosemount h s/i
        "Rosemount HS"
      when /champlin park s/i
        "Champlin Park HS"
      when /totino gracerondale/i
        "Totino Grace-Irondale"
      when /tioga trailbers/i
        "Tioga Trailblazers"
      else
        team
      end
    end
  end
end