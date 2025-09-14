#!/usr/bin/env ruby

# Script to extract race data arrays from existing seed files
# Usage: ruby lib/race_data/extract_race_data.rb db/seeds/2024_brophy_park.rb

require 'fileutils'
require 'date'

if ARGV.length != 1
  puts "Usage: ruby lib/race_data/extract_race_data.rb <seed_file_path>"
  exit 1
end

seed_file = ARGV[0]
unless File.exist?(seed_file)
  puts "Error: File #{seed_file} does not exist"
  exit 1
end

content = File.read(seed_file)

# Extract race name and date from the file
race_name = nil
race_date = nil
race_location = nil

if content =~ /name: "([^"]+)"/
  race_name = $1
end

if content =~ /race_date: Date\.parse\("([^"]+)"\)/
  race_date = $1
end

if content =~ /race\.location = "([^"]+)"/
  race_location = $1
end

# Extract data arrays
data_arrays = []
current_array = nil
array_content = []
bracket_count = 0
in_array = false

content.lines.each_with_index do |line, index|
  line = line.chomp
  
  # Check if this is the start of a data array
  if line =~ /^(\w+_results) = \[/
    current_array = $1
    array_content = [line]
    bracket_count = line.count('[') - line.count(']')
    in_array = true
  elsif in_array
    array_content << line
    bracket_count += line.count('[') - line.count(']')
    
    if bracket_count == 0
      data_arrays << {
        name: current_array,
        content: array_content.join("\n")
      }
      in_array = false
      current_array = nil
      array_content = []
    end
  end
end

# Generate the refactored file
base_name = File.basename(seed_file, '.rb')
output_file = "db/seeds/#{base_name}_refactored.rb"

File.open(output_file, 'w') do |f|
  f.puts "require_relative '../../lib/race_data/race_seed_helpers'"
  f.puts ""
  f.puts "# Include the shared helpers"
  f.puts "include RaceData::RaceSeedHelpers"
  f.puts ""
  f.puts "# " + "=" * 79
  f.puts "# RACE DATA - #{race_name} (#{race_date})"
  f.puts "# " + "=" * 79
  f.puts ""
  f.puts "puts \"Creating #{race_name} and results...\""
  f.puts ""
  f.puts "# Create the race"
  f.puts "race = Race.find_or_create_by!("
  f.puts "  name: \"#{race_name}\","
  f.puts "  race_date: Date.parse(\"#{race_date}\")"
  f.puts ") do |race|"
  f.puts "  race.location = \"#{race_location}\""
  f.puts "  race.year = #{Date.parse(race_date).year}"
  f.puts "end"
  f.puts ""
  f.puts "puts \"✓ Race: \#{race.name} (\#{race.race_date})\""
  f.puts ""
  f.puts "# " + "=" * 79
  f.puts "# RACE RESULTS DATA"
  f.puts "# " + "=" * 79
  f.puts ""
  
  # Add all data arrays
  data_arrays.each do |array|
    f.puts "# #{array[:name].gsub('_', ' ').split.map(&:capitalize).join(' ')}"
    f.puts array[:content]
    f.puts ""
  end
  
  f.puts "# " + "=" * 79
  f.puts "# IMPORT ALL DIVISIONS"
  f.puts "# " + "=" * 79
  f.puts ""
  
  # Hardcoded division mappings - these categories are standardized and won't change
  division_mappings = {
    # Grade-based divisions (1 lap)
    'brophy_6th_grade_girls_results' => ['6th Grade Girls', 1],
    'brophy_6th_grade_boys_d2_results' => ['6th Grade Boys D2', 1],
    'brophy_6th_grade_boys_d1_results' => ['6th Grade Boys D1', 1],
    'brophy_7th_grade_girls_results' => ['7th Grade Girls', 1],
    'brophy_7th_grade_boys_d2_results' => ['7th Grade Boys D2', 1],
    'brophy_7th_grade_boys_d1_results' => ['7th Grade Boys D1', 1],
    'brophy_8th_grade_girls_results' => ['8th Grade Girls', 1],
    'brophy_8th_grade_boys_d2_results' => ['8th Grade Boys D2', 1],
    'brophy_8th_grade_boys_d1_results' => ['8th Grade Boys D1', 1],
    'brophy_freshman_girls_results' => ['Freshman Girls', 1],
    'brophy_freshman_boys_d2_results' => ['Freshman Boys D2', 1],
    'brophy_freshman_boys_d1_results' => ['Freshman Boys D1', 1],
    
    # JV2 divisions (2 laps)
    'brophy_jv2_girls_results' => ['JV2 Girls', 2],
    'brophy_jv2_boys_d2_results' => ['JV2 Boys D2', 2],
    'brophy_jv2_boys_d1_results' => ['JV2 Boys D1', 2],
    
    # JV3 divisions (3 laps)
    'brophy_jv3_girls_results' => ['JV3 Girls', 3],
    'brophy_jv3_boys_results' => ['JV3 Boys', 3],
    
    # Varsity divisions (4 laps)
    'brophy_varsity_girls_results' => ['Varsity Girls', 4],
    'brophy_varsity_boys_results' => ['Varsity Boys', 4],
    
    # Whitetail Ridge equivalents
    'whitetail_6th_grade_girls_results' => ['6th Grade Girls', 1],
    'whitetail_6th_grade_boys_d2_results' => ['6th Grade Boys D2', 1],
    'whitetail_6th_grade_boys_d1_results' => ['6th Grade Boys D1', 1],
    'whitetail_7th_grade_girls_results' => ['7th Grade Girls', 1],
    'whitetail_7th_grade_boys_d2_results' => ['7th Grade Boys D2', 1],
    'whitetail_7th_grade_boys_d1_results' => ['7th Grade Boys D1', 1],
    'whitetail_8th_grade_girls_results' => ['8th Grade Girls', 1],
    'whitetail_8th_grade_boys_d2_results' => ['8th Grade Boys D2', 1],
    'whitetail_8th_grade_boys_d1_results' => ['8th Grade Boys D1', 1],
    'whitetail_freshman_girls_results' => ['Freshman Girls', 1],
    'whitetail_freshman_boys_d2_results' => ['Freshman Boys D2', 1],
    'whitetail_freshman_boys_d1_results' => ['Freshman Boys D1', 1],
    'whitetail_jv2_girls_results' => ['JV2 Girls', 2],
    'whitetail_jv2_boys_d2_results' => ['JV2 Boys D2', 2],
    'whitetail_jv2_boys_d1_results' => ['JV2 Boys D1', 2],
    'whitetail_jv3_girls_results' => ['JV3 Girls', 3],
    'whitetail_jv3_boys_results' => ['JV3 Boys', 3],
    'whitetail_varsity_girls_results' => ['Varsity Girls', 4],
    'whitetail_varsity_boys_results' => ['Varsity Boys', 4]
  }
  
  # For future races, add pattern matching for unknown arrays
  data_arrays.each do |array|
    array_name = array[:name]
    unless division_mappings[array_name]
      puts "WARNING: Unknown division '#{array_name}' - please add to hardcoded mappings"
      
      # Fallback pattern matching
      if array_name =~ /.*_(.+)_results$/
        category_part = $1
        category = category_part.gsub('_', ' ').split.map(&:capitalize).join(' ')
        
        # Guess expected laps
        expected_laps = 1
        expected_laps = 2 if category.include?('JV2')
        expected_laps = 3 if category.include?('JV3')
        expected_laps = 4 if category.include?('Varsity')
        
        division_mappings[array_name] = [category, expected_laps]
      end
    end
  end
  
  data_arrays.each do |array|
    if division_mappings[array[:name]]
      category, laps = division_mappings[array[:name]]
      f.puts "import_division_results(race, \"#{category}\", #{array[:name]}, #{laps})"
    end
  end
  
  f.puts ""
  f.puts "puts \"\\n🎉 #{race_name} seed data created successfully!\""
  f.puts "puts \"Total racers imported: \#{RaceResult.where(race: race).count}\""
  f.puts ""
  f.puts "# Note: This seed file contains race data for #{race_name}"
  f.puts "# from #{race_date}, with complete data integrity."
end

puts "Refactored seed file created: #{output_file}"
puts "Original: #{File.size(seed_file)} bytes"
puts "Refactored: #{File.size(output_file)} bytes"
puts "Reduction: #{((File.size(seed_file) - File.size(output_file)).to_f / File.size(seed_file) * 100).round(1)}%"