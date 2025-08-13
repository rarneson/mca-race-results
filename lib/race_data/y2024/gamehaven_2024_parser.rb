require_relative '../base_mca_parser'

module RaceData
  class Gamehaven2024Parser < BaseMcaParser
    def can_parse?(text)
      text.include?("Race 4S - Gamehaven Rochester") && 
      text.include?("September 21-22, 2024") &&
      text.include?("Division:")
    end

    def extract_race_data
      text = extract_text
      
      {
        race_info: extract_gamehaven_race_info(text),
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
          result = parse_gamehaven_result_line(line, current_division)
          results << result if result
        end
      end
      
      results
    end

    def parse_gamehaven_result_line(line, division)
      return nil if line.strip.empty?
      
      # Gamehaven format: Place Name Team Rider# Plate Laps Penalty Comment Total Lap1...
      # Very similar to Brophy Park format
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
      
      # Clean Gamehaven specific text extraction artifacts
      cleaned_full_name = clean_gamehaven_name(full_name)
      
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

    def clean_gamehaven_name(name)
      # Gamehaven specific name cleaning
      # Looking at the sample data, names seem cleaner than Lake Rebecca
      # But we can add rules as we find issues
      cleaned = name.strip
      
      # Add specific cleanup rules for Gamehaven as we discover them
      
      cleaned
    end

    def extract_gamehaven_race_info(text)
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      
      {
        name: "Race 4S - Gamehaven Rochester",
        race_date: Date.parse("September 21, 2024"),
        location: "Gamehaven Rochester",
        year: 2024,
        series: "Minnesota Cycling Association"
      }
    end
  end
end