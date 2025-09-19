require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - RACE NUMBER - RACE NAME (DATE)
# ===============================================================================

puts "Creating Race NUMBER - RACE NAME and results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race NUMBER - RACE NAME",
  race_date: Date.parse("DATE")
) do |race|
  race.location = "RACE NAME"
  race.year = 2024
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# RACE NAME 6th Grade Girls Results
lake_rebecca_6th_grade_girls_results = [
  # TODO: Add actual race results data here
  # Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
  # Example: [1, "FIRSTNAME", "LASTNAME", "Team Name", "100512776", "6524", 1, "00:19:20.0", "00:19:20.0", "finished"],
]

# RACE NAME 6th Grade Boys D2 Results
lake_rebecca_6th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 6th Grade Boys D1 Results
lake_rebecca_6th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 7th Grade Girls Results
lake_rebecca_7th_grade_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 7th Grade Boys D2 Results
lake_rebecca_7th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 7th Grade Boys D1 Results
lake_rebecca_7th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 8th Grade Girls Results
lake_rebecca_8th_grade_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 8th Grade Boys D2 Results
lake_rebecca_8th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

# RACE NAME 8th Grade Boys D1 Results
lake_rebecca_8th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

# RACE NAME Freshman Boys D2 Results
lake_rebecca_freshman_boys_d2_results = [
  # TODO: Add actual race results data here
]

# RACE NAME Freshman Boys D1 Results
lake_rebecca_freshman_boys_d1_results = [
  # TODO: Add actual race results data here
]

# RACE NAME Freshman Girls Results
lake_rebecca_freshman_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME JV2 Girls Results
lake_rebecca_jv2_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME JV3 Boys Results
lake_rebecca_jv3_boys_results = [
  # TODO: Add actual race results data here
]

# RACE NAME Varsity Boys Results
lake_rebecca_varsity_boys_results = [
  # TODO: Add actual race results data here
]

# RACE NAME Varsity Girls Results
lake_rebecca_varsity_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME JV3 Girls Results
lake_rebecca_jv3_girls_results = [
  # TODO: Add actual race results data here
]

# RACE NAME JV2 Boys D2 Results
lake_rebecca_jv2_boys_d2_results = [
  # TODO: Add actual race results data here
]

# RACE NAME JV2 Boys D1 Results
lake_rebecca_jv2_boys_d1_results = [
  # TODO: Add actual race results data here
]

# ===============================================================================
# IMPORT ALL DIVISIONS
# ===============================================================================

# TODO: Uncomment these lines once race results data is added above
# import_division_results(race, "6th Grade Girls", race_name_6th_grade_girls_results, get_expected_laps("6th Grade Girls"))
# import_division_results(race, "6th Grade Boys D2", race_name_6th_grade_boys_d2_results, get_expected_laps("6th Grade Boys D2"))
# import_division_results(race, "6th Grade Boys D1", race_name_6th_grade_boys_d1_results, get_expected_laps("6th Grade Boys D1"))
# import_division_results(race, "7th Grade Girls", race_name_7th_grade_girls_results, get_expected_laps("7th Grade Girls"))
# import_division_results(race, "7th Grade Boys D2", race_name_7th_grade_boys_d2_results, get_expected_laps("7th Grade Boys D2"))
# import_division_results(race, "7th Grade Boys D1", race_name_7th_grade_boys_d1_results, get_expected_laps("7th Grade Boys D1"))
# import_division_results(race, "8th Grade Girls", race_name_8th_grade_girls_results, get_expected_laps("8th Grade Girls"))
# import_division_results(race, "8th Grade Boys D2", race_name_8th_grade_boys_d2_results, get_expected_laps("8th Grade Boys D2"))
# import_division_results(race, "8th Grade Boys D1", race_name_8th_grade_boys_d1_results, get_expected_laps("8th Grade Boys D1"))
# import_division_results(race, "Freshman Boys D2", race_name_freshman_boys_d2_results, get_expected_laps("Freshman Boys D2"))
# import_division_results(race, "Freshman Boys D1", race_name_freshman_boys_d1_results, get_expected_laps("Freshman Boys D1"))
# import_division_results(race, "Freshman Girls", race_name_freshman_girls_results, get_expected_laps("Freshman Girls"))
# import_division_results(race, "JV2 Girls", race_name_jv2_girls_results, get_expected_laps("JV2 Girls"))
# import_division_results(race, "JV3 Boys", race_name_jv3_boys_results, get_expected_laps("JV3 Boys"))
# import_division_results(race, "Varsity Boys", race_name_varsity_boys_results, get_expected_laps("Varsity Boys"))
# import_division_results(race, "Varsity Girls", race_name_varsity_girls_results, get_expected_laps("Varsity Girls"))
# import_division_results(race, "JV3 Girls", race_name_jv3_girls_results, get_expected_laps("JV3 Girls"))
# import_division_results(race, "JV2 Boys D2", race_name_jv2_boys_d2_results, get_expected_laps("JV2 Boys D2"))
# import_division_results(race, "JV2 Boys D1", race_name_jv2_boys_d1_results, get_expected_laps("JV2 Boys D1"))

puts "\n🎉 RACE NUMBER - RACE NAME seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"