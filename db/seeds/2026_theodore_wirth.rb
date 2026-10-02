require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

# ===============================================================================
# RACE DATA - Race 7 - Theodore Wirth Park (September 26, 2026)
# ===============================================================================

puts "Creating Race 7 - Theodore Wirth Park results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 7 - Theodore Wirth Park",
  race_date: Date.parse("September 26, 2026")
) do |race|
  race.location = "Theodore Wirth Park"
  race.year = 2026
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Nora", "Walz", "Roseville", "100601054", "6555", 1, "17:40.7", "17:40.7", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Ana", "Bolinske", "Edina Cycling", "100601511", "6515", 1, "17:48.0", "17:48.0", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Maeve", "Young", "St Louis Park HS", "100601888", "6559", 1, "19:10.0", "19:10.0", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Eleanor", "Amys-Roe", "Cannon Valley", "100602057", "6508", 1, "19:33.5", "19:33.5", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Emma", "Overbye", "Rock Ridge", "100616906", "6551", 1, "19:42.1", "19:42.1", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Victoria", "Malecha", "Mounds View HS", "100601555", "6537", 1, "19:45.7", "19:45.7", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Stella", "Triebenbach", "Minneapolis Roosevelt HS", "100608029", "6533", 1, "19:45.9", "19:45.9", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Fern", "Seibold", "Minneapolis Roosevelt HS", "100607395", "6531", 1, "19:46.9", "19:46.9", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Violet", "Baldwin", "Mounds View HS", "100606124", "6535", 1, "19:48.4", "19:48.4", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Ruby", "LaFrance", "Wayzata Mountain Bike", "100601694", "6568", 1, "19:49.3", "19:49.3", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Stella", "Cruze", "Alexandria Youth Cycling", "100571993", "6501", 1, "20:48.5", "20:48.5", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Lilly", "Richter", "Mounds View HS", "100602677", "6538", 1, "20:51.4", "20:51.4", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Molly", "Gilbert", "Edina Cycling", "100601680", "6518", 1, "21:11.4", "21:11.4", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Maisy", "Lennartson", "Minnetonka HS", "100601858", "6534", 1, "21:12.0", "21:12.0", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Maisie", "Wilcox", "Wayzata Mountain Bike", "100606846", "6571", 1, "21:14.2", "21:14.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Bridget", "Cassleman", "BBBikers", "100614156", "6507", 1, "21:15.7", "21:15.7", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Hazel", "Johnson", "Hopkins HS", "100617147", "6522", 1, "21:17.1", "21:17.1", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Gwen", "Thompson", "Mounds View HS", "100609927", "6539", 1, "21:30.1", "21:30.1", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Nona", "Reitz", "Edina Cycling", "100601688", "6520", 1, "21:49.9", "21:49.9", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Lillian", "Eastman", "Edina Cycling", "100604248", "6516", 1, "21:50.9", "21:50.9", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Olive", "Reishus", "Alexandria Youth Cycling", "100605297", "6502", 1, "21:52.8", "21:52.8", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Etta", "Van De Velde", "Mahtomedi HS", "100623235", "6527", 1, "21:52.8", "21:52.8", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Greta", "Fehr", "Minneapolis Roosevelt HS", "100609735", "6530", 1, "22:00.2", "22:00.2", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Mavis", "Bujold", "Tioga Trailblazers", "100617440", "6565", 1, "23:15.8", "23:15.8", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Vivian", "Hamer", "St Louis Park HS", "100614167", "6558", 1, "23:29.5", "23:29.5", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Elliot", "Lindemann", "Armstrong Cycle", "100617647", "6504", 1, "24:41.9", "24:41.9", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Raleigh", "Johnson", "Mounds View HS", "100601687", "6536", 1, "24:49.8", "24:49.8", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Nora", "Otis", "Wayzata Mountain Bike", "100603236", "6569", 1, "25:08.8", "25:08.8", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Cecilia", "Pawelk", "Hopkins HS", "100609104", "6523", 1, "25:10.0", "25:10.0", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Molly", "Smith", "Alexandria Youth Cycling", "100619185", "6503", 1, "26:03.1", "26:03.1", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Britta", "Carlson", "Shakopee HS", "100608717", "6556", 1, "26:20.0", "26:20.0", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Tana", "Fox", "Edina Cycling", "100601541", "6517", 1, "27:07.5", "27:07.5", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Joanna", "Dougherty", "Rockford", "100623152", "6552", 1, "28:19.7", "28:19.7", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Carly", "Evans", "Rock Ridge", "100602620", "6550", 0, "", "", nil, nil, nil, "DNF", nil, nil ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Nathan", "Kralich", "Rock Ridge", "100599617", "6146", 1, "16:45.6", "16:45.6", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Dominic", "Lang", "Rockford", "100623200", "6152", 1, "17:29.5", "17:29.5", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Gregory", "Pshon", "St Louis Park HS", "100610899", "6178", 1, "17:45.8", "17:45.8", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Tristan", "Gustafson", "Rockford", "100614525", "6149", 1, "17:52.5", "17:52.5", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Ronin", "Holappa", "Rock Ridge", "100614820", "6145", 1, "17:54.2", "17:54.2", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Will", "Lane", "Mahtomedi HS", "100603592", "6076", 1, "18:06.8", "18:06.8", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Wyatt", "Freborg", "Lake Area Composite", "100614459", "6065", 1, "18:06.9", "18:06.9", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Elliot", "Olson", "Minneapolis Southwest HS", "100606646", "6096", 1, "18:48.2", "18:48.2", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Levi", "Kueffer", "Minneapolis Southwest HS", "100605420", "6095", 1, "18:48.3", "18:48.3", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Connor", "Zipoy", "St Louis Park HS", "100604303", "6179", 1, "18:48.8", "18:48.8", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Logan", "Schildgen", "Lake Area Composite", "100604718", "6067", 1, "18:49.2", "18:49.2", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Aaron", "Miracle", "St Paul Highland Park", "100602697", "6186", 1, "19:04.6", "19:04.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Dane", "Anderson", "Minneapolis Southwest HS", "100606093", "6092", 1, "19:09.4", "19:09.4", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Jackson", "Gerdes", "St Cloud", "100620652", "6171", 1, "19:14.1", "19:14.1", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Eli", "Hauge", "Rockford", "100619443", "6150", 1, "19:14.3", "19:14.3", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Casey", "Ryan", "St Cloud", "100623042", "6174", 1, "19:21.3", "19:21.3", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Bennett", "Turgeon", "Lake Area Composite", "100613095", "6069", 1, "19:58.2", "19:58.2", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Paul", "Nelson", "Minneapolis Southside", "100613516", "6091", 1, "20:15.5", "20:15.5", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Logan", "Vargas", "Roseville", "100617507", "6155", 1, "20:27.8", "20:27.8", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Noah", "Brown", "Rock Ridge", "100610589", "6144", 1, "20:28.6", "20:28.6", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Max", "Finney", "Roseville", "100617737", "6153", 1, "20:29.8", "20:29.8", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Barrett", "Siedow", "Lake Area Composite", "100611234", "6068", 1, "20:31.2", "20:31.2", nil, nil, nil, "finished", nil, nil ],
  [ 23, "William", "Miles", "St Paul Highland Park", "100603385", "6185", 1, "20:31.6", "20:31.6", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Lucas", "Herrera Vasquez", "Roseville", "100617438", "6154", 1, "20:57.3", "20:57.3", nil, nil, nil, "finished", nil, nil ],
  [ 25, "August", "Gall", "St Cloud", "100622536", "6170", 1, "21:17.7", "21:17.7", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Holden", "Behrens", "Minneapolis Southwest HS", "100608161", "6094", 1, "21:18.4", "21:18.4", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Jude", "Wetzel", "Minneapolis Southwest HS", "100610181", "6099", 1, "21:30.0", "21:30.0", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Sebastian", "Udell", "St Paul Composite - South", "100606308", "6183", 1, "21:41.2", "21:41.2", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Boaz", "Youngren", "Tioga Trailblazers", "100565730", "6192", 1, "21:50.2", "21:50.2", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Wyatt", "Gondeck", "St Louis Park HS", "100621630", "6177", 1, "22:06.5", "22:06.5", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Henry", "Miller", "St Paul Composite - North", "100606141", "6182", 1, "22:17.7", "22:17.7", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Hendrick", "DeBruin", "Mahtomedi HS", "100619887", "6075", 1, "22:20.6", "22:20.6", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Walter", "Anderson", "Minneapolis Southwest HS", "100606666", "6093", 1, "22:49.1", "22:49.1", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Charlie", "Osburn", "Bloomington Jefferson", "100603024", "6010", 1, "23:04.4", "23:04.4", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Grant", "Brouwer", "Rockford", "100621247", "6148", 1, "24:05.8", "24:05.8", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Andrew", "Polen", "BBBikers", "100616902", "6009", 1, "24:06.1", "24:06.1", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Evan", "Gunderson", "Cannon Valley", "100622154", "6024", 1, "24:06.5", "24:06.5", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Asa", "Tamminen", "Minneapolis Southwest HS", "100606478", "6097", 1, "25:00.1", "25:00.1", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Wyatt", "Luckeroth", "St Cloud", "100617917", "6173", 1, "25:34.0", "25:34.0", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Gabriel", "Hemmesch", "Rockford", "100610737", "6151", 1, "26:22.9", "26:22.9", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Eben", "Kantor", "St Paul Highland Park", "100617627", "6184", 1, "26:23.1", "26:23.1", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Austin", "Raadt", "Cannon Valley", "100618798", "6025", 1, "27:54.7", "27:54.7", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Abram", "Heggerston", "Lake Area Composite", "100601736", "6066", 1, "28:25.8", "28:25.8", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Angus", "Gunderson", "Cannon Valley", "100622152", "6023", 1, "29:33.0", "29:33.0", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Obree", "Terrill", "Mahtomedi HS", "100618095", "6080", 1, "30:05.2", "30:05.2", nil, nil, nil, "finished", nil, nil ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [ 1, "Daniel", "Clifford", "Edina Cycling", "100603998", "6054", 1, "16:13.4", "16:13.4", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Julian", "Sanchis", "Wayzata Mountain Bike", "100613857", "6200", 1, "17:35.8", "17:35.8", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Briggs", "Nyberg", "Alexandria Youth Cycling", "100620680", "6004", 1, "17:36.4", "17:36.4", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Geo", "Hirschman", "Wayzata Mountain Bike", "100605894", "6193", 1, "17:51.3", "17:51.3", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Axl", "Pieper", "Shakopee HS", "100611228", "6163", 1, "18:38.4", "18:38.4", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Cayden", "Stromwall", "Mounds View HS", "100601696", "6116", 1, "18:48.0", "18:48.0", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Maverick", "Tschida", "Shakopee HS", "100613304", "6166", 1, "18:48.6", "18:48.6", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Hudson", "Hentges", "Shakopee HS", "100601712", "6158", 1, "18:49.2", "18:49.2", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Huxley", "Alms", "Mounds View HS", "100608854", "6110", 1, "18:50.5", "18:50.5", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Calhoun", "Krieg", "Shakopee HS", "100601781", "6161", 1, "18:50.7", "18:50.7", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Alexander", "Johnson", "Shakopee HS", "100615939", "6159", 1, "19:00.0", "19:00.0", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Kellen", "Murtha", "Minneapolis Roosevelt HS", "100610824", "6090", 1, "19:00.2", "19:00.2", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Fritz", "Paulsen", "Wayzata Mountain Bike", "100605854", "6199", 1, "19:04.5", "19:04.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Jackson", "Klauck-Kolesar", "Minneapolis Roosevelt HS", "100605755", "6089", 1, "19:04.9", "19:04.9", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Lewis", "Bastian", "Edina Cycling", "100604602", "6052", 1, "19:09.6", "19:09.6", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Harrison", "Burg", "Minnetonka HS", "100617542", "6104", 1, "19:29.4", "19:29.4", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Harrison", "Lindau", "Mounds View HS", "100603059", "6114", 1, "19:37.1", "19:37.1", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Ethan", "Stults", "Wayzata Mountain Bike", "100602210", "6201", 1, "19:52.5", "19:52.5", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Grey", "Holloway", "Mounds View HS", "100601730", "6111", 1, "19:54.7", "19:54.7", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Jonas", "Bergsten", "Edina Cycling", "100604954", "6053", 1, "19:54.9", "19:54.9", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Crosby", "Gier", "Hopkins HS", "100609055", "6060", 1, "19:55.1", "19:55.1", nil, nil, nil, "finished", "Relegate 2", nil ],
  [ 22, "Jakob", "Knudson", "Edina Cycling", "100601566", "6058", 1, "20:00.6", "20:00.6", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Sam", "Mohr", "Wayzata Mountain Bike", "100602086", "6197", 1, "20:02.3", "20:02.3", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Owen", "Vagle", "Wayzata Mountain Bike", "100617034", "6202", 1, "20:03.4", "20:03.4", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Calvin", "Haar", "Hopkins HS", "100536993", "6061", 1, "20:07.2", "20:07.2", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Kai", "Downes", "Minneapolis Roosevelt HS", "100616890", "6087", 1, "20:10.6", "20:10.6", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Maverick", "Warner", "Wayzata Mountain Bike", "100609939", "6203", 1, "20:18.5", "20:18.5", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Silas", "Kellerman", "Alexandria Youth Cycling", "100602234", "6002", 1, "20:36.7", "20:36.7", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Martin", "Schmidt", "Minnetonka HS", "100615418", "6108", 1, "20:36.9", "20:36.9", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Cade", "Barnes", "Edina Cycling", "100604122", "6051", 1, "20:37.5", "20:37.5", nil, nil, nil, "finished", nil, nil ],
  [ 31, "John", "VanDyck", "Shakopee HS", "100611246", "6167", 1, "20:47.3", "20:47.3", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Bodin", "Sargent", "Minnetonka HS", "100618176", "6107", 1, "20:52.4", "20:52.4", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Everet", "Williams", "Shakopee HS", "100611414", "6168", 1, "21:04.2", "21:04.2", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Thor", "Ohnstad", "Wayzata Mountain Bike", "100605870", "6198", 1, "21:22.0", "21:22.0", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Walker", "Surcey", "Minnetonka HS", "100614079", "6109", 1, "21:22.1", "21:22.1", nil, nil, nil, "finished", nil, nil ],
  [ 36, "River", "Brasted", "Armstrong Cycle", "100610815", "6005", 1, "21:36.5", "21:36.5", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Riley", "Payne", "Armstrong Cycle", "100614551", "6007", 1, "22:02.6", "22:02.6", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Remy", "Fleuriet", "Minneapolis Roosevelt HS", "100617818", "6088", 1, "22:20.8", "22:20.8", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Lee", "Zook", "Shakopee HS", "100614124", "6169", 1, "22:20.9", "22:20.9", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Quentin", "Stark", "Shakopee HS", "100608011", "6165", 1, "22:28.5", "22:28.5", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Bjorn", "Jacobsen", "Mounds View HS", "100607596", "6113", 1, "22:32.8", "22:32.8", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Jack", "Beltrand", "Shakopee HS", "100612359", "6156", 1, "22:37.9", "22:37.9", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Matthew", "Holly Wells", "Mounds View HS", "100609391", "6112", 1, "22:45.0", "22:45.0", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Sigur", "Swingen", "Mounds View HS", "100611119", "6117", 1, "22:49.7", "22:49.7", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Gavin", "Maus", "Wayzata Mountain Bike", "100620030", "6196", 1, "23:17.0", "23:17.0", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Cruz", "Kashani", "Shakopee HS", "100611318", "6160", 1, "23:17.3", "23:17.3", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Ian", "Kershner", "Minnetonka HS", "100618163", "6106", 1, "23:19.9", "23:19.9", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Braydon", "Norlien", "Alexandria Youth Cycling", "100614657", "6003", 1, "24:12.4", "24:12.4", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Matthew", "Johnson", "Wayzata Mountain Bike", "100609230", "6194", 1, "31:23.8", "31:23.8", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Girls Results
results_7th_grade_girls = [
  [ 1, "Darcy", "Brodegard", "Minneapolis Washburn HS", "100570070", "5559", 1, "17:38.7", "17:38.7", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Ellie", "Gucinski", "St Cloud", "100566233", "5586", 1, "17:39.8", "17:39.8", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Alison", "Lindell", "Wayzata Mountain Bike", "100559314", "5596", 1, "17:41.1", "17:41.1", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Ainsley", "Lovaas", "Edina Cycling", "100565528", "5527", 1, "17:55.3", "17:55.3", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Victoria", "Maslev", "Edina Cycling", "100560004", "5528", 1, "18:28.0", "18:28.0", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Itzel", "Fischer", "Minneapolis Roosevelt HS", "100565973", "5552", 1, "18:28.6", "18:28.6", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Clara", "Bert", "Mahtomedi HS", "100557251", "5544", 1, "18:29.1", "18:29.1", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Ruby", "Peterson", "Minneapolis Southwest HS", "100560162", "5558", 1, "18:29.3", "18:29.3", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Adelaide", "Prevost", "Hopkins HS", "100557204", "5533", 1, "18:29.4", "18:29.4", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Ruby", "Lindoo", "Minneapolis Southwest HS", "100560191", "5557", 1, "19:09.0", "19:09.0", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Bonnie", "Bakken", "Minnetonka HS", "100613456", "5560", 1, "19:12.4", "19:12.4", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Olivia", "Prettner", "Hopkins HS", "100612111", "5532", 1, "19:18.2", "19:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Marit", "Willey", "Armstrong Cycle", "100574497", "5505", 1, "19:40.3", "19:40.3", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Aspen", "Rach", "Alexandria Youth Cycling", "100560214", "5502", 1, "20:09.2", "20:09.2", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Olive", "Oatman", "Edina Cycling", "100603959", "5529", 1, "20:09.8", "20:09.8", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Soli", "Cedarleaf Dahl", "Minneapolis Roosevelt HS", "100566686", "5551", 1, "20:15.3", "20:15.3", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Ilene", "Shaffner", "Roseville", "100558309", "5584", 1, "20:27.2", "20:27.2", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Eliana", "Menk", "Mounds View HS", "100557512", "5567", 1, "20:30.0", "20:30.0", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Ailie", "Lorenz", "Lake Area Composite", "100615258", "5538", 1, "20:33.1", "20:33.1", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Evelyn", "Baranowski", "Wayzata Mountain Bike", "100570608", "5594", 1, "20:41.9", "20:41.9", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Veda", "Acharya", "Wayzata Mountain Bike", "100602571", "5593", 1, "20:42.7", "20:42.7", nil, nil, nil, "finished", nil, nil ],
  [ 22, "June", "Steffel", "Mounds View HS", "100575024", "5569", 1, "20:47.2", "20:47.2", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Haley", "Carlstrom", "Wayzata Mountain Bike", "100608835", "5595", 1, "20:47.6", "20:47.6", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Ainsley", "Otis", "Wayzata Mountain Bike", "100564487", "5597", 1, "20:50.6", "20:50.6", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Elise", "Greiber", "Minnetonka HS", "100565634", "5562", 1, "20:50.8", "20:50.8", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Iris", "Rooney", "Alexandria Youth Cycling", "100574845", "5503", 1, "20:52.9", "20:52.9", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Eva", "Keane", "Mounds View HS", "100564360", "5566", 1, "20:53.3", "20:53.3", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Cora", "Kumaraperu", "Minneapolis Southwest HS", "100559969", "5556", 1, "21:09.0", "21:09.0", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Keilana", "Sjostrom", "Mounds View HS", "100557244", "5568", 1, "21:10.0", "21:10.0", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Colette", "Kuhlmann", "Minnetonka HS", "100561706", "5564", 1, "21:24.1", "21:24.1", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Emma", "Schnorr", "Shakopee HS", "100572327", "5585", 1, "21:24.9", "21:24.9", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Riley", "Soine", "Kerkhoven", "100565159", "5535", 1, "22:02.0", "22:02.0", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Addison", "Jurchenko", "Alexandria Youth Cycling", "100578073", "5501", 1, "23:24.9", "23:24.9", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Piper", "Schiller", "Rock Ridge", "100557162", "5583", 1, "23:25.0", "23:25.0", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Julia", "Flatau", "Northwest", "100582373", "5571", 1, "23:26.5", "23:26.5", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Olive", "Ortega", "Minneapolis Roosevelt HS", "100562123", "5553", 1, "23:28.3", "23:28.3", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Lucia", "Valdes Carrasco", "Edina Cycling", "100565207", "5530", 1, "23:28.5", "23:28.5", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Hannah", "Harrison", "Lake Area Composite", "100615378", "5536", 1, "23:31.0", "23:31.0", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Piper", "Bloom", "Mahtomedi HS", "100569051", "5545", 1, "24:05.2", "24:05.2", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Anna", "Kruger", "Lake Area Composite", "100603072", "5537", 1, "24:48.5", "24:48.5", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Quinn", "Vadnais", "White Bear Lake HS", "100610006", "5598", 1, "25:07.8", "25:07.8", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Devyn", "Alvey", "Bloomington", "100563086", "5507", 1, "25:24.2", "25:24.2", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Sara", "Shopbell", "Minnetonka HS", "100562879", "5565", 1, "25:53.8", "25:53.8", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Talley", "Oates", "Rock Ridge", "100565858", "5582", 1, "28:34.1", "28:34.1", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Dara", "Kass", "Edina Cycling", "100562521", "5526", 1, "29:14.7", "29:14.7", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Arthi", "Jayaram", "Minnetonka HS", "100618949", "5563", 1, "30:04.7", "30:04.7", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Hazel", "Milnes", "Hopkins HS", "100565955", "5531", 1, "30:47.1", "30:47.1", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Penelope", "Greimel", "Edina Cycling", "100565316", "5524", 1, "34:34.7", "34:34.7", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [ 1, "Malcolm", "Handeen", "Minneapolis South HS", "100568416", "5110", 1, "16:22.7", "16:22.7", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Finn", "Parr", "St Paul Composite - North", "100578755", "5226", 1, "16:23.0", "16:23.0", nil, nil, nil, "finished", nil, nil ],
  [ 3, "James", "Townsend", "Borealis", "100569053", "5027", 1, "16:23.2", "16:23.2", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Fisher", "Swanson", "St Louis Park HS", "100558724", "5219", 1, "16:52.6", "16:52.6", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Finnian", "Roark", "Rock Ridge", "100561104", "5193", 1, "16:53.3", "16:53.3", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Declan", "Urbowicz", "St Cloud", "100617429", "5205", 1, "17:03.1", "17:03.1", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Rowen", "Gardner", "Bloomington Jefferson", "100572122", "5022", 1, "17:13.3", "17:13.3", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Knox", "Connelly", "Tioga Trailblazers", "100535807", "5233", 1, "17:14.0", "17:14.0", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Ari", "Lund", "Northwest", "100561967", "5166", 1, "17:14.1", "17:14.1", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Coen", "Rathe", "St Louis Park HS", "100565784", "5216", 1, "17:17.3", "17:17.3", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Theodore", "Veneman", "Minneapolis Washburn HS", "100567563", "5126", 1, "17:18.2", "17:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Blake", "Nutz", "St Louis Park HS", "100578742", "5215", 1, "17:18.2", "17:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Tate", "Banks", "Lake Area Composite", "100563984", "5088", 1, "17:18.4", "17:18.4", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Milo", "Rathe", "St Louis Park HS", "100565782", "5217", 1, "17:20.6", "17:20.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Jerid Jr", "Adickes", "Rockford", "100533979", "5195", 1, "17:34.0", "17:34.0", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Oliver", "Thomas", "Minneapolis Washburn HS", "100605613", "5125", 1, "18:18.4", "18:18.4", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Kale", "Booker", "St Cloud", "100570556", "5203", 1, "18:30.6", "18:30.6", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Peyton", "Welch", "St Cloud", "100559724", "5206", 1, "18:33.2", "18:33.2", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Levi", "Bahnemann", "Lake Area Composite", "100557173", "5087", 1, "18:55.1", "18:55.1", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Theodor", "Boulton", "Roseville", "100571176", "5200", 1, "18:59.1", "18:59.1", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Joshua", "Groebner", "BBBikers", "100602780", "5016", 1, "18:59.2", "18:59.2", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Gregory", "Jakoblich", "Lake Area Composite", "100564953", "5089", 1, "19:01.7", "19:01.7", nil, nil, nil, "finished", nil, nil ],
  [ 23, "William", "Raabe", "Bloomington", "100557477", "5019", 1, "19:01.8", "19:01.8", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Teddy", "Osler", "Bloomington Jefferson", "100575384", "5023", 1, "19:02.8", "19:02.8", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Finnegan", "Marcelle", "St Paul Composite - North", "100403388", "5224", 1, "19:06.6", "19:06.6", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Carson", "Bjergaard", "Totino Grace-Irondale", "100558868", "5234", 1, "19:06.6", "19:06.6", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Sawyer", "Kannas", "Borealis", "100560574", "5025", 1, "19:07.4", "19:07.4", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Auden", "Zabler", "Minneapolis Southwest HS", "100610340", "5116", 1, "19:07.5", "19:07.5", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Theo", "Goepferd", "Minneapolis Washburn HS", "100569252", "5120", 1, "19:14.3", "19:14.3", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Wesley", "Healy", "St Louis Park HS", "100613052", "5212", 1, "19:21.2", "19:21.2", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Willem", "Obermoller", "St Paul Composite - North", "100559205", "5225", 1, "19:25.9", "19:25.9", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Easton", "Kramer", "St Louis Park HS", "100608091", "5214", 1, "19:28.7", "19:28.7", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Jesse", "Luckeroth", "St Cloud", "100607697", "5204", 1, "19:29.0", "19:29.0", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Nathan", "Marks", "Minneapolis Southwest HS", "100569777", "5114", 1, "19:37.3", "19:37.3", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Alistair", "Graves", "Cannon Valley", "100622435", "5033", 1, "19:40.3", "19:40.3", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Lucas", "Burgart", "St Louis Park HS", "100612256", "5209", 1, "19:43.4", "19:43.4", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Xander", "Alcivar", "Bloomington Jefferson", "100557242", "5020", 1, "19:45.9", "19:45.9", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Sam", "Johnson", "Lake Area Composite", "100559305", "5090", 1, "19:45.9", "19:45.9", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Brooks", "Creighton", "Roseville", "100578499", "5201", 1, "20:08.4", "20:08.4", nil, nil, nil, "finished", nil, nil ],
  [ 40, "James", "Duggan", "St Louis Park HS", "100613364", "5210", 1, "20:12.8", "20:12.8", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Lucas", "Swenson", "BBBikers", "100616356", "5017", 1, "20:13.0", "20:13.0", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Ernie", "Jaqua", "St Louis Park HS", "100608074", "5213", 1, "20:26.9", "20:26.9", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Fletcher", "Hiller", "Minneapolis Washburn HS", "100562002", "5121", 1, "20:45.7", "20:45.7", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Truman", "Winchester", "St Cloud", "100559639", "5207", 1, "20:46.3", "20:46.3", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Liam", "Stottler", "Minneapolis Northside", "100605825", "5102", 1, "20:48.2", "20:48.2", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Ryan", "Highfield", "Minneapolis Southwest HS", "100567445", "5113", 1, "21:03.3", "21:03.3", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Phillip", "Waldron", "St Louis Park HS", "100619116", "5220", 1, "21:07.9", "21:07.9", nil, nil, nil, "finished", nil, nil ],
  [ 48, "William", "Starr", "St Louis Park HS", "100604527", "5218", 1, "21:08.1", "21:08.1", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Evan", "Brottlund", "North Dakota", "100577126", "5161", 1, "21:34.7", "21:34.7", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Sam", "Beglinger", "Minneapolis Southwest HS", "100618664", "5111", 1, "21:55.0", "21:55.0", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Caleb", "Carrete", "North Dakota", "100577129", "5162", 1, "22:07.4", "22:07.4", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Porter", "Franciskovich", "Borealis", "100569713", "5024", 1, "22:24.2", "22:24.2", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Oliver", "Bemmels", "Bloomington Jefferson", "100622084", "5021", 1, "23:00.1", "23:00.1", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Owen", "Kuhlmey", "Northwest", "100615951", "5165", 1, "23:45.8", "23:45.8", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Simon", "Scott", "Minneapolis Washburn HS", "100569798", "5124", 1, "24:19.0", "24:19.0", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Tony", "Seeber", "Rock Ridge", "100575723", "5194", 1, "24:35.1", "24:35.1", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Solomon", "Bolduc", "Minneapolis Washburn HS", "100560763", "5119", 1, "26:16.3", "26:16.3", nil, nil, nil, "finished", nil, nil ],
  [ 58, "Robert", "Blackstock", "Minneapolis Washburn HS", "100571847", "5118", 1, "26:53.9", "26:53.9", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Charles", "Anderson", "Minneapolis Northside", "100622542", "5101", 1, "34:28.7", "34:28.7", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  [ 1, "Axel", "Wood", "Minnetonka HS", "100561861", "5148", 1, "15:50.2", "15:50.2", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Oliver", "Rients", "Shakopee HS", "100560968", "5202", 1, "16:40.1", "16:40.1", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Nathan", "Mazo", "Wayzata Mountain Bike", "100559458", "5241", 1, "16:52.7", "16:52.7", nil, nil, nil, "finished", nil, nil ],
  [ 4, "William", "Bolinske", "Edina Cycling", "100553034", "5059", 1, "16:53.4", "16:53.4", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Robert", "Mark", "Minnetonka HS", "100562133", "5139", 1, "16:58.3", "16:58.3", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Finn", "Richter", "Mounds View HS", "100564552", "5153", 1, "17:19.2", "17:19.2", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Cullen", "Baetz", "Wayzata Mountain Bike", "100560307", "5237", 1, "17:31.2", "17:31.2", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Levi", "Anderson", "Minnetonka HS", "100563356", "5129", 1, "17:39.1", "17:39.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Bjorn", "Robinson", "Mounds View HS", "100608908", "5155", 1, "17:57.5", "17:57.5", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Jean", "Tiziou", "Hopkins HS", "100562981", "5075", 1, "18:05.4", "18:05.4", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Joey", "Lazar", "Edina Cycling", "100565307", "5061", 1, "18:15.8", "18:15.8", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Torben", "Krumrich", "Hopkins HS", "100558156", "5072", 1, "18:15.9", "18:15.9", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Wylie", "Olson", "Edina Cycling", "100557551", "5064", 1, "18:44.5", "18:44.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Jaden", "Centanni", "Mounds View HS", "100557139", "5150", 1, "18:47.6", "18:47.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Miles", "Mack", "Minnetonka HS", "100613190", "5138", 1, "18:50.2", "18:50.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Rafferty", "Richardson", "White Bear Lake HS", "100610536", "5248", 1, "18:54.7", "18:54.7", nil, nil, nil, "finished", nil, nil ],
  [ 17, "William", "Hooker", "Minneapolis Roosevelt HS", "100564905", "5106", 1, "18:54.8", "18:54.8", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Gideon", "Yoder", "Armstrong Cycle", "100578480", "5012", 1, "19:01.1", "19:01.1", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Jack", "Reithel", "Minnetonka HS", "100561535", "5142", 1, "19:01.4", "19:01.4", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Ezra", "Handler", "Hopkins HS", "100557967", "5071", 1, "19:01.5", "19:01.5", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Thor", "Toftoy", "Minnetonka HS", "100565104", "5145", 1, "19:03.1", "19:03.1", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Christian", "Wagner", "Minnetonka HS", "100563846", "5146", 1, "19:20.2", "19:20.2", nil, nil, nil, "finished", nil, nil ],
  [ 23, "George", "Barthel", "Alexandria Youth Cycling", "100579561", "5001", 1, "19:22.1", "19:22.1", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Oscar", "Oatman", "Edina Cycling", "100560436", "5063", 1, "19:45.7", "19:45.7", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Jack", "Ficek", "Minnetonka HS", "100565756", "5133", 1, "19:52.3", "19:52.3", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Micah", "Klaetsch", "Alexandria Youth Cycling", "100557147", "5004", 1, "19:53.3", "19:53.3", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Finley", "Haefemeyer", "Minneapolis Roosevelt HS", "100561998", "5104", 1, "19:53.7", "19:53.7", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Palmer", "Egeberg", "Edina Cycling", "100605565", "5060", 1, "19:53.7", "19:53.7", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Thomas", "Aldrich", "Wayzata Mountain Bike", "100609689", "5236", 1, "19:54.1", "19:54.1", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Porter", "Bock", "White Bear Lake HS", "100621650", "5245", 1, "19:54.2", "19:54.2", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Otto", "Osborne", "White Bear Lake HS", "100615608", "5247", 1, "19:55.0", "19:55.0", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Jeremiah", "Texidor", "Minneapolis Roosevelt HS", "100562756", "5108", 1, "19:55.9", "19:55.9", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Declan", "Corcoran", "Hopkins HS", "100574935", "5070", 1, "19:58.2", "19:58.2", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Jackson", "Roehm", "Mounds View HS", "100557496", "5156", 1, "20:06.0", "20:06.0", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Ryder", "Fox", "Minnetonka HS", "100615232", "5135", 1, "20:07.0", "20:07.0", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Ryder", "Miller", "Minnetonka HS", "100563349", "5140", 1, "20:07.4", "20:07.4", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Luke", "Gagne", "Minnetonka HS", "100613406", "5136", 1, "20:08.8", "20:08.8", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Oliver", "Ullery", "Hopkins HS", "100565982", "5076", 1, "20:09.4", "20:09.4", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Bennett", "Farnsworth", "Mounds View HS", "100609029", "5151", 1, "20:13.9", "20:13.9", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Isaac", "Stanton", "White Bear Lake HS", "100607529", "5250", 1, "20:14.5", "20:14.5", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Griffin", "Peterson", "Alexandria Youth Cycling", "100560455", "5006", 1, "20:30.2", "20:30.2", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Samuel", "Rankl", "Alexandria Youth Cycling", "100571677", "5008", 1, "20:31.0", "20:31.0", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Bastian", "Ulmer", "Minneapolis Roosevelt HS", "100568053", "5109", 1, "20:32.4", "20:32.4", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Emmett", "Fox", "Minnetonka HS", "100615229", "5134", 1, "20:46.5", "20:46.5", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Kellen", "Gardino", "Minnetonka HS", "100613136", "5137", 1, "20:46.9", "20:46.9", nil, nil, nil, "finished", nil, nil ],
  [ 46, "William", "Rickson", "White Bear Lake HS", "100609443", "5249", 1, "20:50.6", "20:50.6", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Shawn", "Mccann", "Hopkins HS", "100560903", "5074", 1, "20:56.7", "20:56.7", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Martin", "Campbell", "Mounds View HS", "100564595", "5149", 1, "21:02.3", "21:02.3", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Simeon", "Pavlicek", "Wayzata Mountain Bike", "100579461", "5243", 1, "21:07.9", "21:07.9", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Max", "Sampson", "Minnetonka HS", "100619635", "5143", 1, "21:08.4", "21:08.4", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Eivind", "Berg", "Wayzata Mountain Bike", "100610279", "5239", 1, "21:12.5", "21:12.5", nil, nil, nil, "finished", nil, nil ],
  [ 52, "William", "Cass", "Alexandria Youth Cycling", "100576343", "5002", 1, "21:21.1", "21:21.1", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Maddox", "Ostendorf", "Wayzata Mountain Bike", "100608331", "5242", 1, "21:21.6", "21:21.6", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Louie", "Salmen", "Edina Cycling", "100562623", "5066", 1, "21:21.8", "21:21.8", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Everest", "Tidwell", "Minnetonka HS", "100618922", "5144", 1, "21:23.7", "21:23.7", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Benjamin", "Myss", "Minnetonka HS", "100613177", "5141", 1, "21:23.9", "21:23.9", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Paul", "Poerschke", "Edina Cycling", "100604453", "5065", 1, "22:41.6", "22:41.6", nil, nil, nil, "finished", nil, nil ],
  [ 58, "James", "Lash", "Wayzata Mountain Bike", "100610582", "5240", 1, "22:42.6", "22:42.6", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Cameron", "Murphy", "Edina Cycling", "100604357", "5062", 1, "23:49.0", "23:49.0", nil, nil, nil, "finished", nil, nil ],
  [ 60, "Scotty", "DeLong", "Minnetonka HS", "100614671", "5132", 1, "24:27.1", "24:27.1", nil, nil, nil, "finished", nil, nil ],
  [ 61, "Luke", "Tungseth", "Alexandria Youth Cycling", "100576962", "5009", 1, "25:20.3", "25:20.3", nil, nil, nil, "finished", nil, nil ],
  [ 62, "Emmitt", "Good", "Alexandria Youth Cycling", "100577866", "5003", 1, "26:08.8", "26:08.8", nil, nil, nil, "finished", nil, nil ],
  [ 63, "Joel", "Preston", "Alexandria Youth Cycling", "100559044", "5007", 1, "26:16.6", "26:16.6", nil, nil, nil, "finished", nil, nil ],
  [ 64, "Simeon", "Messner", "Minneapolis Roosevelt HS", "100567364", "5107", 1, "28:16.8", "28:16.8", nil, nil, nil, "finished", nil, nil ],
  [ 65, "Dominic", "Altrichter", "Minnetonka HS", "100565846", "5128", 1, "44:07.3", "44:07.3", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Girls Results
results_8th_grade_girls = [
  [ 1, "Megan", "Pierson", "Armstrong Cycle", "100521906", "4505", 1, "17:27.4", "17:27.4", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Amelia", "Schroeder", "Hopkins HS", "100529198", "4534", 1, "17:50.8", "17:50.8", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Ingrid", "Nygren", "Hopkins HS", "100520993", "4532", 1, "17:52.0", "17:52.0", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Amelia", "Hoes", "Hopkins HS", "100566340", "4531", 1, "18:17.1", "18:17.1", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Addy", "Schilling", "Bloomington Jefferson", "100511093", "4513", 1, "18:34.9", "18:34.9", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Courtney", "Hollinbeck", "Armstrong Cycle", "100511875", "4503", 1, "18:35.5", "18:35.5", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Natalie", "Schmidt", "Minnetonka HS", "100522933", "4557", 1, "18:45.1", "18:45.1", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Alice", "LaTour", "Minneapolis Southwest HS", "100516872", "4549", 1, "19:08.0", "19:08.0", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Margaret", "Olson", "Minneapolis Southwest HS", "100606539", "4551", 1, "19:14.9", "19:14.9", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Penelope", "Snow", "Shakopee HS", "100524706", "4571", 1, "19:31.0", "19:31.0", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Talia", "Touchet", "Armstrong Cycle", "100521607", "4506", 1, "19:31.4", "19:31.4", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Ilsa", "Kaley", "Minneapolis Roosevelt HS", "100524178", "4546", 1, "19:31.8", "19:31.8", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Kinley", "Kuhlmann", "Minnetonka HS", "100520839", "4556", 1, "19:34.5", "19:34.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Emma", "Metsa", "Rock Ridge", "100567332", "4562", 1, "19:57.5", "19:57.5", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Aster", "Holliday", "Minneapolis Roosevelt HS", "100518576", "4545", 1, "20:13.7", "20:13.7", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Raegan", "Pernitz", "Minneapolis Roosevelt HS", "100514490", "4547", 1, "20:13.7", "20:13.7", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Alison", "Koenig", "Shakopee HS", "100523033", "4570", 1, "20:13.8", "20:13.8", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Everleigh", "Cruze", "Alexandria Youth Cycling", "100571990", "4501", 1, "20:16.7", "20:16.7", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Ingrid", "Jorgenson", "St Louis Park HS", "100579840", "4573", 1, "20:16.9", "20:16.9", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Katrina", "Bjergaard", "Totino Grace-Irondale", "100558884", "4587", 1, "20:22.8", "20:22.8", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Merrin", "Petersen", "Armstrong Cycle", "100535073", "4504", 1, "20:27.3", "20:27.3", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Freya", "Mollet", "St Louis Park HS", "100531804", "4574", 1, "20:52.2", "20:52.2", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Ellery", "O'Shea", "Hopkins HS", "100519076", "4533", 1, "21:44.6", "21:44.6", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Olivia", "Graff", "Minneapolis Roosevelt HS", "100563282", "4544", 1, "21:51.5", "21:51.5", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Gwen", "Mcgreevy", "Bloomington Jefferson", "100532223", "4512", 1, "21:51.7", "21:51.7", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Audrey", "Meendering", "Minneapolis Southwest HS", "100515425", "4550", 1, "22:00.1", "22:00.1", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Kendall", "Stults", "Wayzata Mountain Bike", "100565186", "4588", 1, "22:16.8", "22:16.8", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Vivian", "Wrecza", "Hopkins HS", "100534374", "4535", 1, "22:17.0", "22:17.0", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Josie", "Brown", "St Paul Composite - South", "100515874", "4578", 1, "22:17.4", "22:17.4", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Evelyn", "Eigen", "Alexandria Youth Cycling", "100532348", "4502", 1, "22:18.2", "22:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Olivia", "Hoyord", "Minnetonka HS", "100527853", "4555", 1, "22:25.9", "22:25.9", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Maria", "Seeber", "Rock Ridge", "100603914", "4564", 1, "22:56.6", "22:56.6", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Britta", "Droogsma", "Rockford", "100510939", "4565", 1, "22:56.8", "22:56.8", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Kiah", "Droogsma", "Rockford", "100510943", "4566", 1, "22:57.4", "22:57.4", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Arianna", "Young", "Bloomington", "100606046", "4510", 1, "23:05.2", "23:05.2", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Audii", "Rosandich", "Rock Ridge", "100532616", "4563", 1, "23:05.6", "23:05.6", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Olive", "Thiessen", "St Cloud", "100534823", "4572", 1, "24:21.8", "21:21.8", nil, nil, nil, "finished", "3 Min Outside Assist", nil ],
  [ 38, "Sylviana", "Bonczyk", "Bloomington", "100559859", "4509", 1, "25:39.0", "25:39.0", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Lilja", "Bergquist", "Bloomington", "100516074", "4508", 1, "25:39.4", "25:39.4", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Amelia", "Pankow", "Minneapolis Southwest HS", "100561038", "4552", 1, "26:26.7", "26:26.7", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Julia", "Tudor", "Minneapolis South HS", "100515420", "4548", 1, "28:53.6", "28:53.6", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Boys D2 Results
results_8th_grade_boys_d2 = [
  [ 1, "Olin", "Bujold", "Tioga Trailblazers", "100489293", "4282", 1, "15:27.5", "15:27.5", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Emin", "Erenler", "St Louis Park HS", "100517696", "4260", 1, "15:31.3", "15:31.3", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Henry", "Osburn", "Bloomington Jefferson", "100510972", "4031", 1, "15:47.9", "15:47.9", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Aiden", "Sutherland", "Tioga Trailblazers", "100534292", "4286", 1, "15:48.1", "15:48.1", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Charlie", "Dixon", "Roseville", "100521844", "4237", 1, "15:49.1", "15:49.1", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Jacob", "Pshon", "St Louis Park HS", "100510609", "4264", 1, "16:09.3", "16:09.3", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Leo", "Lick", "Tioga Trailblazers", "100569911", "4284", 1, "16:17.7", "16:17.7", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Will", "Bakken", "St Louis Park HS", "100516837", "4257", 1, "16:21.1", "16:21.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Jax", "Schildgen", "Lake Area Composite", "100604708", "4111", 1, "16:21.3", "16:21.3", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Logan", "Warner", "Roseville", "100622143", "4245", 1, "16:46.6", "16:46.6", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Elliot", "Curtis", "St Louis Park HS", "100515026", "4258", 1, "16:49.1", "16:49.1", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Oliver", "Kozicki", "St Louis Park HS", "100526052", "4262", 1, "16:58.9", "16:58.9", nil, nil, nil, "finished", nil, "Warning - hand out at start" ],
  [ 13, "Marcus", "Fiedler", "BBBikers", "100530795", "4019", 1, "16:59.1", "16:59.1", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Simon", "Wagner", "Minneapolis Washburn HS", "100525579", "4155", 1, "16:59.6", "16:59.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Willem", "Sheldon", "Minneapolis Northside", "100538513", "4137", 1, "16:59.8", "16:59.8", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Madden", "Lorenz", "Lake Area Composite", "100532574", "4110", 1, "17:13.6", "17:13.6", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Neil", "Imholte", "Tioga Trailblazers", "100535255", "4283", 1, "17:26.2", "17:26.2", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Jacob", "Walczak", "Roseville", "100617185", "4244", 1, "17:26.8", "17:26.8", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Vincent", "Howe", "St Louis Park HS", "100569944", "4261", 1, "17:28.3", "17:28.3", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Harrison", "Young", "St Louis Park HS", "100522519", "4265", 1, "17:29.0", "17:29.0", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Teddy", "Carlston", "Lake Area Composite", "100617105", "4109", 1, "17:41.9", "17:41.9", nil, nil, nil, "finished", nil, nil ],
  [ 22, "George", "Martin", "Bloomington", "100514224", "4022", 1, "17:42.3", "17:42.3", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Christopher", "Park", "Totino Grace-Irondale", "100601655", "4289", 1, "17:45.4", "17:45.4", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Zachary", "Albu", "Minneapolis Southwest HS", "100522604", "4147", 1, "17:45.4", "17:45.4", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Oliver", "Koebele", "Minneapolis Northside", "100619120", "4136", 1, "17:45.6", "17:45.6", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Jennings", "Gall", "St Cloud", "100561065", "4253", 1, "17:46.4", "17:46.4", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Jameson", "La Barbera", "St Louis Park HS", "100523472", "4263", 1, "17:49.1", "17:49.1", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Joaquin", "Villalpando", "Roseville", "100530160", "4243", 1, "17:51.3", "17:51.3", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Andrew", "Ehlert", "Minneapolis Washburn HS", "100513594", "4151", 1, "17:51.5", "17:51.5", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Coleton", "Wagner", "Minneapolis Southwest HS", "100559431", "4150", 1, "17:59.3", "17:59.3", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Joseph", "Fuller", "St Paul Composite - North", "100620801", "4268", 1, "18:20.8", "18:20.8", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Peter", "Martinson", "Minneapolis South HS", "100514067", "4144", 1, "18:31.3", "18:31.3", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Miles", "Hernandez", "Minneapolis Southwest HS", "100613699", "4149", 1, "18:32.7", "18:32.7", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Levi", "Layer", "St Paul Composite - North", "100514352", "4269", 1, "18:44.1", "18:44.1", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Elliot", "Freeman", "Roseville", "100530582", "4239", 1, "18:44.3", "18:44.3", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Gerhardt", "Schaible", "Totino Grace-Irondale", "100607803", "4290", 1, "18:45.9", "18:45.9", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Griffin", "Klun", "Minneapolis Washburn HS", "100513357", "4154", 1, "18:46.8", "18:46.8", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Gabriel", "Cesari", "Bloomington Jefferson", "100531095", "4027", 1, "19:03.5", "19:03.5", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Anders", "Dolmar", "Bloomington Jefferson", "100516525", "4028", 1, "19:04.1", "19:04.1", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Sully", "Verdeck", "Bloomington", "100535361", "4024", 1, "19:04.1", "19:04.1", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Kai", "Richardson", "BBBikers", "100562155", "4020", 1, "19:05.1", "19:05.1", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Oliver", "Weberg", "Bloomington", "100575891", "4025", 1, "19:05.9", "19:05.9", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Theodore", "Brokering", "Bloomington Jefferson", "100514151", "4026", 1, "19:07.7", "19:07.7", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Micah", "Slattengren", "Lake Area Composite", "100607812", "4113", 1, "19:15.9", "19:15.9", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Gray", "Schmidt", "Lake Area Composite", "100511109", "4112", 1, "19:38.1", "19:38.1", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Oscar", "Bye", "Minneapolis Southwest HS", "100563437", "4148", 1, "19:57.5", "19:57.5", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Benjamin", "Birznieks", "Rockford", "100568192", "4233", 1, "20:03.4", "20:03.4", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Landon", "McCall", "Roseville", "100602442", "4241", 1, "20:03.9", "20:03.9", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Logan", "Lipetzky", "Bloomington Jefferson", "100605695", "4030", 1, "20:23.0", "20:23.0", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Danny", "Yarbrough", "Lake Area Composite", "100608702", "4115", 1, "20:27.9", "20:27.9", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Owen", "Wetterlund", "Lake Area Composite", "100563945", "4114", 1, "20:32.0", "20:32.0", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Sebby", "Peters", "St Paul Composite - North", "100582181", "4271", 1, "21:09.3", "21:09.3", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Eli", "Haglof", "Totino Grace-Irondale", "100514481", "4287", 1, "22:01.2", "22:01.2", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Sean", "Isaacson", "Minneapolis Washburn HS", "100605486", "4152", 1, "22:07.9", "22:07.9", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Asher", "Smith", "Minneapolis South HS", "100610059", "4145", 1, "22:08.1", "22:08.1", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Jackson", "Kuriscak", "Mahtomedi HS", "100610858", "4123", 1, "22:08.2", "22:08.2", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Marcos", "Evenou", "St Paul Composite - South", "100606116", "4273", 1, "22:15.0", "22:15.0", nil, nil, nil, "finished", nil, nil ],
  [ 58, "Samuel", "Dybvig", "BBBikers", "100530115", "4259", 1, "22:17.5", "22:17.5", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Myles", "Koch", "Bloomington", "100617644", "4021", 1, "22:41.4", "22:41.4", nil, nil, nil, "finished", nil, nil ],
  [ 60, "Krosby", "Dorn", "Bloomington Jefferson", "100584641", "4029", 1, "22:49.9", "22:49.9", nil, nil, nil, "finished", nil, nil ],
  [ 61, "Carson", "Sando", "Bloomington Jefferson", "100607356", "4032", 1, "24:14.6", "24:14.6", nil, nil, nil, "finished", nil, nil ],
  [ 62, "Otto", "Johnson", "Minneapolis Washburn HS", "100517730", "4153", 1, "25:32.9", "25:32.9", nil, nil, nil, "finished", nil, nil ],
  [ 63, "Reas", "James", "Minneapolis Southside", "100523747", "4146", 1, "25:47.6", "25:47.6", nil, nil, nil, "finished", nil, nil ],
  [ 64, "Matthew", "Kriesel", "Totino Grace-Irondale", "100564705", "4288", 1, "28:50.2", "28:50.2", nil, nil, nil, "finished", nil, nil ],
  [ 65, "Conner", "Zvorak", "Kerkhoven", "100617180", "4107", 1, "29:23.4", "29:23.4", nil, nil, nil, "finished", nil, nil ],
  [ 66, "Kreed", "Sombke", "Kerkhoven", "100576104", "4106", 1, "29:37.0", "29:37.0", nil, nil, nil, "finished", nil, nil ],
  [ 67, "Henry", "Thomford", "St Paul Composite - North", "100566856", "4272", 1, "1:10:47.0", "1:10:47.0", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Boys D1 Results
results_8th_grade_boys_d1 = [
  [ 1, "Rivden", "Cummings", "Edina Cycling", "100521087", "4072", 1, "15:12.4", "15:12.4", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Asher", "Carlson", "Mounds View HS", "100513564", "4184", 1, "15:43.6", "15:43.6", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Everett", "Wilkey", "Minnetonka HS", "100521847", "4179", 1, "15:45.2", "15:45.2", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Thomas", "McPheeters", "Edina Cycling", "100517224", "4077", 1, "15:57.5", "15:57.5", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Owen", "Dahlin", "Minnetonka HS", "100519110", "4161", 1, "16:02.8", "16:02.8", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Henrik", "Kohlmyer", "Minnetonka HS", "100519458", "4169", 1, "16:07.3", "16:07.3", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Isaiah", "Rye", "Alexandria Youth Cycling", "100609363", "4009", 1, "16:24.4", "16:24.4", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Samuel", "Korzhen", "Minnetonka HS", "100519166", "4170", 1, "16:27.1", "16:27.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Anders", "Kohlmyer", "Minnetonka HS", "100519457", "4168", 1, "16:36.0", "16:36.0", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Mathis", "Koehler", "Edina Cycling", "100535918", "4075", 1, "16:37.7", "16:37.7", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Micah", "Yoder", "Armstrong Cycle", "100578479", "4307", 1, "16:57.1", "16:57.1", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Joren", "Centanni", "Mounds View HS", "100514372", "4185", 1, "17:09.1", "17:09.1", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Rad", "Maslev", "Edina Cycling", "100565236", "4076", 1, "17:15.8", "17:15.8", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Gil", "Horkey", "Minneapolis Roosevelt HS", "100516076", "4139", 1, "17:16.6", "17:16.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Oliver", "Van Dijk", "Wayzata Mountain Bike", "100566577", "4295", 1, "17:25.2", "17:25.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Quinn", "Ranallo", "Minnetonka HS", "100520866", "4175", 1, "17:27.7", "17:27.7", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Isaac", "Greimel", "Edina Cycling", "100521612", "4073", 1, "17:28.0", "17:28.0", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Broden", "Nelson", "Hopkins HS", "100598876", "4090", 1, "17:29.1", "17:29.1", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Job", "Breker", "Armstrong Cycle", "100564619", "4013", 1, "17:32.0", "17:32.0", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Micah", "Meiser", "Minneapolis Roosevelt HS", "100513858", "4141", 1, "17:35.6", "17:35.6", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Brent", "Klick", "Hopkins HS", "100534923", "4086", 1, "17:53.6", "17:53.6", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Shooter", "Vittera", "Wayzata Mountain Bike", "100609811", "4296", 1, "17:56.6", "17:56.6", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Ellery", "Fay", "Minneapolis Roosevelt HS", "100511315", "4138", 1, "17:58.0", "17:58.0", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Leo", "Lennartson", "Minnetonka HS", "100483464", "4171", 1, "18:07.7", "18:07.7", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Hayden", "Priest", "Minneapolis Roosevelt HS", "100605827", "4143", 1, "18:07.8", "18:07.8", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Brayden", "Doe", "Wayzata Mountain Bike", "100566220", "4291", 1, "18:08.7", "18:08.7", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Benjamin", "Kunkel", "Hopkins HS", "100535442", "4087", 1, "18:09.1", "18:09.1", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Alden", "Reitz", "Edina Cycling", "100518744", "4079", 1, "18:23.3", "18:23.3", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Lucas", "Patrick-Dropik", "Alexandria Youth Cycling", "100532750", "4008", 1, "18:23.4", "18:23.4", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Jackson", "Lindau", "Mounds View HS", "100514345", "4189", 1, "18:32.7", "18:32.7", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Andrew", "Bryan", "Edina Cycling", "100521669", "4071", 1, "18:38.2", "18:38.2", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Kaiden", "Butzer", "Minnetonka HS", "100521330", "4160", 1, "18:41.9", "18:41.9", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Finn", "Maloney", "Minnetonka HS", "100527284", "4172", 1, "18:43.6", "18:43.6", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Axel", "Jorstad", "Minneapolis Roosevelt HS", "100567564", "4140", 1, "18:43.8", "18:43.8", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Ernie", "Langseth-Mullen", "Hopkins HS", "100525440", "4088", 1, "18:45.9", "18:45.9", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Ian", "Jockisch", "Hopkins HS", "100518145", "4085", 1, "18:46.7", "18:46.7", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Luka", "Tomljanovic", "Edina Cycling", "100531065", "4081", 1, "18:56.8", "18:56.8", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Carsten", "Hagen", "Shakopee HS", "100609261", "4248", 1, "19:08.8", "19:08.8", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Viggo", "Underhill", "Minnetonka HS", "100563740", "4177", 1, "19:09.0", "19:09.0", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Hamilton", "Morton", "Edina Cycling", "100527192", "4078", 1, "19:09.0", "19:09.0", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Khalon", "Chamberlain", "Hopkins HS", "100601970", "4084", 1, "19:16.4", "19:16.4", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Liam", "Jenison", "Mounds View HS", "100514777", "4187", 1, "19:17.1", "19:17.1", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Otis", "Phinney", "Minneapolis Roosevelt HS", "100611473", "4142", 1, "19:18.1", "19:18.1", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Noah", "Larson", "Alexandria Youth Cycling", "100575208", "4006", 1, "19:21.7", "19:21.7", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Tate", "Rogers", "Mounds View HS", "100564071", "4192", 1, "19:23.0", "19:23.0", nil, nil, nil, "finished", nil, nil ],
  [ 46, "John", "Brandhorst", "Minnetonka HS", "100617442", "4159", 1, "19:27.1", "19:27.1", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Gus", "Vandergriff", "Minnetonka HS", "100616819", "4178", 1, "19:29.5", "19:29.5", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Liam", "Dobbelmann", "Alexandria Youth Cycling", "100530399", "4004", 1, "19:44.3", "19:44.3", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Kaleb", "Danielson", "Alexandria Youth Cycling", "100526949", "4003", 1, "19:44.9", "19:44.9", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Miles", "Beisang", "Mounds View HS", "100601460", "4181", 1, "19:45.2", "19:45.2", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Oliver", "Adams", "Shakopee HS", "100529010", "4246", 1, "19:47.0", "19:47.0", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Gavin", "Swanson", "Shakopee HS", "100529583", "4252", 1, "19:47.4", "19:47.4", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Fynn", "Brosnahan", "Mounds View HS", "100514967", "4183", 1, "19:54.3", "19:54.3", nil, nil, nil, "finished", nil, nil ],
  [ 54, "William", "Tindall", "Mounds View HS", "100601498", "4193", 1, "19:54.4", "19:54.4", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Ethan", "Bellamy", "Minnetonka HS", "100561955", "4158", 1, "19:58.3", "19:58.3", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Hollis", "Anderson", "Mounds View HS", "100609424", "4180", 1, "20:18.1", "20:18.1", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Leighton", "Turco", "Mounds View HS", "100602056", "4194", 1, "20:25.0", "20:25.0", nil, nil, nil, "finished", nil, nil ],
  [ 58, "William", "Eliason", "Wayzata Mountain Bike", "100579193", "4292", 1, "20:45.4", "20:45.4", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Ian", "Holland", "Minnetonka HS", "100566254", "4163", 1, "20:57.8", "20:57.8", nil, nil, nil, "finished", nil, nil ],
  [ 60, "Kellen", "Brittain", "Shakopee HS", "100616468", "4247", 1, "20:58.0", "20:58.0", nil, nil, nil, "finished", nil, nil ],
  [ 61, "Oliver", "Fleming", "Minnetonka HS", "100615364", "4162", 1, "21:08.9", "21:08.9", nil, nil, nil, "finished", nil, nil ],
  [ 62, "Franklin", "Barthel", "Alexandria Youth Cycling", "100579562", "4001", 1, "21:12.0", "21:12.0", nil, nil, nil, "finished", nil, nil ],
  [ 63, "Surya Gustav", "Jayaram", "Minnetonka HS", "100618944", "4164", 1, "21:17.4", "21:17.4", nil, nil, nil, "finished", nil, nil ],
  [ 64, "Everett", "Hilk", "Edina Cycling", "100564064", "4074", 1, "21:36.2", "21:36.2", nil, nil, nil, "finished", nil, nil ],
  [ 65, "George", "Putschoegl", "Mounds View HS", "100609296", "4191", 1, "21:38.2", "21:38.2", nil, nil, nil, "finished", nil, nil ],
  [ 66, "Atreyu", "Jurado", "Minnetonka HS", "100522921", "4165", 1, "21:44.0", "21:44.0", nil, nil, nil, "finished", nil, nil ],
  [ 67, "Gavin", "Berg", "Armstrong Cycle", "100613849", "4012", 1, "22:14.3", "22:14.3", nil, nil, nil, "finished", nil, nil ],
  [ 68, "Clayton", "Willey", "Wayzata Mountain Bike", "100605850", "4297", 1, "22:31.1", "22:31.1", nil, nil, nil, "finished", nil, nil ],
  [ 69, "Caleb", "Smith", "Alexandria Youth Cycling", "100540813", "4010", 1, "22:43.1", "22:43.1", nil, nil, nil, "finished", nil, nil ],
  [ 70, "Erik", "Perkins", "Minnetonka HS", "100522475", "4174", 1, "22:44.1", "22:44.1", nil, nil, nil, "finished", nil, nil ],
  [ 71, "Louie", "Trepanier", "White Bear Lake HS", "100564588", "4302", 1, "22:56.8", "22:56.8", nil, nil, nil, "finished", nil, nil ],
  [ 72, "Michael", "Lorenz", "White Bear Lake HS", "100561398", "4300", 1, "23:36.5", "23:36.5", nil, nil, nil, "finished", nil, nil ],
  [ 73, "Riley", "Mongeau", "Hopkins HS", "100609297", "4089", 1, "23:54.9", "23:54.9", nil, nil, nil, "finished", nil, nil ],
  [ 74, "Eli", "Ross", "White Bear Lake HS", "100570865", "4301", 1, "24:20.3", "24:20.3", nil, nil, nil, "finished", nil, nil ],
  [ 75, "Logan", "DeGroot", "White Bear Lake HS", "100621736", "4299", 1, "24:23.9", "24:23.9", nil, nil, nil, "finished", nil, nil ],
  [ 76, "Myles", "Johnson", "Mounds View HS", "100563506", "4188", 1, "25:14.3", "25:14.3", nil, nil, nil, "finished", nil, nil ],
  [ 77, "Joseph", "Keogh", "Minnetonka HS", "100563423", "4167", 1, "25:19.8", "25:19.8", nil, nil, nil, "finished", nil, nil ],
  [ 78, "John", "Snider", "Minnetonka HS", "100530042", "4176", 1, "35:15.4", "35:15.4", nil, nil, nil, "finished", nil, nil ]
]

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

puts "\n🎉 Race 7 - Theodore Wirth Park seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
