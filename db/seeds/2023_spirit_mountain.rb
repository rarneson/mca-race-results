require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - RACE 4 - SPIRIT MOUNTAIN (2023-09-16)
# ===============================================================================

puts "Creating Race 4 - Spirit Mountain results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 4 - Spirit Mountain",
  race_date: Date.parse("2023-09-16")
) do |race|
  race.location = "Duluth, MN"
  race.year = 2023
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

#6th Grade Girls Results
results_6th_grade_girls = [
  [1, "Rue", "Nelson", "Crosby-Ironton HS", "100486017", "7022", 1, "00:21:48.343", "00:21:48.343", nil, nil, nil, "finished", nil, nil],
  [2, "Brooke", "Verges", "St Croix", "100459696", "7073", 1, "00:22:09.039", "00:22:09.039", nil, nil, nil, "finished", nil, nil],
  [3, "Margot", "Toftness", "Crosby-Ironton HS", "100486370", "7023", 1, "00:22:32.872", "00:22:32.872", nil, nil, nil, "finished", nil, nil],
  [4, "Beck", "Sponholz", "Borealis", "100444918", "7010", 1, "00:23:40.131", "00:23:40.131", nil, nil, nil, "finished", nil, nil],
  [5, "Alyse", "Suchy", "Alexandria Youth Cycling", "100469138", "7004", 1, "00:23:44.051", "00:23:44.051", nil, nil, nil, "finished", nil, nil],
  [6, "Emelia", "Preston", "Alexandria Youth Cycling", "100473801", "7002", 1, "00:24:17.979", "00:24:17.979", nil, nil, nil, "finished", nil, nil],
  [7, "Fayanna", "Karel", "Mounds View HS", "100461301", "7050", 1, "00:25:04.106", "00:25:04.106", nil, nil, nil, "finished", nil, nil],
  [8, "Olivia", "Leow", "Cloquet-Esko-Carlton", "100470056", "7021", 1, "00:26:01.858", "00:26:01.858", nil, nil, nil, "finished", nil, nil],
  [9, "Ella", "Reineck", "Hudson HS", "100460239", "7040", 1, "00:26:14.190", "00:26:14.190", nil, nil, nil, "finished", nil, nil],
  [10, "Greta", "Nickleski", "River Falls HS", "100460683", "7063", 1, "00:26:16.358", "00:26:16.358", nil, nil, nil, "finished", nil, nil],
  [11, "Adiah", "Scherman", "New Prague MS and HS", "100483321", "7059", 1, "00:26:23.147", "00:26:23.147", nil, nil, nil, "finished", nil, nil],
  [12, "Nellie", "Reishus", "Alexandria Youth Cycling", "100470066", "7003", 1, "00:27:27.284", "00:27:27.284", nil, nil, nil, "finished", nil, nil],
  [13, "Grace", "Schumacher", "Stillwater Mountain Bike", "100478153", "7083", 1, "00:27:50.895", "00:27:50.895", nil, nil, nil, "finished", nil, nil],
  [14, "Lexi", "Hitchcock", "Cloquet-Esko-Carlton", "100464336", "7020", 1, "00:30:30.453", "00:30:30.453", nil, nil, nil, "finished", nil, nil],
  [15, "Hudson", "Sprunger", "East Ridge HS", "100392703", "7029", 1, "00:30:54.079", "00:30:54.079", nil, nil, nil, "finished", nil, nil],
  [16, "Gemma", "Cook", "Hudson HS", "100460093", "7039", 1, "00:32:53.020", "00:32:53.020", nil, nil, nil, "finished", nil, nil],
  [17, "Bethany", "Dougherty", "Rockford", "100488056", "7068", 1, "00:35:50.401", "00:35:50.401", nil, nil, nil, "finished", nil, nil],
  [18, "Eva", "Hane", "East Ridge HS", "100478127", "7028", 1, "00:36:16.899", "00:36:16.899", nil, nil, nil, "finished", nil, nil],
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

puts "\n🎉 Race 4 - Spirit Mountain seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
