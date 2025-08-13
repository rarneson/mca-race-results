require_relative '../base_mca_parser'

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
      
      # Lake Rebecca format: Place Name Team Rider# Bib Laps Penalty Comment Total Lap1 Lap2...
      # More precise regex: use rider number (8-9 digits) as anchor to work backwards
      match = line.match(/^\s*(\d+)\s+(.*?)\s+(\d{8,9})\s+(\d{4})\s+(\d+)\s.*?(\d+:\d+:\d+\.\d+|\d+:\d+\.\d+)(.*)$/)
      
      return nil unless match
      
      place = match[1].to_i
      name_team_section = match[2].strip
      
      # Pre-process the name_team_section to fix common PDF extraction artifacts
      # This fixes names BEFORE we try to split name from team
      name_team_section = preprocess_name_team_section(name_team_section)
      
      rider_number = match[3]
      plate_number = match[4]
      laps = match[5].to_i
      total_time = match[6]
      lap_times_text = match[7]&.strip
      
      # Split name_team_section by looking for known team name patterns
      # Most teams end with "HS", "MS", contain specific words, or are single words
      team_patterns = [
        /\b\w+\s+HS\b/,           # "Something HS"
        /\b\w+\s+MS\b/,           # "Something MS" 
        /\bBBBikers\b/,           # "BBBikers"
        /\bBorealis\b/,           # "Borealis"
        /\bBreck\b/,              # "Breck"
        /\bRockford\b/,           # "Rockford"
        /\bWinona\b/,             # "Winona"
        /\bMankato\b/,            # "Mankato"
        /\bSt\s+Cloud\b/,         # "St Cloud"
        /\bSt\s+Croix\b/,         # "St Croix"
        /\bTioga\s+Trailblazers\b/, # "Tioga Trailblazers"
        /\bStillwater\s+\w+\s+Bike\b/, # "Stillwater ... Bike"
        /\b\w+\s+Valley\b/        # "... Valley"
      ]
      
      full_name = ""
      team_name = ""
      
      # Try to find where team name starts
      team_start_pos = nil
      team_patterns.each do |pattern|
        if match_pos = name_team_section.match(pattern)
          team_start_pos = match_pos.begin(0)
          break
        end
      end
      
      if team_start_pos && team_start_pos > 0
        # Found a team pattern, split there
        full_name = name_team_section[0...team_start_pos].strip
        team_name = name_team_section[team_start_pos..-1].strip
      else
        # Fallback: look for multiple consecutive spaces (usually 2+ spaces separate name from team)
        if name_team_section.match(/^(.+?)\s{2,}(.+)$/)
          full_name = $1.strip
          team_name = $2.strip
        else
          # Last resort: split at approximately 2/3 point or after 2-3 words
          words = name_team_section.split(/\s+/)
          if words.length >= 4
            # Assume first 2-3 words are name
            name_word_count = [3, words.length / 2].min
            full_name = words[0...name_word_count].join(" ")
            team_name = words[name_word_count..-1].join(" ")
          else
            full_name = words[0] || ""
            team_name = words[1..-1]&.join(" ") || ""
          end
        end
      end
      
      # Clean Lake Rebecca specific text extraction artifacts
      cleaned_full_name = clean_rebecca_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Determine status
      status = determine_status(line, laps)
      
      {
        place: place,
        first_name: first_name,
        last_name: last_name,
        total_time: total_time,
        team_name: team_name,
        racer_number: rider_number,
        category: division,
        plate_number: plate_number,
        laps_completed: laps,
        status: status,
        division: extract_division_from_category(division),
        lap_times: parse_lap_times(lap_times_text)
      }
    end

    def clean_rebecca_name(name)
      # Lake Rebecca specific name cleaning - fix PDF text extraction artifacts
      cleaned = name.strip
      
      # Fix specific split names found in Lake Rebecca data
      cleaned = cleaned.gsub(/\bHAR RISON\b/, "HARRISON")
      cleaned = cleaned.gsub(/\bZAN DER\b/, "ZANDER")
      cleaned = cleaned.gsub(/\bAM ELIA\b/, "AMELIA")
      cleaned = cleaned.gsub(/\bHA ZEL\b/, "HAZEL")
      cleaned = cleaned.gsub(/\bGEM M A\b/, "GEMMA")
      cleaned = cleaned.gsub(/\bHAR RIET\b/, "HARRIET")
      cleaned = cleaned.gsub(/\bAVER Y\b/, "AVERY")
      cleaned = cleaned.gsub(/\bNOR A\b/, "NORA")
      cleaned = cleaned.gsub(/\bGWE N\b/, "GWEN")
      cleaned = cleaned.gsub(/\bMA RIELLA\b/, "MARIELLA")
      cleaned = cleaned.gsub(/\bHAR TLEY\b/, "HARTLEY")
      cleaned = cleaned.gsub(/\bGRA CE\b/, "GRACE")
      cleaned = cleaned.gsub(/\bNOR AH\b/, "NORAH")
      cleaned = cleaned.gsub(/\bNA TALIA\b/, "NATALIA")
      cleaned = cleaned.gsub(/\bNA TALIE\b/, "NATALIE")
      cleaned = cleaned.gsub(/\bEFRA M\b/, "EFRAM")
      cleaned = cleaned.gsub(/\bRH ONE\b/, "RHONE")
      cleaned = cleaned.gsub(/\bEMI N\b/, "EMIN")
      cleaned = cleaned.gsub(/\bOWE N\b/, "OWEN")
      cleaned = cleaned.gsub(/\bMA RCUS\b/, "MARCUS")
      cleaned = cleaned.gsub(/\bGAVI N\b/, "GAVIN")
      cleaned = cleaned.gsub(/\bME RRICK\b/, "MERRICK")
      cleaned = cleaned.gsub(/\bLINCO LN\b/, "LINCOLN")
      cleaned = cleaned.gsub(/\bJAM ESON\b/, "JAMESON")
      cleaned = cleaned.gsub(/\bEVE RETT\b/, "EVERETT")
      cleaned = cleaned.gsub(/\bCART ER\b/, "CARTER")
      cleaned = cleaned.gsub(/\bMOR GAN\b/, "MORGAN")
      cleaned = cleaned.gsub(/\bEVA N\b/, "EVAN")
      cleaned = cleaned.gsub(/\bGRE YLIN\b/, "GREYLIN")
      cleaned = cleaned.gsub(/\bCOL E\b/, "COLE")
      cleaned = cleaned.gsub(/\bHU DSON\b/, "HUDSON")
      cleaned = cleaned.gsub(/\bCON N OR\b/, "CONNOR")
      cleaned = cleaned.gsub(/\bQUIN CY\b/, "QUINCY")
      cleaned = cleaned.gsub(/\bASHE R\b/, "ASHER")
      cleaned = cleaned.gsub(/\bGA BRIEL\b/, "GABRIEL")
      cleaned = cleaned.gsub(/\bQUIN N\b/, "QUINN")
      cleaned = cleaned.gsub(/\bWY ATT\b/, "WYATT")
      cleaned = cleaned.gsub(/\bNOL AN\b/, "NOLAN")
      cleaned = cleaned.gsub(/\bLUCA S\b/, "LUCAS")
      cleaned = cleaned.gsub(/\bHEN RIK\b/, "HENRIK")
      cleaned = cleaned.gsub(/\bROM A N\b/, "ROMAN")
      cleaned = cleaned.gsub(/\bLOCH LAN\b/, "LOCHLAN")
      cleaned = cleaned.gsub(/\bWILLO W\b/, "WILLOW")
      cleaned = cleaned.gsub(/\bABB EY\b/, "ABBEY")
      cleaned = cleaned.gsub(/\bSIMO NE\b/, "SIMONE")
      cleaned = cleaned.gsub(/\bMAR GOT\b/, "MARGOT")
      cleaned = cleaned.gsub(/\bGRE TA\b/, "GRETA")
      cleaned = cleaned.gsub(/\bMA CKENNA\b/, "MACKENNA")
      cleaned = cleaned.gsub(/\bLAUR EN\b/, "LAUREN")
      cleaned = cleaned.gsub(/\bPENE OPE\b/, "PENELOPE")
      cleaned = cleaned.gsub(/\bMA CIE\b/, "MACIE")
      cleaned = cleaned.gsub(/\bAN KA\b/, "ANKA")
      cleaned = cleaned.gsub(/\bCO RA\b/, "CORA")
      cleaned = cleaned.gsub(/\bAD RA\b/, "ADRA")
      cleaned = cleaned.gsub(/\bSAM ANTHA\b/, "SAMANTHA")
      cleaned = cleaned.gsub(/\bDA HLIA\b/, "DAHLIA")
      cleaned = cleaned.gsub(/\bABB Y\b/, "ABBY")
      cleaned = cleaned.gsub(/\bEM LY\b/, "EMILY")
      cleaned = cleaned.gsub(/\bGR AYSON\b/, "GRAYSON")
      cleaned = cleaned.gsub(/\bLOG AN\b/, "LOGAN")
      cleaned = cleaned.gsub(/\bCHA RLIE\b/, "CHARLIE")
      cleaned = cleaned.gsub(/\bSAM UEL\b/, "SAMUEL")
      cleaned = cleaned.gsub(/\bROC CO\b/, "ROCCO")
      cleaned = cleaned.gsub(/\bCON NER\b/, "CONNER")
      cleaned = cleaned.gsub(/\bHEN RY\b/, "HENRY")
      cleaned = cleaned.gsub(/\bWILSO N\b/, "WILSON")
      cleaned = cleaned.gsub(/\bCRO X\b/, "CROX")
      cleaned = cleaned.gsub(/\bNOA H\b/, "NOAH")
      cleaned = cleaned.gsub(/\bCEDA R\b/, "CEDAR")
      cleaned = cleaned.gsub(/\bEASTO N\b/, "EASTON")
      cleaned = cleaned.gsub(/\bGAB E\b/, "GABE")
      cleaned = cleaned.gsub(/\bTEDD Y\b/, "TEDDY")
      cleaned = cleaned.gsub(/\bASH TON\b/, "ASHTON")
      cleaned = cleaned.gsub(/\bTAY DEN\b/, "TAYDEN")
      cleaned = cleaned.gsub(/\bCH ASE\b/, "CHASE")
      cleaned = cleaned.gsub(/\bNAT HAN\b/, "NATHAN")
      cleaned = cleaned.gsub(/\bMO RRIS\b/, "MORRIS")
      
      # Additional Lake Rebecca specific fixes based on parsing issues found
      cleaned = cleaned.gsub(/\bEMI N\b/, "EMIN")
      cleaned = cleaned.gsub(/\bMOR GAN\b/, "MORGAN")
      cleaned = cleaned.gsub(/\bOWE N\b/, "OWEN")
      cleaned = cleaned.gsub(/\bCHA RLIE\b/, "CHARLIE")
      cleaned = cleaned.gsub(/\bSAM UEL\b/, "SAMUEL")
      cleaned = cleaned.gsub(/\bROC CO\b/, "ROCCO")
      cleaned = cleaned.gsub(/\bCON NER\b/, "CONNER")
      cleaned = cleaned.gsub(/\bHEN RY\b/, "HENRY")
      cleaned = cleaned.gsub(/\bWILSO N\b/, "WILSON")
      cleaned = cleaned.gsub(/\bNOA H\b/, "NOAH")
      cleaned = cleaned.gsub(/\bCEDA R\b/, "CEDAR")
      cleaned = cleaned.gsub(/\bEASTO N\b/, "EASTON")
      cleaned = cleaned.gsub(/\bGAB E\b/, "GABE")
      cleaned = cleaned.gsub(/\bTEDD Y\b/, "TEDDY")
      cleaned = cleaned.gsub(/\bASH TON\b/, "ASHTON")
      cleaned = cleaned.gsub(/\bTAY DEN\b/, "TAYDEN")
      cleaned = cleaned.gsub(/\bCH ASE\b/, "CHASE")
      cleaned = cleaned.gsub(/\bNAT HAN\b/, "NATHAN")
      cleaned = cleaned.gsub(/\bOLI VER\b/, "OLIVER")
      cleaned = cleaned.gsub(/\bBEN JA MIN\b/, "BENJAMIN")
      cleaned = cleaned.gsub(/\bNI CHO LAS\b/, "NICHOLAS")
      cleaned = cleaned.gsub(/\bALE XAN DER\b/, "ALEXANDER")
      cleaned = cleaned.gsub(/\bCHR IS TIAN\b/, "CHRISTIAN")
      cleaned = cleaned.gsub(/\bJONA THAN\b/, "JONATHAN")
      cleaned = cleaned.gsub(/\bMI CHAEL\b/, "MICHAEL")
      cleaned = cleaned.gsub(/\bAN DREW\b/, "ANDREW")
      cleaned = cleaned.gsub(/\bMAT THEW\b/, "MATTHEW")
      cleaned = cleaned.gsub(/\bJO SEPH\b/, "JOSEPH")
      cleaned = cleaned.gsub(/\bDA NIEL\b/, "DANIEL")
      cleaned = cleaned.gsub(/\bRO BERT\b/, "ROBERT")
      cleaned = cleaned.gsub(/\bWIL LIAM\b/, "WILLIAM")
      
      # Fix common three-part names
      cleaned = cleaned.gsub(/\bEM M ETT\b/, "EMMETT")
      cleaned = cleaned.gsub(/\bGRA HAM\b/, "GRAHAM")
      cleaned = cleaned.gsub(/\bKON RAD\b/, "KONRAD")
      cleaned = cleaned.gsub(/\bYAG HNESH\b/, "YAGNESH")
      cleaned = cleaned.gsub(/\bBRA CE\b/, "BRACE")
      cleaned = cleaned.gsub(/\bJA COB\b/, "JACOB")
      cleaned = cleaned.gsub(/\bAN TON\b/, "ANTON")
      cleaned = cleaned.gsub(/\bADE INE\b/, "ADELINE")
      cleaned = cleaned.gsub(/\bOLI VIA\b/, "OLIVIA")
      cleaned = cleaned.gsub(/\bNA OM I\b/, "NAOMI")
      cleaned = cleaned.gsub(/\bMA DD OX\b/, "MADDOX")
      
      cleaned
    end

    def preprocess_name_team_section(section)
      # Fix PDF extraction artifacts in the entire name+team section before parsing
      cleaned = section.strip
      
      # Fix split names that appear at the beginning (these are the main culprits)
      cleaned = cleaned.gsub(/^EMI N/, "EMIN")
      cleaned = cleaned.gsub(/^MOR GAN/, "MORGAN") 
      cleaned = cleaned.gsub(/^OWE N/, "OWEN")
      cleaned = cleaned.gsub(/^EM M ETT/, "EMMETT")
      cleaned = cleaned.gsub(/^YAG HNESH/, "YAGNESH")
      cleaned = cleaned.gsub(/^HAR RISON/, "HARRISON")
      cleaned = cleaned.gsub(/^LOCH LAN/, "LOCHLAN")
      cleaned = cleaned.gsub(/^ZAN DER/, "ZANDER")
      cleaned = cleaned.gsub(/^CHA RLIE/, "CHARLIE")
      cleaned = cleaned.gsub(/^SAM UEL/, "SAMUEL")
      cleaned = cleaned.gsub(/^ROC CO/, "ROCCO")
      cleaned = cleaned.gsub(/^CON NER/, "CONNER")
      cleaned = cleaned.gsub(/^HEN RY/, "HENRY")
      cleaned = cleaned.gsub(/^WIL SO N/, "WILSON")
      cleaned = cleaned.gsub(/^NOA H/, "NOAH")
      cleaned = cleaned.gsub(/^CED AR/, "CEDAR")
      cleaned = cleaned.gsub(/^EAS TO N/, "EASTON")
      cleaned = cleaned.gsub(/^GAB E/, "GABE")
      cleaned = cleaned.gsub(/^TED DY/, "TEDDY")
      cleaned = cleaned.gsub(/^ASH TO N/, "ASHTON")
      cleaned = cleaned.gsub(/^TAY DE N/, "TAYDEN")
      cleaned = cleaned.gsub(/^CH ASE/, "CHASE")
      cleaned = cleaned.gsub(/^NAT HA N/, "NATHAN")
      cleaned = cleaned.gsub(/^OLI VER/, "OLIVER")
      cleaned = cleaned.gsub(/^BEN JA MIN/, "BENJAMIN")
      cleaned = cleaned.gsub(/^NI CHO LAS/, "NICHOLAS")
      cleaned = cleaned.gsub(/^ALE XAN DER/, "ALEXANDER")
      cleaned = cleaned.gsub(/^CHR IS TIAN/, "CHRISTIAN")
      cleaned = cleaned.gsub(/^JON A THAN/, "JONATHAN")
      cleaned = cleaned.gsub(/^MI CHA EL/, "MICHAEL")
      cleaned = cleaned.gsub(/^AN D REW/, "ANDREW")
      cleaned = cleaned.gsub(/^MAT T HEW/, "MATTHEW")
      cleaned = cleaned.gsub(/^JO SE PH/, "JOSEPH")
      cleaned = cleaned.gsub(/^DAN I EL/, "DANIEL")
      cleaned = cleaned.gsub(/^ROB ERT/, "ROBERT")
      cleaned = cleaned.gsub(/^WIL LI AM/, "WILLIAM")
      cleaned = cleaned.gsub(/^GRA HAM/, "GRAHAM")
      cleaned = cleaned.gsub(/^KON RAD/, "KONRAD")
      cleaned = cleaned.gsub(/^BRA CE/, "BRACE")
      cleaned = cleaned.gsub(/^JAC OB/, "JACOB")
      cleaned = cleaned.gsub(/^ANT ON/, "ANTON")
      cleaned = cleaned.gsub(/^OLI VIA/, "OLIVIA")
      cleaned = cleaned.gsub(/^NA OM I/, "NAOMI")
      cleaned = cleaned.gsub(/^MAD D OX/, "MADDOX")
      
      cleaned
    end
  end
end