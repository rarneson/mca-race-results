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
          first_name: clean_string(result[:first_name]),
          last_name: clean_string(result[:last_name]),
          number: clean_string(result[:racer_number])
        },
        team: {
          name: clean_string(result[:team_name])
        },
        result: {
          place: parse_integer(result[:place]),
          total_time_ms: parse_time_to_ms(result[:total_time]),
          total_time_raw: result[:total_time],
          laps_completed: parse_integer(result[:laps_completed]),
          laps_expected: parse_integer(result[:laps_expected]) || 1,
          status: normalize_status(result[:status]),
          category_snapshot: parse_integer(result[:category]),
          plate_number_snapshot: clean_string(result[:plate_number])
        },
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
  end
end