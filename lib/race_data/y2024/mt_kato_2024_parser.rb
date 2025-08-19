require_relative '../base_mca_parser'
require_relative '../team_name_extractor'

module RaceData
  class MtKato2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 5S - Mt Kato Official Results") && 
      text.include?("Sept 28-29 2024") &&
      text.include?("Division:")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_kato_race_info(text),
        results: extract_results(text)
      }
    end

    private

    def extract_kato_race_info(text)
      {
        name: "Race 5S - Mt Kato Official Results",
        race_date: Date.parse("September 28, 2024"),
        location: "Mt Kato",
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
          result = parse_kato_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def parse_kato_result_line(line, division)
      return nil if line.strip.empty?
      
      # Mt Kato format: Place Name Team Rider# Plate Laps Penalty Comment Total Lap1...
      # Key differences: Proper case names, 00:MM:SS.s time format
      match = line.match(/^\s*(\d+)\s+([A-Za-z\s\-\.]+?)\s{2,}([A-Za-z\s\-\.]+?)\s+(\d{8,9})\s+(\d{4})\s+(\d+)\s.*?(00:\d+:\d+\.\d+|\d+:\d+\.\d+)(.*)$/)
      
      return nil unless match
      
      place = match[1].to_i
      full_name = match[2].strip
      # Extract team using improved logic
      name_and_team_text = match[2].strip + ' ' + match[3].strip
      team_name = TeamNameExtractor.extract_team_name(name_and_team_text) || match[3].strip
      rider_number = match[4]
      plate_number = match[5]
      laps = match[6].to_i
      total_time = match[7]
      lap_times_text = match[8]&.strip
      
      # Clean and convert proper case names to consistent format
      cleaned_full_name = clean_kato_name(full_name)
      
      # Split name into first/last
      name_parts = cleaned_full_name.split(/\s+/)
      first_name = name_parts[0]
      last_name = name_parts.length > 1 ? name_parts[1..-1].join(" ") : name_parts[0]
      
      # Clean time format (remove leading 00: if present)
      cleaned_total_time = total_time.sub(/^00:/, "")
      
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
        lap_times: parse_kato_lap_times(lap_times_text)
      }
    end

    def clean_kato_name(name)
      # Mt Kato uses proper case, convert to uppercase for consistency with other races
      name.strip.upcase
    end

    def parse_kato_lap_times(lap_times_text)
      return [] if lap_times_text.blank?
      
      # Extract time patterns, handling both 00:MM:SS.s and MM:SS.s formats
      time_pattern = /(00:\d+:\d+\.\d+|\d+:\d+\.\d+)/
      lap_times = lap_times_text.scan(time_pattern).flatten
      
      # Clean up times (remove 00: prefix) and return
      lap_times.uniq.map { |time| time.sub(/^00:/, "") }
    end
  end
end