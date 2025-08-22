require_relative 'base_parser'

module RaceData
  class BaseMcaParser < BaseParser
    protected

    def extract_race_info(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      
      {
        name: find_race_name(lines),
        race_date: find_race_date(lines), 
        location: find_location(lines),
        year: find_year(lines),
        series: "Minnesota Cycling Association"
      }
    end

    def find_race_name(lines)
      # Look for "Race X - Location" pattern in MCA format
      race_line = lines.find { |line| line.match?(/Race \d+ - /) }
      if race_line
        race_line.strip
      else
        # Fallback
        lines.first(5).find { |line| line.length > 10 && !line.match?(/^\d/) }
      end
    end

    def find_race_date(lines)
      # Look for MCA date patterns: "August 24-25 2024" or "September 7-8, 2024"
      date_line = lines.find { |line| line.match?(/\w+ \d{1,2}-\d{1,2},? \d{4}/) }
      if date_line && date_line.match?(/(\w+) (\d{1,2})-\d{1,2},? (\d{4})/)
        # Use first date of the weekend
        match = date_line.match(/(\w+) (\d{1,2})-\d{1,2},? (\d{4})/)
        "#{match[1]} #{match[2]}, #{match[3]}"
      else
        # Fallback to standard date patterns
        lines.find { |line| line.match?(/\d{1,2}[-\/]\d{1,2}[-\/]\d{2,4}/) }&.match(/\d{1,2}[-\/]\d{1,2}[-\/]\d{2,4}/)&.[](0)
      end
    end

    def find_location(lines)
      # Extract location from "Race X - Location" pattern
      race_line = lines.find { |line| line.match?(/Race \d+ - /) }
      if race_line
        match = race_line.match(/Race \d+ - (.+)/)
        match[1]&.strip if match
      else
        # Fallback
        fallback = lines.find { |line| line.downcase.include?('track') || line.downcase.include?('circuit') }
        fallback&.strip
      end
    end

    def find_year(lines)
      # Extract year from date or find standalone year
      if date_line = find_race_date(lines)
        Date.parse(date_line).year rescue nil
      else
        lines.find { |line| line.match?(/\b20\d{2}\b/) }&.match(/\b(20\d{2})\b/)&.[](1)&.to_i
      end
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

    def determine_status(line, laps)
      if line.include?("DNF")
        "DNF"
      elsif line.include?("DNS") 
        "DNS"
      elsif line.include?("DSQ")
        "DSQ"
      elsif laps == 0
        "DNS"
      else
        "finished"
      end
    end

    def parse_lap_times(lap_times_text)
      return [] if lap_times_text.blank?
      
      # Extract only consecutive time patterns from the beginning of the text
      # This prevents picking up times from page headers or other content that might be concatenated
      consecutive_times = []
      remaining_text = lap_times_text.strip
      
      # Keep extracting time patterns as long as they appear at the start of remaining text
      while remaining_text.match(/^\s*(\d+:\d+:\d+\.\d+|\d+:\d+\.\d+)/)
        match = remaining_text.match(/^\s*(\d+:\d+:\d+\.\d+|\d+:\d+\.\d+)(.*)/)
        if match
          consecutive_times << match[1]
          remaining_text = match[2].strip
        else
          break
        end
      end
      
      consecutive_times
    end

    def extract_division_from_category(category)
      # Extract division from category names like "6th Grade Boys D2", "7th Grade Boys D1", "h Grade Boys 2"
      # Only return a division if it's explicitly specified
      return nil if category.blank?
      
      # Handle explicit D1/D2 format
      if category.include?("D2")
        2
      elsif category.include?("D1")
        1
      # Handle numeric format like "h Grade Boys 2" or "h Grade Boys 1"
      elsif category.match?(/Boys?\s+([12])$/)
        category.match(/Boys?\s+([12])$/)[1].to_i
      else
        # Don't assume a division if not explicitly specified
        nil
      end
    end
  end
end