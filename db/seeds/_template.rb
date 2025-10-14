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

puts "Creating Race NUMBER - RACE NAME results..."

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

#6th Grade Girls Results
results_6th_grade_girls = [
  # TODO: Add actual race results data here
  # Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
  # Example: [1, "FIRSTNAME", "LASTNAME", "Team Name", "100512776", "6524", 1, "00:19:20.0", "00:19:20.0", "finished"],
]

#6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  # TODO: Add actual race results data here
]

#6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  # TODO: Add actual race results data here
]

#7th Grade Girls Results
results_7th_grade_girls = [
  # TODO: Add actual race results data here
]

#7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  # TODO: Add actual race results data here
]

#7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  # TODO: Add actual race results data here
]

#8th Grade Girls Results
results_8th_grade_girls = [
  # TODO: Add actual race results data here
]

#8th Grade Boys D2 Results
results_8th_grade_boys_d2 = [
  # TODO: Add actual race results data here
]

#8th Grade Boys D1 Results
results_8th_grade_boys_d1 = [
  # TODO: Add actual race results data here
]

#Freshman Boys D2 Results
results_freshman_boys_d2 = [
  # TODO: Add actual race results data here
]

#Freshman Boys D1 Results
results_freshman_boys_d1 = [
  # TODO: Add actual race results data here
]

#Freshman Girls Results
results_freshman_girls = [
  # TODO: Add actual race results data here
]

#JV2 Girls Results
results_jv2_girls = [
  # TODO: Add actual race results data here
]

#JV3 Boys Results
results_jv3_boys = [
  # TODO: Add actual race results data here
]

#Varsity Boys Results
results_varsity_boys = [
  # TODO: Add actual race results data here
]

#JV3 Girls Results
results_jv3_girls = [
  # TODO: Add actual race results data here
]

#Varsity Girls Results
results_varsity_girls = [
  # TODO: Add actual race results data here
]

#JV2 Boys D2 Results
results_jv2_boys_d2 = [
  # TODO: Add actual race results data here
]

#JV2 Boys D1 Results
results_jv2_boys_d1 = [
  # TODO: Add actual race results data here
]

# ===============================================================================
# IMPORT ALL DIVISIONS
# ===============================================================================

# TODO: Uncomment these lines once race results data is added above
import_division_results(race, "6th Grade Girls", results_6th_grade_girls, get_expected_laps("6th Grade Girls"))
import_division_results(race, "6th Grade Boys D2", results_6th_grade_boys_d2, get_expected_laps("6th Grade Boys D2"))
import_division_results(race, "6th Grade Boys D1", results_6th_grade_boys_d1, get_expected_laps("6th Grade Boys D1"))
import_division_results(race, "7th Grade Girls", results_7th_grade_girls, get_expected_laps("7th Grade Girls"))
import_division_results(race, "7th Grade Boys D2", results_7th_grade_boys_d2, get_expected_laps("7th Grade Boys D2"))
import_division_results(race, "7th Grade Boys D1", results_7th_grade_boys_d1, get_expected_laps("7th Grade Boys D1"))
import_division_results(race, "8th Grade Girls", results_8th_grade_girls, get_expected_laps("8th Grade Girls"))
import_division_results(race, "8th Grade Boys D2", results_8th_grade_boys_d2, get_expected_laps("8th Grade Boys D2"))
import_division_results(race, "8th Grade Boys D1", results_8th_grade_boys_d1, get_expected_laps("8th Grade Boys D1"))
import_division_results(race, "Freshman Boys D2", results_freshman_boys_d2, get_expected_laps("Freshman Boys D2"))
import_division_results(race, "Freshman Boys D1", results_freshman_boys_d1, get_expected_laps("Freshman Boys D1"))
import_division_results(race, "Freshman Girls", results_freshman_girls, get_expected_laps("Freshman Girls"))
import_division_results(race, "JV2 Girls", results_jv2_girls, get_expected_laps("JV2 Girls"))
import_division_results(race, "JV3 Boys", results_jv3_boys, get_expected_laps("JV3 Boys"))
import_division_results(race, "Varsity Boys", results_varsity_boys, get_expected_laps("Varsity Boys"))
import_division_results(race, "Varsity Girls", results_varsity_girls, get_expected_laps("Varsity Girls"))
import_division_results(race, "JV3 Girls", results_jv3_girls, get_expected_laps("JV3 Girls"))
import_division_results(race, "JV2 Boys D2", results_jv2_boys_d2, get_expected_laps("JV2 Boys D2"))
import_division_results(race, "JV2 Boys D1", results_jv2_boys_d1, get_expected_laps("JV2 Boys D1"))

puts "\n🎉 RACE NUMBER - RACE NAME seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"