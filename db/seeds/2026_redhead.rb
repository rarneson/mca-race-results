require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

# ===============================================================================
# RACE DATA - Race 9 - Redhead State Championship (October 10, 2026)
# ===============================================================================

puts "Creating Race 9 - Redhead State Championship results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 9 - Redhead State Championship",
  race_date: Date.parse("October 10, 2026")
) do |race|
  race.location = "Redhead"
  race.year = 2026
end

race.update!(description: "Lap times were not recorded for this race. The chip reader sat off the regular lap course, so Freshman, JV2, JV3 and Varsity results show only each rider's total time. Middle school races are one lap, so their lap time is the total.")

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Nora", "Walz", "Roseville", "100601054", "6555", 1, "19:22.6", "19:22.6", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Delaney", "Wilcox", "Maple Grove HS", "100603365", "6529", 1, "19:23.7", "19:23.7", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Elise", "Broski", "Rochester Mayo", "100601500", "6549", 1, "20:07.2", "20:07.2", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Ana", "Bolinske", "Edina Cycling", "100601511", "6515", 1, "20:41.8", "20:41.8", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Carly", "Evans", "Rock Ridge", "100602620", "6550", 1, "21:02.9", "21:02.9", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Emma", "Overbye", "Rock Ridge", "100616906", "6551", 1, "21:06.6", "21:06.6", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Eleanor", "Amys-Roe", "Cannon Valley", "100602057", "6508", 1, "21:10.1", "21:10.1", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Marikka", "Wheeler", "St Paul Central", "100566702", "6560", 1, "21:50.1", "21:50.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Fern", "Seibold", "Minneapolis Roosevelt HS", "100607395", "6531", 1, "22:00.7", "22:00.7", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Maeve", "Young", "St Louis Park HS", "100601888", "6559", 1, "22:14.7", "22:14.7", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Svea", "Widenbrant", "Stillwater Mountain Bike", "100603694", "6563", 1, "22:18.0", "22:18.0", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Molly", "Gilbert", "Edina Cycling", "100601680", "6518", 1, "22:20.6", "22:20.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Victoria", "Malecha", "Mounds View HS", "100601555", "6537", 1, "22:37.4", "22:37.4", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Stella", "Triebenbach", "Minneapolis Roosevelt HS", "100608029", "6533", 1, "22:38.6", "22:38.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Eva", "Ready", "Crosby-Ironton HS", "100602647", "6513", 1, "22:40.5", "22:40.5", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Claire", "Green", "Austin HS", "100618926", "6505", 1, "22:41.1", "22:41.1", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Stella", "Cruze", "Alexandria Youth Cycling", "100571993", "6501", 1, "22:42.5", "22:42.5", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Violet", "Baldwin", "Mounds View HS", "100606124", "6535", 1, "22:45.1", "22:45.1", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Ruby", "LaFrance", "Wayzata Mountain Bike", "100601694", "6568", 1, "22:51.3", "22:51.3", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Wren", "Wilichowski", "Stillwater Mountain Bike", "100604828", "6564", 1, "22:53.5", "22:53.5", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Eliza", "Zick", "River Falls HS", "100601941", "6547", 1, "23:05.1", "23:05.1", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Maisy", "Lennartson", "Minnetonka HS", "100601858", "6534", 1, "23:25.4", "23:25.4", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Katherine", "Dahn", "New Prague MS and HS", "100621152", "6541", 1, "23:34.2", "23:34.2", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Isabella", "Truckenmiller", "East Ridge HS", "100603408", "6514", 1, "23:39.7", "23:39.7", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Hadley", "Rickert", "Osseo HS", "100603159", "6543", 1, "23:40.0", "23:40.0", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Hazel", "Johnson", "Hopkins HS", "100617147", "6522", 1, "23:40.8", "23:40.8", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Mavis", "Bujold", "Tioga Trailblazers", "100617440", "6565", 1, "23:49.9", "23:49.9", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Lilly", "Richter", "Mounds View HS", "100602677", "6538", 1, "24:01.3", "24:01.3", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Bridget", "Cassleman", "BBBikers", "100614156", "6507", 1, "24:05.0", "24:05.0", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Maisie", "Wilcox", "Wayzata Mountain Bike", "100606846", "6571", 1, "24:10.9", "24:10.9", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Hartley", "Urban", "Rosemount HS", "100610871", "6553", 1, "24:18.6", "24:18.6", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Elin", "Schroeder", "Prior Lake HS", "100606181", "6546", 1, "24:36.2", "24:36.2", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Magnolia", "Tiller", "Park HS", "100603381", "6545", 1, "24:39.1", "24:39.1", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Lillian", "Eastman", "Edina Cycling", "100604248", "6516", 1, "24:42.3", "24:42.3", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Lilah", "DiGiovanni", "Crosby-Ironton HS", "100602652", "6512", 1, "24:42.5", "24:42.5", nil, nil, nil, "finished", "Relegate 1", nil ],
  [ 36, "Kelsey", "Sletten", "Mankato West HS", "100618583", "6528", 1, "25:04.3", "25:04.3", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Clara", "Donahue", "Roseville", "100622565", "6554", 1, "25:11.3", "25:11.3", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Addison", "Preble", "Tioga Trailblazers", "100608730", "6567", 1, "25:12.9", "25:12.9", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Allie", "Nyholm", "Cloquet-Esko-Carlton", "100605697", "6511", 1, "25:32.2", "25:32.2", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Elliot", "Lindemann", "Armstrong Cycle", "100617647", "6504", 1, "25:52.2", "25:52.2", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Bria", "DeLoach", "Woodbury HS", "100613598", "6572", 1, "26:04.5", "26:04.5", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Jane", "Zabel", "Edina Cycling", "100601508", "6521", 1, "26:12.7", "26:12.7", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Clarissa", "Wilson", "ISD728", "100616004", "6524", 1, "26:38.6", "26:38.6", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Greta", "Fehr", "Minneapolis Roosevelt HS", "100609735", "6530", 1, "27:21.0", "27:21.0", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Gwen", "Thompson", "Mounds View HS", "100609927", "6539", 1, "27:49.2", "27:49.2", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Raleigh", "Johnson", "Mounds View HS", "100601687", "6536", 1, "28:24.8", "28:24.8", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Anna", "Johnson", "Stillwater Mountain Bike", "100611161", "6561", 1, "28:32.7", "28:32.7", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Nora", "Otis", "Wayzata Mountain Bike", "100603236", "6569", 1, "28:36.5", "28:36.5", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Charlotte", "Barlage", "New Prague MS and HS", "100617926", "6540", 1, "28:53.3", "28:53.3", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Cecilia", "Pawelk", "Hopkins HS", "100609104", "6523", 1, "28:53.8", "28:53.8", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Vivian", "Hamer", "St Louis Park HS", "100614167", "6558", 1, "28:57.2", "28:57.2", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Joanna", "Dougherty", "Rockford", "100623152", "6552", 1, "29:23.3", "29:23.3", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Phinley", "Campbell", "Chaska HS", "100606449", "6509", 1, "30:44.0", "34:44.0", nil, nil, nil, "finished", "-4 Min Delay (4 Min)", nil ],
  [ 54, "Tana", "Fox", "Edina Cycling", "100601541", "6517", 1, "31:29.8", "35:29.8", nil, nil, nil, "finished", "-4 Min Delay (4 Min)", nil ],
  [ 55, "Britta", "Carlson", "Shakopee HS", "100608717", "6556", 1, "31:30.5", "35:30.5", nil, nil, nil, "finished", "-4 Min Delay (4 Min)", nil ],
  [ 56, "Olive", "Reishus", "Alexandria Youth Cycling", "100605297", "6502", 1, "34:19.6", "29:19.6", nil, nil, nil, "finished", "5 Min Bike Swap", nil ],
  [ 57, "Alexia", "Selchow", "Osseo HS", "100611450", "6544", 1, "34:45.8", "34:45.8", nil, nil, nil, "finished", nil, nil ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Nathan", "Kralich", "Rock Ridge", "100599617", "6146", 1, "17:54.1", "17:54.1", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Augustus", "Lang", "Crosby-Ironton HS", "100610214", "6045", 1, "18:42.8", "18:42.8", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Evan", "Kes", "Lakeville North HS", "100602524", "6070", 1, "19:23.4", "19:23.4", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Dominic", "Lang", "Rockford", "100623200", "6152", 1, "19:46.1", "19:46.1", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Joey", "Felling", "River Falls HS", "100603016", "6175", 1, "20:10.4", "20:10.4", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Ronin", "Holappa", "Rock Ridge", "100614820", "6145", 1, "20:20.9", "20:20.9", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Logan", "Schildgen", "Lake Area Composite", "100604718", "6067", 1, "20:46.1", "20:46.1", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Gregory", "Pshon", "St Louis Park HS", "100610899", "6178", 1, "20:50.2", "20:50.2", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Wyatt", "Freborg", "Lake Area Composite", "100614459", "6065", 1, "21:09.2", "21:09.2", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Aaron", "Miracle", "St Paul Highland Park", "100602697", "6186", 1, "21:21.4", "21:21.4", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Dane", "Anderson", "Minneapolis Southwest HS", "100606093", "6092", 1, "21:29.2", "21:29.2", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Soren", "Smith", "Champlin Park HS", "100601983", "6028", 1, "21:31.7", "21:31.7", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Levi", "Kueffer", "Minneapolis Southwest HS", "100605420", "6095", 1, "21:32.5", "21:32.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Elliot", "Olson", "Minneapolis Southwest HS", "100606646", "6096", 1, "21:53.1", "21:53.1", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Andrew", "Schmitz", "Minnesota Valley", "100617464", "6102", 1, "21:58.0", "21:58.0", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Leo", "Barten", "Minnesota Valley", "100602232", "6100", 1, "21:59.3", "21:59.3", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Connor", "Zipoy", "St Louis Park HS", "100604303", "6179", 1, "22:27.1", "22:27.1", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Paul", "Nelson", "Minneapolis Southside", "100613516", "6091", 1, "22:30.7", "22:30.7", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Harrison", "Gaudreau", "Eastview HS", "100602540", "6049", 1, "22:36.7", "22:36.7", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Matthew", "Anderson", "Champlin Park HS", "100606878", "6026", 1, "22:41.2", "22:41.2", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Theodore", "Watson", "Mankato West HS", "100609577", "6082", 1, "22:42.6", "22:42.6", nil, nil, nil, "finished", nil, nil ],
  [ 22, "William", "Miles", "St Paul Highland Park", "100603385", "6185", 1, "22:43.8", "22:43.8", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Will", "Lane", "Mahtomedi HS", "100603592", "6076", 1, "22:45.1", "22:45.1", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Noah", "Brown", "Rock Ridge", "100610589", "6144", 1, "22:45.5", "22:45.5", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Casey", "Ryan", "St Cloud", "100623042", "6174", 1, "22:46.1", "22:46.1", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Lachlan", "Dietz", "Maple Grove HS", "100601827", "6083", 1, "22:51.7", "22:51.7", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Wyatt", "Erbach", "Westonka", "100619398", "6204", 1, "22:51.9", "22:51.9", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Everett", "Olson", "Maple Grove HS", "100601698", "6085", 1, "23:29.6", "23:29.6", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Austin", "Ludington", "East Ridge HS", "100606471", "6048", 1, "23:56.4", "23:56.4", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Lucas", "Herrera Vasquez", "Roseville", "100617438", "6154", 1, "23:58.1", "23:58.1", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Ethan", "Maloney", "Chanhassen HS", "100622167", "6030", 1, "24:05.0", "24:05.0", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Sebastian", "Udell", "St Paul Composite - South", "100606308", "6183", 1, "24:08.5", "24:08.5", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Barrett", "Siedow", "Lake Area Composite", "100611234", "6068", 1, "24:11.0", "24:11.0", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Holden", "Behrens", "Minneapolis Southwest HS", "100608161", "6094", 1, "24:11.4", "24:11.4", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Boaz", "Youngren", "Tioga Trailblazers", "100565730", "6192", 1, "24:11.8", "24:11.8", nil, nil, nil, "finished", nil, nil ],
  [ 36, "August", "Gall", "St Cloud", "100622536", "6170", 1, "24:18.5", "24:18.5", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Tyler", "Doescher", "ISD728", "100618972", "6064", 1, "24:21.9", "24:21.9", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Samuel", "Parker", "Lakeville North HS", "100605668", "6072", 1, "24:23.5", "24:23.5", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Samuel", "Taylor", "Chaska HS", "100615356", "6034", 1, "24:23.5", "24:23.5", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Logan", "Vargas", "Roseville", "100617507", "6155", 1, "24:55.9", "24:55.9", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Benjamin", "Chamberlin", "Crosby-Ironton HS", "100619899", "6043", 1, "24:56.7", "24:56.7", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Russell", "Kurt", "Eastview HS", "100602734", "6050", 1, "24:57.2", "24:57.2", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Eli", "Zadow", "Austin HS", "100604959", "6008", 1, "25:01.8", "25:01.8", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Riley", "Rostance", "Eagan HS", "100616737", "6046", 1, "25:02.4", "25:02.4", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Max", "Finney", "Roseville", "100617737", "6153", 1, "25:10.7", "25:10.7", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Augie", "Phelan", "Rochester Mayo", "100613044", "6142", 1, "25:11.6", "25:11.6", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Kaito", "Munden", "Rochester Area", "100613334", "6135", 1, "25:12.1", "25:12.1", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Jude", "Wetzel", "Minneapolis Southwest HS", "100610181", "6099", 1, "25:29.5", "25:29.5", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Colter", "Lusignan", "Minnesota Valley", "100613351", "6101", 1, "25:35.6", "25:35.6", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Charlie", "Kronstedt", "Crosby-Ironton HS", "100610704", "6044", 1, "25:42.2", "25:42.2", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Grant", "Brouwer", "Rockford", "100621247", "6148", 1, "25:42.8", "25:42.8", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Charlie", "Osburn", "Bloomington Jefferson", "100603024", "6010", 1, "25:57.6", "25:57.6", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Henrik", "Kro", "Breck", "100621239", "6015", 1, "27:10.3", "27:10.3", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Joseph", "Strahan", "Breck", "100616398", "6019", 1, "27:11.0", "27:11.0", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Wyatt", "Gondeck", "St Louis Park HS", "100621630", "6177", 1, "27:30.2", "27:30.2", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Wyatt", "Luckeroth", "St Cloud", "100617917", "6173", 1, "27:41.1", "27:41.1", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Hendrick", "DeBruin", "Mahtomedi HS", "100619887", "6075", 1, "28:03.8", "28:03.8", nil, nil, nil, "finished", nil, nil ],
  [ 58, "Callan", "Stoltz", "Mahtomedi HS", "100606750", "6079", 1, "28:04.5", "28:04.5", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Aslam", "Immamdeen", "Burnsville HS", "100606866", "6021", 1, "29:01.5", "29:01.5", nil, nil, nil, "finished", nil, nil ],
  [ 60, "Zach", "Torborg", "Eagan HS", "100607709", "6047", 1, "29:11.6", "29:11.6", nil, nil, nil, "finished", nil, nil ],
  [ 61, "Austin", "Raadt", "Cannon Valley", "100618798", "6025", 1, "29:54.9", "29:54.9", nil, nil, nil, "finished", nil, nil ],
  [ 62, "Tristan", "Gustafson", "Rockford", "100614525", "6149", 1, "35:59.5", "35:59.5", nil, nil, nil, "finished", nil, nil ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = []

# 7th Grade Girls Results
results_7th_grade_girls = []

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = []

# 7th Grade Boys D1 Results
results_7th_grade_boys_d1 = []

# 8th Grade Girls Results
results_8th_grade_girls = []

# 8th Grade Boys D2 Results
results_8th_grade_boys_d2 = []

# 8th Grade Boys D1 Results
results_8th_grade_boys_d1 = []

# Freshman Boys D2 Results
results_freshman_boys_d2 = []

# Freshman Boys D1 Results
results_freshman_boys_d1 = []

# Freshman Girls Results
results_freshman_girls = []

# JV2 Girls Results
results_jv2_girls = []

# JV3 Boys Results
results_jv3_boys = []

# Varsity Boys Results
results_varsity_boys = []

# JV3 Girls Results
results_jv3_girls = []

# Varsity Girls Results
results_varsity_girls = []

# JV2 Boys D2 Results
results_jv2_boys_d2 = []

# JV2 Boys D1 Results
results_jv2_boys_d1 = []

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
import_division_results(race, "JV3 Girls", results_jv3_girls, get_expected_laps("JV3 Girls"))
import_division_results(race, "Varsity Girls", results_varsity_girls, get_expected_laps("Varsity Girls"))
import_division_results(race, "JV2 Boys D2", results_jv2_boys_d2, get_expected_laps("JV2 Boys D2"))
import_division_results(race, "JV2 Boys D1", results_jv2_boys_d1, get_expected_laps("JV2 Boys D1"))

puts "\n🎉 Race 9 - Redhead State Championship seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
