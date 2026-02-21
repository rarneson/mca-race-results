require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - RACE 1 - SCHINDLER'S WAY (2023-08-26)
# ===============================================================================

puts "Creating Race 1 - Schindler's Way results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 1 - Schindler's Way",
  race_date: Date.parse("2023-08-26")
) do |race|
  race.location = "Austin, MN"
  race.year = 2023
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

#6th Grade Girls Results
results_6th_grade_girls = [
  # TODO: Add actual race results data here
  # Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
  # Example: [1, "Firstname", "Lastname", "Team Name", "100512776", "6524", 1, "00:19:20.0", "00:19:20.0", "finished"],
]

#6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [1, "Efram", "Beuning", "St Cloud", "100532467", "6209", 1, "00:17:56.0", "00:17:56.0", nil, nil, nil, "finished", nil, nil],
  [2, "Levi", "Hansen", "St Cloud", "100531503", "6211", 1, "00:18:21.3", "00:18:21.3", nil, nil, nil, "finished", nil, nil],
  [3, "Tyler", "Tate", "St Louis Park HS", "100529334", "6221", 1, "00:18:22.6", "00:18:22.6", nil, nil, nil, "finished", nil, nil],
  [4, "Cody", "Petrack", "Rock Ridge", "100516625", "6192", 1, "00:19:13.4", "00:19:13.4", nil, nil, nil, "finished", nil, nil],
  [5, "Zander", "Maul", "BBBikers", "100518535", "6016", 1, "00:19:16.4", "00:19:16.4", nil, nil, nil, "finished", nil, nil],
  [6, "Danny", "Towers", "Rochester Area", "100519694", "6182", 1, "00:19:47.5", "00:19:47.5", nil, nil, nil, "finished", nil, nil],
  [7, "Henry", "Medhus", "North Dakota", "100523070", "6164", 1, "00:19:47.9", "00:19:47.9", nil, nil, nil, "finished", nil, nil],
  [8, "Olin", "Bujold", "Tioga Trailblazers", "100489293", "6233", 1, "00:19:51.0", "00:19:51.0", nil, nil, nil, "finished", nil, nil],
  [9, "Marcus", "Brand", "Austin HS", "100515824", "6011", 1, "00:20:03.4", "00:20:03.4", nil, nil, nil, "finished", nil, nil],
  [10, "Henry", "Brouwer", "Rockford", "100513879", "6195", 1, "00:20:06.2", "00:20:06.2", nil, nil, nil, "finished", nil, nil],
  [11, "Henry", "Osburn", "Bloomington Jefferson", "100510972", "6028", 1, "00:20:08.2", "00:20:08.2", nil, nil, nil, "finished", nil, nil],
  [12, "Ryan", "Kokotnich", "Roseville", "100510797", "6200", 1, "00:20:13.7", "00:20:13.7", nil, nil, nil, "finished", nil, nil],
  [13, "Benjamin", "Hutchinson", "Orono HS", "100531386", "6166", 1, "00:20:37.5", "00:20:37.5", nil, nil, nil, "finished", nil, nil],
  [14, "Emin", "Erenter", "St Louis Park HS", "100517696", "6216", 1, "00:20:45.2", "00:20:45.2", nil, nil, nil, "finished", nil, nil],
  [15, "Jax", "Schildgen", "Lake Area Composite", "100532634", "6049", 1, "00:21:22.5", "00:21:22.5", nil, nil, nil, "finished", nil, nil],
  [16, "Owen", "Berg", "Austin HS", "100510964", "6010", 1, "00:21:42.8", "00:21:42.8", nil, nil, nil, "finished", nil, nil],
  [17, "Marcus", "Fiedler", "BBBikers", "100530795", "6014", 1, "00:21:44.0", "00:21:44.0", nil, nil, nil, "finished", nil, nil],
  [18, "Gray", "Schmidt", "Elk River", "100511109", "6083", 1, "00:21:44.8", "00:21:44.8", nil, nil, nil, "finished", nil, nil],
  [19, "Elliot", "Freeman", "Roseville", "100530582", "6199", 1, "00:21:45.9", "00:21:45.9", nil, nil, nil, "finished", nil, nil],
  [20, "Gil", "Horkey", "Minneapolis Roosevelt HS", "100516076", "6111", 1, "00:21:46.9", "00:21:46.9", nil, nil, nil, "finished", nil, nil],
  [21, "Micah", "Meiser", "Minneapolis Roosevelt HS", "100513858", "6113", 1, "00:21:50.2", "00:21:50.2", nil, nil, nil, "finished", nil, nil],
  [22, "Merrick", "Henderson", "Apple Valley HS", "100525046", "6005", 1, "00:21:54.5", "00:21:54.5", nil, nil, nil, "finished", nil, nil],
  [23, "Tristen", "Peters", "Armstrong Cycle", "100522931", "6009", 1, "00:22:12.9", "00:22:12.9", nil, nil, nil, "finished", nil, nil],
  [24, "Silas", "Boden", "St Croix", "100513016", "6212", 1, "00:22:17.0", "00:22:17.0", nil, nil, nil, "finished", nil, nil],
  [25, "Elliot", "Curtis", "St Louis Park HS", "100515026", "6215", 1, "00:22:22.6", "00:22:22.6", nil, nil, nil, "finished", nil, nil],
  [26, "Gavin", "Taylor", "Chaska HS", "100535430", "6047", 1, "00:22:23.6", "00:22:23.6", nil, nil, nil, "finished", nil, nil],
  [27, "Greylin", "Cline", "Breck", "100535312", "6036", 1, "00:22:35.0", "00:22:35.0", nil, nil, nil, "finished", nil, nil],
  [28, "Nick", "Campbell", "Orono HS", "100535629", "6165", 1, "00:22:37.0", "00:22:37.0", nil, nil, nil, "finished", nil, nil],
  [29, "Ben", "Peterson", "Rock Ridge", "100522435", "6191", 1, "00:22:37.2", "00:22:37.2", nil, nil, nil, "finished", nil, nil],
  [30, "Harrison", "Young", "St Louis Park HS", "100522519", "6222", 1, "00:22:38.2", "00:22:38.2", nil, nil, nil, "finished", nil, nil],
  [31, "Jacob", "Pshon", "St Louis Park HS", "100510609", "6220", 1, "00:22:39.4", "00:22:39.4", nil, nil, nil, "finished", nil, nil],
  [32, "Axton", "Zick", "River Falls HS", "100510472", "6178", 1, "00:22:39.8", "00:22:39.8", nil, nil, nil, "finished", nil, nil],
  [33, "Peter", "Martinson", "Minneapolis South HS", "100514067", "6114", 1, "00:22:40.4", "00:22:40.4", nil, nil, nil, "finished", nil, nil],
  [34, "Oliver", "Dundee", "Waconia HS", "100535552", "6237", 1, "00:22:46.7", "00:22:46.7", nil, nil, nil, "finished", nil, nil],
  [35, "Theodore", "Brokering", "Bloomington Jefferson", "100514151", "6025", 1, "00:22:56.9", "00:22:56.9", nil, nil, nil, "finished", nil, nil],
  [36, "Gilbert", "Nelson", "Osseo Composite", "100528205", "6167", 1, "00:22:58.1", "00:22:58.1", nil, nil, nil, "finished", nil, nil],
  [37, "Eli", "Haglof", "Totino Grace-Irondale", "100514481", "6236", 1, "00:23:03.1", "00:23:03.1", nil, nil, nil, "finished", nil, nil],
  [38, "Walt", "Hughes", "Minneapolis Roosevelt HS", "100524956", "6112", 1, "00:23:23.0", "00:23:23.0", nil, nil, nil, "finished", nil, nil],
  [39, "Charlie", "Dixon", "Roseville", "100521844", "6198", 1, "00:23:24.6", "00:23:24.6", nil, nil, nil, "finished", nil, nil],
  [40, "Jack", "Bond", "Eden Prairie HS", "100534454", "6066", 1, "00:23:28.4", "00:23:28.4", nil, nil, nil, "finished", nil, nil],
  [41, "Graham", "Wojcik", "Elk River", "100528484", "6084", 1, "00:23:30.1", "00:23:30.1", nil, nil, nil, "finished", nil, nil],
  [42, "Ellery", "Fay", "Minneapolis Roosevelt HS", "100511315", "6110", 1, "00:23:31.6", "00:23:31.6", nil, nil, nil, "finished", nil, nil],
  [43, "Sam", "Heitman", "Hutchinson Tigers", "100521405", "6103", 1, "00:23:58.4", "00:23:58.4", nil, nil, nil, "finished", nil, nil],
  [44, "Cam", "Slavey", "Winona", "100511907", "6238", 1, "00:23:58.9", "00:23:58.9", nil, nil, nil, "finished", nil, nil],
  [45, "Will", "Bakken", "St Louis Park HS", "100516837", "6214", 1, "00:24:01.8", "00:24:01.8", nil, nil, nil, "finished", nil, nil],
  [46, "Kai", "Lander", "Eastview HS", "100520776", "6063", 1, "00:24:28.1", "00:24:28.1", nil, nil, nil, "finished", nil, nil],
  [47, "Morgan", "Patterson", "Osseo Composite", "100529670", "6168", 1, "00:24:36.5", "00:24:36.5", nil, nil, nil, "finished", nil, nil],
  [48, "Everett", "Hutton", "Hudson HS", "100510645", "6101", 1, "00:24:39.4", "00:24:39.4", nil, nil, nil, "finished", nil, nil],
  [49, "Jameson", "La Barbera", "St Louis Park HS", "100523472", "6219", 1, "00:24:39.5", "00:24:39.5", nil, nil, nil, "finished", nil, nil],
  [50, "Samuel", "Heinecke", "East Ridge HS", "100527016", "6062", 1, "00:24:44.4", "00:24:44.4", nil, nil, nil, "finished", nil, nil],
  [51, "Madden", "Lorenz", "Lake Area Composite", "100532574", "6048", 1, "00:24:48.8", "00:24:48.8", nil, nil, nil, "finished", nil, nil],
  [52, "Brody", "Brown", "Rock Ridge", "100520357", "6187", 1, "00:24:51.6", "00:24:51.6", nil, nil, nil, "finished", nil, nil],
  [53, "Gabriel", "Cesari", "Bloomington Jefferson", "100531095", "6026", 1, "00:24:54.4", "00:24:54.4", nil, nil, nil, "finished", nil, nil],
  [54, "Anders", "Dolimar", "Bloomington Jefferson", "100516525", "6027", 1, "00:25:16.1", "00:25:16.1", nil, nil, nil, "finished", nil, nil],
  [55, "Evan", "Johnson", "Breck", "100529852", "6038", 1, "00:25:21.4", "00:25:21.4", nil, nil, nil, "finished", nil, nil],
  [56, "Luke", "Druckman", "Armstrong Cycle", "100530251", "6007", 1, "00:25:32.0", "00:25:32.0", nil, nil, nil, "finished", nil, nil],
  [57, "Logan", "Schroeder", "Minnesota Valley", "100529457", "6132", 1, "00:26:01.5", "00:26:01.5", nil, nil, nil, "finished", nil, nil],
  [58, "Samuel", "Dybvig", "Armstrong Cycle", "100530115", "6008", 1, "00:26:09.1", "00:26:09.1", nil, nil, nil, "finished", nil, nil],
  [59, "Owen", "Ruzicka", "BBBikers", "100527180", "6018", 1, "00:26:25.3", "00:26:25.3", nil, nil, nil, "finished", nil, nil],
  [60, "Tyler", "Huebert", "Rochester Area", "100524869", "6181", 1, "00:26:48.1", "00:26:48.1", nil, nil, nil, "finished", nil, nil],
  [61, "Orion", "Evenson", "Rock Ridge", "100529105", "6188", 1, "00:28:54.8", "00:28:54.8", nil, nil, nil, "finished", nil, nil],
  [62, "Orion", "Koon", "St Paul Composite - South", "100519224", "6227", 1, "00:29:20.0", "00:26:20.0", nil, nil, nil, "finished", "3 Min", "Outside Assist"],
]

