require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - Race 1 - Schindler's Way Austin MN (DATE)
# ===============================================================================

puts "Creating Race 1 - Schindler's Way Austin MN and results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 1 - Schindler's Way",
  race_date: Date.parse("August 23-24, 2025"),
) do |race|
  race.location = "Austin, MN"
  race.year = 2025
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

#6th Grade Girls Results
schindlers_way_6th_grade_girls_results = [
  [1, "MARAH", "STRONG", "Eagan HS", "100557441", "7020", 2, "23:47.6", "11:26.0", "12:21.5", "finished"],
  [2, "RUBY", "PETERSON", "Minneapolis Southwest HS", "100560162", "7062", 2, "24:27.4", "12:13.0", "12:14.4", "finished"],
  [3, "DARCY", "BRODEGARD", "Minneapolis Washburn HS", "100570070", "7063", 2, "25:14.2", "12:36.0", "12:38.1", "finished"],
  [4, "ADELAIDE", "PREVOST", "Hopkins HS", "100557204", "7036", 2, "25:37.1", "12:47.0", "12:50.0", "finished"],
  [5, "AINSLEY", "LOVAAS", "Edina Cycling", "100565528", "7028", 2, "25:39.1", "12:49.0", "12:50.1", "finished"],
  [6, "ALISON", "LINDELL", "Wayzata Mountain Bike", "100559314", "7098", 2, "25:57.1", "12:57.0", "13:00.0", "finished"],
  [7, "ADELINE", "COYNE", "Minneapolis Southwest HS", "100569402", "7058", 2, "26:17.5", "13:07.0", "13:10.4", "finished"],
  [8, "QUINN", "SPARBY", "Hopkins HS", "100560169", "7037", 2, "26:21.8", "13:09.0", "13:12.8", "finished"],
  [9, "RUBY", "LINDOO", "Minneapolis Southwest HS", "100560191", "7061", 2, "26:27.8", "13:13.0", "13:14.8", "finished"],
  [10, "AVEN", "PENMAN", "St Croix", "100557185", "7089", 2, "26:28.8", "13:13.0", "13:15.7", "finished"],
  [11, "MAEVA", "GARTNER", "Apple Valley HS", "100565750", "7005", 2, "26:46.7", "12:56.0", "13:50.6", "finished"],
  [12, "SAVANNAH", "SLAVEY", "Winona", "100558457", "7100", 2, "26:47.8", "13:23.0", "13:24.7", "finished"],
  [13, "ELIANA", "MENK", "Mounds View HS", "100557512", "7069", 2, "26:51.0", "13:25.0", "13:25.9", "finished"],
  [14, "ILENE", "SHAFFNER", "Roseville", "100558309", "7085", 2, "27:12.2", "13:35.0", "13:37.1", "finished"],
  [15, "AUDREY", "WILLIAMSON", "St Paul Composite - North", "100574959", "7090", 2, "27:27.0", "13:43.0", "13:43.9", "finished"],
  [16, "ESME", "JORDAN", "Cloquet-Esko-Carlton", "100557596", "7012", 2, "27:29.2", "13:43.0", "13:46.2", "finished"],
  [17, "CORA", "KUMARAPERU", "Minneapolis Southwest HS", "100559969", "7060", 2, "27:44.5", "13:51.0", "13:53.4", "finished"],
  [18, "ELSA", "PUTTONEN", "Eagan HS", "100568929", "7019", 2, "28:38.4", "14:18.0", "14:20.3", "finished"],
  [19, "JUNE", "STEFFEL", "Mounds View HS", "100575024", "7071", 2, "29:41.6", "14:18.1", "15:23.5", "finished"],
  [20, "EMERSON", "EDMONDS", "Edina Cycling", "100565178", "7024", 2, "30:16.6", "14:31.3", "15:45.2", "finished"],
  [21, "ZIVA", "SIGNALNESS", "Hudson HS", "100554895", "7039", 2, "30:34.8", "14:25.7", "16:09.1", "finished"],
  [22, "SAMARA", "KHAN", "Wayzata Mountain Bike", "100579689", "7097", 2, "30:44.8", "14:24.6", "16:20.2", "finished"],
  [23, "ALPHA", "JUSTEN", "St Croix", "100557799", "7088", 1, "14:47.7", "14:47.7", nil, "finished"],
  [24, "CLARA", "GRESS", "Lakeville South", "100565088", "7043", 1, "14:51.6", "14:51.6", nil, "finished"],
  [25, "PIPER", "SCHILLER", "Rock Ridge", "100557162", "7084", 1, "14:56.0", "14:56.0", nil, "finished"],
  [26, "KEILANA", "SJOSTROM", "Mounds View HS", "100557244", "7070", 1, "15:12.6", "15:12.6", nil, "finished"],
  [27, "ANNABELLE", "JOHNSON", "Edina Cycling", "100565856", "7026", 1, "15:54.6", "15:54.6", nil, "finished"],
  [28, "MADELINE", "BONSTROM", "Edina Cycling", "100565776", "7023", 1, "16:01.4", "16:01.4", nil, "finished"],
  [29, "LUCIA", "VALDES CARRASCO", "Edina Cycling", "100565207", "7031", 1, "16:37.5", "16:37.5", nil, "finished"],
  [30, "DARA", "KASS", "Edina Cycling", "100562521", "7027", 1, "17:26.0", "17:26.0", nil, "finished"],
  [31, "PENELOPE", "GREIMEL", "Edina Cycling", "100565316", "7025", 1, "18:51.3", "18:51.3", nil, "finished"],
  [32, "FIONA", "BLACK", "Edina Cycling", "100563289", "7022", 1, "19:42.1", "19:42.1", nil, "finished"],
  [33, "HAZEL", "MILNES", "Hopkins HS", "100565955", "7035", 1, "23:41.2", "23:41.2", nil, "finished"],
]

