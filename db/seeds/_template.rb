require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

# ===============================================================================
# RACE DATA - RACE NUMBER - RACE NAME (DATE)
# ===============================================================================

puts "Creating RACE NUMBER - RACE NAME and results..."

# Create the race
race = Race.find_or_create_by!(
  name: "RACE NUMBER - RACE NAME",
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
# import_division_results(race, "6th Grade Girls", lake_rebecca_6th_grade_girls_results, 1)
# import_division_results(race, "6th Grade Boys D2", lake_rebecca_6th_grade_boys_d2_results, 1)
# import_division_results(race, "6th Grade Boys D1", lake_rebecca_6th_grade_boys_d1_results, 1)
# import_division_results(race, "7th Grade Girls", lake_rebecca_7th_grade_girls_results, 1)
# import_division_results(race, "7th Grade Boys D2", lake_rebecca_7th_grade_boys_d2_results, 1)
# import_division_results(race, "7th Grade Boys D1", lake_rebecca_7th_grade_boys_d1_results, 1)
# import_division_results(race, "8th Grade Girls", lake_rebecca_8th_grade_girls_results, 1)
# import_division_results(race, "8th Grade Boys D2", lake_rebecca_8th_grade_boys_d2_results, 1)
# import_division_results(race, "8th Grade Boys D1", lake_rebecca_8th_grade_boys_d1_results, 1)
# import_division_results(race, "Freshman Boys D2", lake_rebecca_freshman_boys_d2_results, 1)
# import_division_results(race, "Freshman Boys D1", lake_rebecca_freshman_boys_d1_results, 1)
# import_division_results(race, "Freshman Girls", lake_rebecca_freshman_girls_results, 1)
# import_division_results(race, "JV2 Girls", lake_rebecca_jv2_girls_results, 2)
# import_division_results(race, "JV3 Boys", lake_rebecca_jv3_boys_results, 3)
# import_division_results(race, "Varsity Boys", lake_rebecca_varsity_boys_results, 4)
# import_division_results(race, "Varsity Girls", lake_rebecca_varsity_girls_results, 4)
# import_division_results(race, "JV3 Girls", lake_rebecca_jv3_girls_results, 3)
# import_division_results(race, "JV2 Boys D2", lake_rebecca_jv2_boys_d2_results, 2)
# import_division_results(race, "JV2 Boys D1", lake_rebecca_jv2_boys_d1_results, 2)

puts "\n🎉 RACE NUMBER - RACE NAME seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"