#6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [1, "Mason", "Glynn", "Edina Cycling", "100480235", "7562", 1, "23:11.8", "23:11.8", nil, nil, nil, "finished", nil, nil],
  [2, "Asher", "Prevost", "Hopkins HS", "100461654", "7588", 1, "23:18.8", "23:18.8", nil, nil, nil, "finished", nil, nil],
  [3, "Connor", "Simurdiak", "Minneapolis Southwest HS", "100462488", "7631", 1, "23:49.6", "23:49.6", nil, nil, nil, "finished", nil, nil],
  [4, "Francis", "Knobel", "Minneapolis Southwest HS", "100466559", "7629", 1, "24:00.9", "24:00.9", nil, nil, nil, "finished", nil, nil],
  [5, "Elliot", "Gruhn", "Hopkins HS", "100461645", "7586", 1, "24:08.7", "24:08.7", nil, nil, nil, "finished", nil, nil],
  [6, "Asher", "Plante", "Hopkins HS", "100480802", "7587", 1, "24:16.4", "24:16.4", nil, nil, nil, "finished", nil, nil],
  [7, "Andrew", "Metzger", "Edina Cycling", "100482793", "7568", 1, "24:24.7", "24:24.7", nil, nil, nil, "finished", nil, nil],
  [8, "Lee", "Evans", "Rock Ridge", "100460343", "7660", 1, "24:30.4", "24:30.4", nil, nil, nil, "finished", nil, nil],
  [9, "Nolan", "Simpson", "Edina Cycling", "100474277", "7572", 1, "24:32.2", "24:32.2", nil, nil, nil, "finished", nil, nil],
  [10, "Charles", "Griffiths", "Edina Cycling", "100470407", "7563", 1, "24:55.3", "24:55.3", nil, nil, nil, "finished", nil, nil],
  [11, "Beckham", "Trigger", "Edina Cycling", "100467497", "7577", 1, "25:01.3", "25:01.3", nil, nil, nil, "finished", nil, nil],
  [12, "Austin", "Miller", "Minneapolis Southwest HS", "100475703", "7630", 1, "25:28.5", "25:28.5", nil, nil, nil, "finished", nil, nil],
  [13, "Trent", "Van Sloun", "Edina Cycling", "100473951", "7578", 1, "25:28.8", "25:28.8", nil, nil, nil, "finished", nil, nil],
  [14, "Owen", "Kes", "Lakeville North HS", "100466579", "7593", 1, "25:30.4", "25:30.4", nil, nil, nil, "finished", nil, nil],
  [15, "Tommy", "Raine", "Edina Cycling", "100473330", "7570", 1, "25:38.4", "25:38.4", nil, nil, nil, "finished", nil, nil],
  [16, "Benji", "Stoebner", "Edina Cycling", "100479947", "7575", 1, "27:01.9", "27:01.9", nil, nil, nil, "finished", nil, nil],
  [17, "Jack", "Zabel", "Edina Cycling", "100473326", "7579", 1, "27:36.6", "27:36.6", nil, nil, nil, "finished", nil, nil],
  [18, "Gael", "Fox", "Edina Cycling", "100471144", "7561", 1, "29:15.2", "29:15.2", nil, nil, nil, "finished", nil, nil],
  [19, "Rhys", "Schaefer", "Edina Cycling", "100473853", "7571", 1, "29:26.7", "29:26.7", nil, nil, nil, "finished", nil, nil],
  [20, "Mackinley", "Northenscold", "Edina Cycling", "100474040", "7569", 1, "34:21.0", "34:21.0", nil, nil, nil, "finished", nil, nil],
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

puts "\n🎉 Race 1 - Schindler's Way seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
