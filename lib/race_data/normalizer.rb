module RaceData
  class Normalizer
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def normalize
      {
        race: normalize_race_data(@raw_data[:race_info]),
        results: normalize_results(@raw_data[:results])
      }
    end

    private

    def normalize_race_data(race_info)
      {
        name: clean_string(race_info[:name]),
        race_date: parse_date(race_info[:race_date]),
        location: clean_string(race_info[:location]),
        year: parse_year(race_info[:year] || race_info[:race_date]),
        series: clean_string(race_info[:series])
      }
    end

    def normalize_results(results)
      results.map { |result| normalize_single_result(result) }
    end

    def normalize_single_result(result)
      {
        racer: {
          first_name: clean_racer_name(result[:first_name]),
          last_name: clean_racer_name(result[:last_name]),
          number: clean_string(result[:racer_number])
        },
        team: {
          name: clean_team_name(result[:team_name])
        },
        result: {
          place: parse_integer(result[:place]),
          total_time_ms: parse_time_to_ms(result[:total_time]),
          total_time_raw: result[:total_time],
          laps_completed: parse_integer(result[:laps_completed]),
          laps_expected: parse_integer(result[:laps_expected]) || 1,
          status: normalize_status(result[:status]),
          category: lookup_category(result[:category]),
          plate_number_snapshot: clean_string(result[:plate_number])
        },
        division: result[:division],
        lap_times: normalize_lap_times(result[:lap_times] || [])
      }
    end

    def normalize_lap_times(lap_times)
      lap_times.each_with_index.map do |lap_time, index|
        {
          lap_number: index + 1,
          lap_time_ms: parse_time_to_ms(lap_time),
          lap_time_raw: lap_time
        }
      end
    end

    def clean_string(str)
      return nil if str.nil?
      str.to_s.strip.presence
    end

    def clean_team_name(team_name)
      return nil if team_name.nil?
      
      cleaned = team_name.to_s.strip
      
      # Fix common PDF text extraction artifacts for team names
      cleaned = cleaned.gsub(/ParS H\b/, "Park HS")
      cleaned = cleaned.gsub(/SouHS\b/, "South HS")
      cleaned = cleaned.gsub(/NorHS\b/, "North HS")
      cleaned = cleaned.gsub(/NohHS\b/, "North HS")
      cleaned = cleaned.gsub(/ShuHS\b/, "South HS")
      cleaned = cleaned.gsub(/Motain\b/, "Mountain")
      cleaned = cleaned.gsub(/Mntain\b/, "Mountain")
      cleaned = cleaned.gsub(/Compo ste\b/, "Composite")
      cleaned = cleaned.gsub(/Trailbers\b/, "Trailblazers")
      cleaned = cleaned.gsub(/Trailblrse\b/, "Trailblazers")
      cleaned = cleaned.gsub(/Centla\b/, "Central")
      cleaned = cleaned.gsub(/Westo nka\b/, "Westonka")
      cleaned = cleaned.gsub(/Westonk a\b/, "Westonka")
      cleaned = cleaned.gsub(/IronnoHS\b/, "Ironton HS")
      cleaned = cleaned.gsub(/IrontoHS\b/, "Ironton HS")
      cleaned = cleaned.gsub(/Lke HS\b/, "Lake HS")
      cleaned = cleaned.gsub(/ValleySH\b/, "Valley HS")
      cleaned = cleaned.gsub(/PrairieSH\b/, "Prairie HS")
      cleaned = cleaned.gsub(/Gracerondale\b/, "Grace Irondale")
      
      cleaned.presence
    end

    def clean_racer_name(name)
      return nil if name.nil?
      
      cleaned = name.to_s.strip
      
      # Fix common PDF text extraction artifacts for names
      # Handle split names like "ZAN DER" -> "ZANDER", "AM ELIA" -> "AMELIA"
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
      cleaned = cleaned.gsub(/\bHAR RISON\b/, "HARRISON")
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
      cleaned = cleaned.gsub(/\bWILLO W\b/, "WILLOW")
      cleaned = cleaned.gsub(/\bABB EY\b/, "ABBEY")
      cleaned = cleaned.gsub(/\bSIMO NE\b/, "SIMONE")
      cleaned = cleaned.gsub(/\bMAR GOT\b/, "MARGOT")
      cleaned = cleaned.gsub(/\bRU E\b/, "RUE")
      cleaned = cleaned.gsub(/\bHU DSON\b/, "HUDSON")
      cleaned = cleaned.gsub(/\bGRE TA\b/, "GRETA")
      cleaned = cleaned.gsub(/\bMA CKENNA\b/, "MACKENNA")
      cleaned = cleaned.gsub(/\bLAUR EN\b/, "LAUREN")
      cleaned = cleaned.gsub(/\bDEM I\b/, "DEMI")
      cleaned = cleaned.gsub(/\bBIBI M\b/, "BIBI")
      cleaned = cleaned.gsub(/\bNOE LLE\b/, "NOELLE")
      cleaned = cleaned.gsub(/\bFAYAN NA\b/, "FAYANNA")
      cleaned = cleaned.gsub(/\bPENE OPE\b/, "PENELOPE")
      cleaned = cleaned.gsub(/\bMA CIE\b/, "MACIE")
      cleaned = cleaned.gsub(/\bAN KA\b/, "ANKA")
      cleaned = cleaned.gsub(/\bGEM M A\b/, "GEMMA")
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
      cleaned = cleaned.gsub(/\bCHA RLIE\b/, "CHARLIE")
      cleaned = cleaned.gsub(/\bTEDD Y\b/, "TEDDY")
      cleaned = cleaned.gsub(/\bASH TON\b/, "ASHTON")
      cleaned = cleaned.gsub(/\bTAY DEN\b/, "TAYDEN")
      cleaned = cleaned.gsub(/\bCH ASE\b/, "CHASE")
      cleaned = cleaned.gsub(/\bNAT HAN\b/, "NATHAN")
      cleaned = cleaned.gsub(/\bASHE R\b/, "ASHER")
      cleaned = cleaned.gsub(/\bMO RRIS\b/, "MORRIS")
      
      cleaned.presence
    end

    def parse_date(date_str)
      return nil if date_str.blank?
      Date.parse(date_str.to_s)
    rescue ArgumentError
      nil
    end

    def parse_year(input)
      return nil if input.nil?
      
      if input.is_a?(Date)
        input.year
      else
        year = input.to_s.match(/(\d{4})/)[1]
        year.to_i if year
      end
    rescue
      nil
    end

    def parse_integer(str)
      return nil if str.blank?
      str.to_s.gsub(/\D/, '').to_i.presence
    end

    def parse_time_to_ms(time_str)
      return nil if time_str.blank?
      
      # Handle formats like "18:17.5", "1:23:45.67", "45.23"
      time_str = time_str.to_s.strip
      
      # Extract minutes, seconds, milliseconds
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

    def normalize_status(status)
      return "finished" if status.blank?
      
      status = status.to_s.upcase.strip
      case status
      when /DNF|DID.NOT.FINISH/
        "DNF"
      when /DSQ|DISQUALIFIED/
        "DSQ"
      when /DNS|DID.NOT.START/
        "DNS"
      else
        "finished"
      end
    end

    def lookup_category(category_text)
      return nil if category_text.blank?
      
      category = Category.find_by_text(category_text)
      if category.nil?
        puts "⚠️  Unknown category: '#{category_text}'"
      end
      category
    end
  end
end