#6th Grade Boys D2 Results
schindlers_way_6th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

#6th Grade Boys D1 Results
schindlers_way_6th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

#7th Grade Girls Results
schindlers_way_7th_grade_girls_results = [
  # TODO: Add actual race results data here
]

#7th Grade Boys D2 Results
schindlers_way_7th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

#7th Grade Boys D1 Results
schindlers_way_7th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

#8th Grade Girls Results
schindlers_way_8th_grade_girls_results = [
  # TODO: Add actual race results data here
]

#8th Grade Boys D2 Results
schindlers_way_8th_grade_boys_d2_results = [
  # TODO: Add actual race results data here
]

#8th Grade Boys D1 Results
schindlers_way_8th_grade_boys_d1_results = [
  # TODO: Add actual race results data here
]

#Freshman Boys D2 Results
schindlers_way_freshman_boys_d2_results = [
  # TODO: Add actual race results data here
]

#Freshman Boys D1 Results
schindlers_way_freshman_boys_d1_results = [
  # TODO: Add actual race results data here
]

#Freshman Girls Results
schindlers_way_freshman_girls_results = [
  # TODO: Add actual race results data here
]

#JV2 Girls Results
schindlers_way_jv2_girls_results = [
  # TODO: Add actual race results data here
]

#JV3 Boys Results
schindlers_way_jv3_boys_results = [
  # TODO: Add actual race results data here
]

#Varsity Boys Results
schindlers_way_varsity_boys_results = [
  # TODO: Add actual race results data here
]

#Varsity Girls Results
schindlers_way_varsity_girls_results = [
  # TODO: Add actual race results data here
]

#JV3 Girls Results
schindlers_way_jv3_girls_results = [
  # TODO: Add actual race results data here
]

#JV2 Boys D2 Results
schindlers_way_jv2_boys_d2_results = [
  # TODO: Add actual race results data here
]

#JV2 Boys D1 Results
schindlers_way_jv2_boys_d1_results = [
  # TODO: Add actual race results data here
]

# ===============================================================================
# IMPORT ALL DIVISIONS
# ===============================================================================

# TODO: Uncomment these lines once race results data is added above
import_division_results(race, "6th Grade Girls", schindlers_way_6th_grade_girls_results, get_expected_laps("6th Grade Girls"))
# import_division_results(race, "6th Grade Boys D2", schindlers_way_6th_grade_boys_d2_results, get_expected_laps("6th Grade Boys D2"))
# import_division_results(race, "6th Grade Boys D1", schindlers_way_6th_grade_boys_d1_results, get_expected_laps("6th Grade Boys D1"))
# import_division_results(race, "7th Grade Girls", schindlers_way_7th_grade_girls_results, get_expected_laps("7th Grade Girls"))
# import_division_results(race, "7th Grade Boys D2", schindlers_way_7th_grade_boys_d2_results, get_expected_laps("7th Grade Boys D2"))
# import_division_results(race, "7th Grade Boys D1", schindlers_way_7th_grade_boys_d1_results, get_expected_laps("7th Grade Boys D1"))
# import_division_results(race, "8th Grade Girls", schindlers_way_8th_grade_girls_results, get_expected_laps("8th Grade Girls"))
# import_division_results(race, "8th Grade Boys D2", schindlers_way_8th_grade_boys_d2_results, get_expected_laps("8th Grade Boys D2"))
# import_division_results(race, "8th Grade Boys D1", schindlers_way_8th_grade_boys_d1_results, get_expected_laps("8th Grade Boys D1"))
# import_division_results(race, "Freshman Boys D2", schindlers_way_freshman_boys_d2_results, get_expected_laps("Freshman Boys D2"))
# import_division_results(race, "Freshman Boys D1", schindlers_way_freshman_boys_d1_results, get_expected_laps("Freshman Boys D1"))
# import_division_results(race, "Freshman Girls", schindlers_way_freshman_girls_results, get_expected_laps("Freshman Girls"))
# import_division_results(race, "JV2 Girls", schindlers_way_jv2_girls_results, get_expected_laps("JV2 Girls"))
# import_division_results(race, "JV3 Boys", schindlers_way_jv3_boys_results, get_expected_laps("JV3 Boys"))
# import_division_results(race, "Varsity Boys", schindlers_way_varsity_boys_results, get_expected_laps("Varsity Boys"))
# import_division_results(race, "Varsity Girls", schindlers_way_varsity_girls_results, get_expected_laps("Varsity Girls"))
# import_division_results(race, "JV3 Girls", schindlers_way_jv3_girls_results, get_expected_laps("JV3 Girls"))
# import_division_results(race, "JV2 Boys D2", schindlers_way_jv2_boys_d2_results, get_expected_laps("JV2 Boys D2"))
# import_division_results(race, "JV2 Boys D1", schindlers_way_jv2_boys_d1_results, get_expected_laps("JV2 Boys D1"))

puts "\n🎉 Race 1 - Schindler's Way Austin MN seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"