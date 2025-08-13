require 'pdf/reader'
require_relative 'base_parser'

module RaceData
  class McaPdfParser < BaseParser
    def initialize(pdf_path)
      super(pdf_path)
      @reader = PDF::Reader.new(pdf_path)
    end

    def can_parse?(text)
      # Check for MCA-specific patterns (flexible for format variations)
      has_division = text.include?("Division:") || text.include?("Divsion:")
      has_race_title = text.match?(/Race \d+ - /)
      has_mca_date = text.match?(/\w+ \d{1,2}-\d{1,2},? \d{4}/)
      has_mca_org = text.include?("Minnesota Cycling Association") || text.include?("Min nesota Cycling Association")
      
      has_division && has_race_title && (has_mca_date || has_mca_org)
    end

    def extract_race_data
      text = extract_text
      puts "=== RAW PDF TEXT ==="
      puts text
      puts "==================="
      
      {
        race_info: extract_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_race_info(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      
      # Parse MCA race format from header
      {
        name: find_race_name(lines),
        race_date: find_race_date(lines), 
        location: find_location(lines),
        year: find_year(lines),
        series: "Minnesota Cycling Association"
      }
    end

    def extract_results(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      results = []
      current_division = nil
      in_results_section = false
      
      lines.each_with_index do |line, index|
        # Check for new division (handle typos and variations)
        if line.start_with?("Division:") || line.start_with?("Divsion:")
          current_division = line.sub(/Divs?ion:\s*/, "").strip
          in_results_section = false
          next
        end
        
        # Skip header line after division (flexible matching for text extraction artifacts)
        if current_division && (line.include?("Place") || line.include?("Pace")) && line.include?("Name") && line.include?("Team")
          in_results_section = true
          next
        end
        
        # Parse result lines (start with place number and have racer data)
        if in_results_section && current_division && line.match?(/^\s*\d+\s+/)
          result = parse_mca_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def extract_text
      text = ""
      @reader.pages.each do |page|
        text += page.text
      end
      text
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

    def find_series(lines)
      # Look for series indicators
      lines.find { |line| line.downcase.include?('series') || line.downcase.include?('championship') }
    end

    def parse_mca_result_line(line, division)
      # MCA format: Place Name Team Rider# Plate Laps Penalty Comment Total Lap1 Lap2...
      # Example: "1   LUCIA DREVLOW                      East Ridge HS              100512776 6524    1                                 19:20.0    19:20.0"
      
      return nil if line.strip.empty?
      
      # More precise parsing using regex to extract the structured data
      # Match: Place(1-3 digits) + spaces + Name + spaces + Team + spaces + Rider# + space + Plate + space + Laps + spaces + times...
      # Handle both MM:SS.s and H:MM:SS.s time formats, and capture everything after total time for lap times
      match = line.match(/^\s*(\d+)\s+([A-Z\s\-]+?)\s{2,}([A-Za-z\s\-\.]+?)\s+(\d{8,9})\s+(\d{4})\s+(\d+)\s.*?(\d+:\d+:\d+\.\d+|\d+:\d+\.\d+)(.*)$/)
      
      return nil unless match
      
      place = match[1].to_i
      full_name = match[2].strip
      team_name = match[3].strip
      rider_number = match[4]
      plate_number = match[5]
      laps = match[6].to_i
      total_time = match[7]
      lap_times_text = match[8]&.strip
      
      # Split name into first/last
      name_parts = full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Determine status - check if DNF appears in the line
      status = if line.include?("DNF")
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

    def find_time_in_parts(parts)
      # Look for time format: MM:SS.ms or HH:MM:SS.ms
      parts.find { |part| part.match?(/\d+:\d+[\.\:]\d+/) }
    end

    def find_team_in_parts(parts)
      # Everything after the time might be team name
      time_index = parts.find_index { |part| part.match?(/\d+:\d+[\.\:]\d+/) }
      return nil unless time_index
      
      parts[(time_index + 1)..-1]&.join(" ")
    end

    def find_number_in_parts(parts)
      # Look for racer number (might be separate from place)
      parts.find { |part| part.match?(/^#?\d+$/) && part.to_i != parts[0].to_i }
    end

    def extract_division_from_category(category)
      # Extract division from category names like "6th Grade Boys D2", "7th Grade Boys D1"
      # Only return a division if it's explicitly specified
      return nil if category.blank?
      
      if category.include?("D2")
        2
      elsif category.include?("D1")
        1
      else
        # Don't assume a division if not explicitly specified
        nil
      end
    end

    def parse_lap_times(lap_times_text)
      return [] if lap_times_text.blank?
      
      # Extract time patterns from the remaining text after total time
      # Look for patterns like "19:05.6" or "1:23:45.6"
      time_pattern = /(\d+:\d+:\d+\.\d+|\d+:\d+\.\d+)/
      lap_times = lap_times_text.scan(time_pattern).flatten
      
      # Filter out times that might be duplicates of the total time
      # and return as array of time strings
      lap_times.uniq
    end
  end
end