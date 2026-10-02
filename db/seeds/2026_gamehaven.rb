require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

# ===============================================================================
# RACE DATA - Race 6 - Gamehaven (September 26, 2026)
# ===============================================================================

puts "Creating Race 6 - Gamehaven results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 6 - Gamehaven",
  race_date: Date.parse("September 26, 2026")
) do |race|
  race.location = "Gamehaven"
  race.year = 2026
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Delaney", "Wilcox", "Maple Grove HS", "100603365", "6529", 1, "17:56.4", "17:56.4", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Elise", "Broski", "Rochester Mayo", "100601500", "6549", 1, "18:16.1", "18:16.1", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Marikka", "Wheeler", "St Paul Central", "100566702", "6560", 1, "19:28.2", "19:28.2", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Claire", "Green", "Austin HS", "100618926", "6505", 1, "20:04.8", "20:04.8", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Svea", "Widenbrant", "Stillwater Mountain Bike", "100603694", "6563", 1, "20:13.5", "20:13.5", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Eva", "Ready", "Crosby-Ironton HS", "100602647", "6513", 1, "20:33.3", "20:33.3", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Wren", "Wilichowski", "Stillwater Mountain Bike", "100604828", "6564", 1, "21:05.1", "21:05.1", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Elin", "Schroeder", "Prior Lake HS", "100606181", "6546", 1, "21:13.1", "21:13.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Katherine", "Dahn", "New Prague MS and HS", "100621152", "6541", 1, "21:23.3", "21:23.3", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Isabella", "Truckenmiller", "East Ridge HS", "100603408", "6514", 1, "21:31.9", "21:31.9", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Hartley", "Urban", "Rosemount HS", "100610871", "6553", 1, "21:32.8", "21:32.8", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Magnolia", "Tiller", "Park HS", "100603381", "6545", 1, "21:38.5", "21:38.5", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Eliza", "Zick", "River Falls HS", "100601941", "6547", 1, "21:48.5", "21:48.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Kelsey", "Sletten", "Mankato West HS", "100618583", "6528", 1, "21:51.8", "21:51.8", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Lilah", "DiGiovanni", "Crosby-Ironton HS", "100602652", "6512", 1, "22:09.2", "22:09.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Bria", "DeLoach", "Woodbury HS", "100613598", "6572", 1, "23:04.3", "23:04.3", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Clarissa", "Wilson", "ISD728", "100616004", "6524", 1, "25:44.1", "25:44.1", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Alexia", "Selchow", "Osseo HS", "100611450", "6544", 1, "25:44.7", "25:44.7", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Anna", "Johnson", "Stillwater Mountain Bike", "100611161", "6561", 1, "26:44.9", "26:44.9", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Charlotte", "Barlage", "New Prague MS and HS", "100617926", "6540", 1, "27:19.8", "27:19.8", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Phinley", "Campbell", "Chaska HS", "100606449", "6509", 1, "30:31.7", "30:31.7", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Sage", "Edge", "Rochester Area", "100614691", "6548", 1, "36:49.0", "36:49.0", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Hadley", "Rickert", "Osseo HS", "100603159", "6543", 0, "", "", nil, nil, nil, "DNF", nil, nil ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Augustus", "Lang", "Crosby-Ironton HS", "100610214", "6045", 1, "16:42.1", "16:42.1", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Evan", "Kes", "Lakeville North HS", "100602524", "6070", 1, "18:40.3", "18:40.3", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Leo", "Barten", "Minnesota Valley", "100602232", "6100", 1, "19:42.4", "19:42.4", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Theodore", "Watson", "Mankato West HS", "100609577", "6082", 1, "19:52.3", "19:52.3", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Soren", "Smith", "Champlin Park HS", "100601983", "6028", 1, "19:58.0", "19:58.0", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Everett", "Olson", "Maple Grove HS", "100601698", "6085", 1, "20:05.6", "20:05.6", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Lachlan", "Dietz", "Maple Grove HS", "100601827", "6083", 1, "21:10.2", "21:10.2", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Matthew", "Anderson", "Champlin Park HS", "100606878", "6026", 1, "21:11.0", "21:11.0", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Samuel", "Parker", "Lakeville North HS", "100605668", "6072", 1, "21:11.2", "21:11.2", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Oscar", "Wetzel", "Rochester Area", "100619925", "6136", 1, "21:54.7", "21:54.7", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Wyatt", "Erbach", "Westonka", "100619398", "6204", 1, "21:57.4", "21:57.4", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Austin", "Ludington", "East Ridge HS", "100606471", "6048", 1, "22:11.6", "22:11.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Eli", "Zadow", "Austin HS", "100604959", "6008", 1, "22:12.6", "22:12.6", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Lyle", "Larsen", "Westonka", "100620307", "6205", 1, "23:11.8", "23:11.8", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Kaito", "Munden", "Rochester Area", "100613334", "6135", 1, "23:32.2", "23:32.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Graham", "Schmitz", "Rochester Century HS", "100602229", "6139", 1, "23:33.5", "23:33.5", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Riley", "Rostance", "Eagan HS", "100616737", "6046", 1, "23:34.5", "23:34.5", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Caleb", "Vogt", "Rochester Mayo", "100612897", "6143", 1, "23:43.4", "23:43.4", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Tyler", "Doescher", "ISD728", "100618972", "6064", 1, "23:49.1", "23:49.1", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Augie", "Phelan", "Rochester Mayo", "100613044", "6142", 1, "24:02.6", "24:02.6", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Benjamin", "Chamberlin", "Crosby-Ironton HS", "100619899", "6043", 1, "24:53.3", "24:53.3", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Elias", "Molin", "Rochester Mayo", "100621455", "6141", 1, "25:15.1", "25:15.1", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Russell", "Kurt", "Eastview HS", "100602734", "6050", 1, "25:29.2", "25:29.2", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Charlie", "Kronstedt", "Crosby-Ironton HS", "100610704", "6044", 1, "25:49.0", "25:49.0", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Thomas", "Klaas", "Rochester Mayo", "100601702", "6140", 1, "25:51.2", "25:51.2", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Ryan", "Bates", "Rochester Century HS", "100615530", "6137", 1, "25:53.8", "25:53.8", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Colter", "Lusignan", "Minnesota Valley", "100613351", "6101", 1, "26:08.2", "26:08.2", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Zach", "Torborg", "Eagan HS", "100607709", "6047", 1, "26:18.2", "26:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Grayson", "Froemming", "Rochester Area", "100601922", "6134", 1, "26:58.3", "26:58.3", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Aslam", "Immamdeen", "Burnsville HS", "100606866", "6021", 1, "27:48.9", "27:48.9", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Finn", "Boorsma", "Rochester Area", "100603974", "6133", 1, "27:53.9", "27:53.9", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Kristoffer", "Nelson", "Rochester Century HS", "100611941", "6138", 1, "37:27.5", "34:27.5", nil, nil, nil, "finished", "3 Min Outside Assistance", nil ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [ 1, "Jack", "Bartel", "Brainerd HS", "100620988", "6011", 1, "17:41.2", "17:41.2", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Lucas", "Dobesh", "Lakeville South HS", "100602252", "6073", 1, "17:41.3", "17:41.3", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Miles", "Wheeler", "St Paul Central", "100613912", "6181", 1, "18:14.0", "18:14.0", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Kurt", "Langer", "Stillwater Mountain Bike", "100607804", "6190", 1, "18:50.6", "18:50.6", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Miles", "Vellance", "Prior Lake HS", "100611187", "6130", 1, "19:11.5", "19:11.5", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Wyatt", "Broughten", "Prior Lake HS", "100610207", "6125", 1, "19:13.1", "19:13.1", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Jude", "Cook", "Stillwater Mountain Bike", "100605737", "6187", 1, "20:05.3", "20:05.3", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Ian", "Schuck", "Stillwater Mountain Bike", "100602714", "6191", 1, "20:06.3", "20:06.3", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Darby", "Hertaus", "New Prague MS and HS", "100619159", "6118", 1, "20:07.3", "20:07.3", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Finn", "Rissi", "Lakeville South HS", "100614567", "6074", 1, "20:08.3", "20:08.3", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Everett", "Garrity", "Prior Lake HS", "100620159", "6128", 1, "24:18.9", "24:18.9", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Declan", "Fangel", "Prior Lake HS", "100619182", "6127", 1, "24:35.2", "24:35.2", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Drew", "Tjernagel", "Prior Lake HS", "100614220", "6129", 1, "24:54.6", "24:54.6", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Leo", "Corrigan", "Prior Lake HS", "100620066", "6126", 1, "25:16.6", "25:16.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Henry", "Hokeness", "New Prague MS and HS", "100618804", "6119", 1, "26:24.3", "26:24.3", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Girls Results
results_7th_grade_girls = [
  [ 1, "Marah", "Strong", "Eagan HS", "100557441", "5520", 1, "17:41.3", "17:41.3", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Claire", "Harris", "Park HS", "100520964", "5574", 1, "17:55.4", "17:55.4", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Isabelle", "Seaquist", "Mankato", "100575160", "5548", 1, "17:56.0", "17:56.0", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Zoie", "Reese", "Watertown-Mayer", "100537117", "5592", 1, "18:26.5", "18:26.5", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Clara", "Mullen", "Rochester Area", "100559685", "5581", 1, "18:27.5", "18:27.5", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Maeva", "Gartner", "Apple Valley HS", "100565750", "5504", 1, "18:28.5", "18:28.5", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Eleanora", "DiGiovanni", "Crosby-Ironton HS", "100608557", "5517", 1, "19:11.7", "19:11.7", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Aven", "Penman", "St Croix", "100557185", "5588", 1, "19:14.6", "19:14.6", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Mya", "Lorenzen", "Chaska HS", "100606005", "5512", 1, "19:56.8", "19:56.8", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Alice", "O'Brien", "East Ridge HS", "100571632", "5521", 1, "20:05.4", "20:05.4", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Anna", "Zhdankin", "Prior Lake HS", "100566584", "5577", 1, "20:06.8", "20:06.8", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Adelynn", "Colvin", "Stillwater Mountain Bike", "100563564", "5589", 1, "20:35.6", "20:35.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Morgan", "Shield", "East Ridge HS", "100619448", "5522", 1, "20:48.0", "20:48.0", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Clara", "Gress", "Lakeville South HS", "100565088", "5542", 1, "20:49.5", "20:49.5", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Hazel", "Jenson", "Woodbury HS", "100562459", "5600", 1, "20:58.2", "20:58.2", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Nadia", "Howe", "River Falls HS", "100577019", "5578", 1, "21:01.8", "21:01.8", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Henley", "Harrison", "Mankato", "100575669", "5547", 1, "21:34.0", "21:34.0", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Willow", "Tomesh", "Winona", "100577423", "5599", 1, "21:45.8", "21:45.8", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Alpha", "Justen", "St Croix", "100557799", "5587", 1, "21:47.8", "21:47.8", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Danielle", "Engel", "Lakeville North HS", "100618928", "5539", 1, "22:05.8", "22:05.8", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Ziva", "Signalness", "Hudson HS", "100554895", "5534", 1, "22:29.2", "22:29.2", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Marley", "Tiegs", "Austin HS", "100619093", "5506", 1, "23:13.3", "23:13.3", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Kyla", "Walters", "Maple Grove HS", "100557163", "5550", 1, "23:25.7", "23:25.7", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Danika", "Zitur", "Crosby-Ironton HS", "100621774", "5519", 1, "23:28.3", "23:28.3", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Ellie", "Bethke", "Orono HS", "100572798", "5572", 1, "23:35.2", "23:35.2", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Sydney", "Schaan", "Stillwater Mountain Bike", "100621849", "5590", 1, "24:19.2", "24:19.2", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Meredith", "Katzenberger", "Crosby-Ironton HS", "100577922", "5518", 1, "24:20.2", "24:20.2", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Nola", "Fott", "Lakeville South HS", "100561956", "5541", 1, "25:01.4", "25:01.4", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Emma", "Miller", "River Falls HS", "100557252", "5579", 1, "25:43.5", "25:43.5", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Emily", "Lund", "Lakeville South HS", "100566518", "5543", 1, "27:25.0", "27:25.0", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Lillian", "Kyte", "Lakeville North HS", "100602178", "5540", 1, "29:06.4", "29:06.4", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Paige", "Johnson", "Woodbury HS", "100605100", "5601", 1, "29:40.2", "29:40.2", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Sage", "Arroyo", "Rochester Area", "100618533", "5580", 1, "29:44.1", "29:44.1", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [ 1, "Owen", "Simner", "Rochester Area", "100574895", "5188", 1, "16:43.2", "16:43.2", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Niels", "Williams", "Eastview HS", "100579486", "5057", 1, "16:43.3", "16:43.3", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Sebastian", "Tovsen", "Eastview HS", "100573915", "5056", 1, "16:43.9", "16:43.9", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Graham", "Stutsman", "Watertown-Mayer", "100565697", "5235", 1, "17:42.0", "17:42.0", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Sean", "Cabbage", "Rochester Area", "100559136", "5185", 1, "17:44.6", "17:44.6", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Wyatt", "Dirksen", "Rosemount HS", "100565157", "5199", 1, "17:49.7", "17:49.7", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Winston", "Toftness", "Crosby-Ironton HS", "100566190", "5048", 1, "17:50.0", "17:50.0", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Dylan", "Maier", "Apple Valley HS", "100565303", "5010", 1, "17:52.1", "17:52.1", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Ezekiel", "Goodpaster", "River Falls HS", "100557343", "5183", 1, "17:57.5", "17:57.5", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Garrett", "Miller", "Osseo Composite", "100571749", "5174", 1, "18:19.8", "18:19.8", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Mitchell", "Grundel", "Austin HS", "100575041", "5015", 1, "18:20.4", "18:20.4", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Thomas", "Hairrell", "Champlin Park HS", "100557454", "5034", 1, "18:21.0", "18:21.0", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Owen", "Corbett", "Crosby-Ironton HS", "100557136", "5047", 1, "18:26.2", "18:26.2", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Grant", "Baron", "Austin HS", "100557891", "5014", 1, "18:26.4", "18:26.4", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Quintin", "Sorensen", "Chaska HS", "100575005", "5044", 1, "18:37.7", "18:37.7", nil, nil, nil, "finished", nil, nil ],
  [ 16, "George", "Pike", "ISD728", "100577296", "5084", 1, "18:40.1", "18:40.1", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Keenan", "Olson", "Minnesota Valley", "100564530", "5127", 1, "18:41.6", "18:41.6", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Jack", "Somers", "Rochester Century HS", "100603205", "5192", 1, "18:44.6", "18:44.6", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Jerron", "Schroeck", "ISD728", "100602363", "5086", 1, "18:47.7", "18:47.7", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Lincoln", "Harvey", "River Falls HS", "100558772", "5184", 1, "18:50.9", "18:50.9", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Asher", "Landin", "Woodbury HS", "100561905", "5257", 1, "19:19.7", "19:19.7", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Dominic", "Valleen", "Champlin Park HS", "100563279", "5036", 1, "19:20.9", "19:20.9", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Sawyer", "Dantzman", "St Croix", "100559408", "5208", 1, "19:22.1", "19:22.1", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Arlo", "Schwarting", "Eagan HS", "100575015", "5052", 1, "19:22.1", "19:22.1", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Saiah", "Felmlee", "Rochester Century HS", "100570560", "5190", 1, "19:30.9", "19:30.9", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Logan", "Rossman", "ISD728", "100572178", "5085", 1, "20:06.0", "20:06.0", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Graham", "Heller", "Hudson HS", "100559484", "5077", 1, "20:08.7", "20:08.7", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Brayden", "Molling", "Winona", "100578385", "5253", 1, "20:12.0", "20:12.0", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Isaac", "Annis", "Austin HS", "100560593", "5013", 1, "20:20.2", "20:20.2", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Kaleb", "Grundhofer", "Chanhassen HS", "100561054", "5039", 1, "20:30.4", "20:30.4", nil, nil, nil, "finished", nil, nil ],
  [ 31, "William", "O'Laughlin", "Winona", "100578599", "5254", 1, "20:30.9", "20:30.9", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Cullen", "Gram", "Chanhassen HS", "100530405", "5038", 1, "20:41.0", "20:41.0", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Jasper", "Jensen", "Eagan HS", "100614701", "5050", 1, "20:42.3", "20:42.3", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Josh", "Mischke", "Eagan HS", "100609531", "5051", 1, "20:42.4", "20:42.4", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Mason", "Jenner", "ISD728", "100557165", "5082", 1, "21:17.4", "21:17.4", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Seamus", "Green", "Eagan HS", "100614681", "5049", 1, "21:25.3", "21:25.3", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Kedrik", "Wilson", "Eagan HS", "100605521", "5053", 1, "21:34.8", "21:34.8", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Rubin", "Gelle", "Winona", "100575337", "5251", 1, "21:39.2", "21:39.2", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Tobias", "Tompkins", "Eastview HS", "100614235", "5055", 1, "21:40.2", "21:40.2", nil, nil, nil, "finished", nil, nil ],
  [ 40, "True", "Woodrough", "Rochester Area", "100613040", "5189", 1, "22:07.6", "22:07.6", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Arlo", "Mrozek", "Champlin Park HS", "100567737", "5035", 1, "22:21.8", "22:21.8", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Cooper", "Work", "Hutchinson Tigers", "100615463", "5081", 1, "22:48.3", "22:48.3", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Benjamin", "Fenske", "Woodbury HS", "100613197", "5255", 1, "22:49.3", "22:49.3", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Rafael Antonio", "Paredes", "Rochester Area", "100560172", "5186", 1, "23:38.9", "23:38.9", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Rucker", "Hitchcock", "Osseo HS", "100575049", "5175", 1, "23:55.5", "23:55.5", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Aiden", "Gilcher", "Woodbury HS", "100604901", "5256", 1, "23:57.0", "23:57.0", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Walker", "Wendlandt", "Hutchinson Tigers", "100578206", "5080", 1, "24:07.8", "24:07.8", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Trey", "Leszczynski", "Mankato West HS", "100621991", "5094", 1, "24:18.9", "24:18.9", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Cooper", "Hestick", "Maple Grove HS", "100579832", "5100", 1, "24:47.5", "24:47.5", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Richie", "Beutz", "Eden Prairie HS", "100574948", "5058", 1, "25:56.8", "25:56.8", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Andrew", "Harbarth", "Hutchinson Tigers", "100620415", "5079", 1, "26:03.9", "26:03.9", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Aiden", "Stearns", "Champlin Park HS", "100619181", "5258", 1, "26:05.7", "26:05.7", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Shaarav", "Nawale", "Rochester Century HS", "100605121", "5191", 1, "26:56.5", "26:56.5", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Beckham", "Buesing", "Maple Grove HS", "100577280", "5096", 1, "29:06.4", "26:06.4", nil, nil, nil, "finished", "3 Min Outside Assistance", nil ],
  [ 55, "Soren", "Savage", "Rochester Area", "100568472", "5187", 1, "32:47.7", "32:47.7", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Odin", "Kallemeyn", "ISD728", "100570877", "5083", 1, "33:03.5", "33:03.5", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  [ 1, "Andrew", "Englin", "New Prague MS and HS", "100566478", "5158", 1, "16:22.1", "16:22.1", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Phillip", "Majka", "Brainerd HS", "100568035", "5029", 1, "17:09.9", "17:09.9", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Kai", "Carver", "Stillwater Mountain Bike", "100562655", "5228", 1, "18:17.6", "18:17.6", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Bennett", "Kilian", "New Prague MS and HS", "100621597", "5159", 1, "18:29.0", "18:29.0", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Graham", "Westlie", "Prior Lake HS", "100574412", "5181", 1, "18:32.2", "18:32.2", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Abraham", "Franke", "Brainerd HS", "100578571", "5028", 1, "18:36.5", "18:36.5", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Gabriel", "Hemminger", "Stillwater Mountain Bike", "100557825", "5230", 1, "18:37.6", "18:37.6", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Brayden", "Remer", "New Prague MS and HS", "100618024", "5160", 1, "18:40.5", "18:40.5", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Peter", "Stokman", "Stillwater Mountain Bike", "100565862", "5232", 1, "18:42.2", "18:42.2", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Tyson", "Clark", "Stillwater Mountain Bike", "100564517", "5229", 1, "19:16.2", "19:16.2", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Oscar", "Nelson", "Stillwater Mountain Bike", "100566055", "5231", 1, "19:44.0", "19:44.0", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Finn", "Wilson", "Orono HS", "100606955", "5173", 1, "19:53.7", "19:53.7", nil, nil, nil, "finished", nil, nil ],
  [ 13, "William", "Geyerman", "Lakeville South HS", "100575670", "5091", 1, "19:54.7", "19:54.7", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Austin", "Pinks", "Prior Lake HS", "100575448", "5180", 1, "20:33.7", "20:33.7", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Orion", "Cross", "Prior Lake HS", "100565900", "5177", 1, "20:34.7", "20:34.7", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Kieran", "Schimnich", "St Paul Central", "100557274", "5223", 1, "21:37.9", "21:37.9", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Tregg", "Jones", "Orono HS", "100565270", "5167", 1, "21:45.7", "21:45.7", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Caleb", "Baumgartner", "Prior Lake HS", "100566260", "5176", 1, "21:53.5", "21:53.5", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Billy", "Swenson", "Orono HS", "100557553", "5172", 1, "21:54.1", "21:54.1", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Gavin", "Bundy", "New Prague MS and HS", "100577544", "5157", 1, "21:55.1", "21:55.1", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Nels", "Johnson", "St Paul Central", "100622272", "5222", 1, "21:58.7", "21:58.7", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Connor", "Herseth", "Prior Lake HS", "100610403", "5178", 1, "22:57.0", "22:57.0", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Dom", "Knorp", "Orono HS", "100562269", "5169", 1, "23:01.0", "23:01.0", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Girls Results
results_8th_grade_girls = [
  [ 1, "Mari", "Anderson", "Eastview HS", "100532236", "4528", 1, "16:11.8", "16:11.8", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Lucia", "Drevlow", "East Ridge HS", "100512776", "4526", 1, "16:12.7", "16:12.7", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Hartley", "Biorn", "Maple Grove HS", "100530790", "4542", 1, "16:32.4", "16:32.4", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Reese", "Tierney", "Stillwater Mountain Bike", "100521001", "4583", 1, "17:27.8", "17:27.8", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Lainey", "Holey", "Winona", "100534734", "4589", 1, "17:31.8", "17:31.8", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Netta", "Wheeler", "St Paul Central", "100514278", "4577", 1, "17:57.1", "17:57.1", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Olive", "Wilcox", "Maple Grove HS", "100519538", "4543", 1, "17:58.5", "17:58.5", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Megan", "Ryan", "Brainerd HS", "100534426", "4517", 1, "18:01.0", "18:01.0", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Gemma", "Oberding", "Eastview HS", "100521787", "4530", 1, "18:13.1", "18:13.1", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Harriet", "Zanko", "Stillwater Mountain Bike", "100521165", "4585", 1, "18:13.3", "18:13.3", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Ingrid", "Widenbrant", "Stillwater Mountain Bike", "100518397", "4584", 1, "18:25.7", "18:25.7", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Edith", "Schulz", "St Paul Central", "100577184", "4576", 1, "18:32.6", "18:32.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Adellie", "Szczodroski", "Brainerd HS", "100579236", "4518", 1, "18:47.7", "18:47.7", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Camille", "Stephan", "Stillwater Mountain Bike", "100511857", "4582", 1, "18:51.6", "18:51.6", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Gwynn", "Moon", "Brainerd HS", "100577115", "4516", 1, "19:05.7", "19:05.7", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Colette", "Lusignan", "Minnesota Valley", "100529955", "4553", 1, "19:18.5", "19:18.5", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Jessica", "Tobias", "Minnesota Valley", "100529931", "4554", 1, "19:31.1", "19:31.1", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Irie", "Kronstedt", "Crosby-Ironton HS", "100610703", "4525", 1, "19:42.4", "19:42.4", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Brooke", "Migliori", "Lakeville South HS", "100513290", "4541", 1, "19:53.4", "19:53.4", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Avery", "DeLoach", "Woodbury HS", "100613448", "4590", 1, "20:13.8", "20:13.8", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Caroline", "Minich", "Stillwater Mountain Bike", "100519403", "4581", 1, "20:30.7", "20:30.7", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Petra", "Mueller", "St Paul Central", "100577370", "4575", 1, "21:06.1", "21:06.1", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Gwendolyn", "Guettler-Johnson", "Woodbury HS", "100516708", "4591", 1, "21:06.2", "21:06.2", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Amelia", "McDearmon", "Stillwater Mountain Bike", "100521677", "4580", 1, "21:10.3", "21:10.3", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Kaitlyn", "Knudsen", "Stillwater Mountain Bike", "100576327", "4579", 1, "21:12.6", "21:12.6", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Rowyn", "Johnson", "Lakeville South HS", "100607893", "4540", 1, "21:54.6", "21:54.6", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Annika", "Barlage", "New Prague MS and HS", "100530041", "4558", 1, "22:55.3", "22:55.3", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Ellie", "Nurmela", "Lakeville North HS", "100522316", "4539", 1, "24:42.6", "24:42.6", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Dafnie", "Larson", "Brainerd HS", "100622524", "4514", 1, "24:53.0", "24:53.0", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Allison", "Hamilton", "Crosby-Ironton HS", "100534870", "4524", 1, "24:56.5", "24:56.5", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Boys D2 Results
results_8th_grade_boys_d2 = [
  [ 1, "Danny", "Towers", "Rochester Area", "100519694", "4223", 1, "15:27.7", "15:27.7", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Marcus", "Brand", "Austin HS", "100515824", "4017", 1, "15:28.7", "15:28.7", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Kai", "Lander", "Eastview HS", "100520776", "4068", 1, "15:42.9", "15:42.9", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Axton", "Zick", "River Falls HS", "100510472", "4217", 1, "15:54.5", "15:54.5", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Rhone", "Urban", "Rosemount HS", "100526006", "4236", 1, "16:01.3", "16:01.3", nil, nil, nil, "finished", nil, nil ],
  [ 6, "William", "Lohmeyer", "Winona", "100574006", "4303", 1, "16:04.4", "16:04.4", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Breyker", "Wells-Mangold", "River Falls HS", "100510470", "4216", 1, "16:22.0", "16:22.0", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Grant", "Anderson", "Crosby-Ironton HS", "100578420", "4056", 1, "16:22.6", "16:22.6", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Joseph", "Ruegsegger", "Maple Grove HS", "100617621", "4134", 1, "16:40.4", "16:40.4", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Gilbert", "Nelson", "Osseo Composite", "100528205", "4204", 1, "16:40.7", "16:40.7", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Tyler", "Huebert", "Rochester Area", "100524869", "4220", 1, "16:40.9", "16:40.9", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Ephraim", "DiGiovanni", "Crosby-Ironton HS", "100578584", "4058", 1, "16:52.6", "16:52.6", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Drew", "Blakeley", "Maple Grove HS", "100567117", "4129", 1, "17:02.1", "17:02.1", nil, nil, nil, "finished", nil, nil ],
  [ 14, "George", "Ready", "Crosby-Ironton HS", "100578371", "4061", 1, "17:05.2", "17:05.2", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Gavin", "Taylor", "Chaska HS", "100535430", "4050", 1, "17:10.0", "17:10.0", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Jack", "Bond", "Eden Prairie HS", "100534454", "4070", 1, "17:10.6", "17:10.6", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Lincoln", "Wescott", "Hudson HS", "100510476", "4097", 1, "17:11.0", "17:11.0", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Eli", "Owens", "Mankato West HS", "100512534", "4127", 1, "17:13.5", "17:13.5", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Alex", "Klett", "Eagan HS", "100528433", "4063", 1, "17:13.7", "17:13.7", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Evan", "Hoppe", "Champlin Park HS", "100576776", "4045", 1, "17:14.4", "17:14.4", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Levi", "Jacobson", "Crosby-Ironton HS", "100558644", "4059", 1, "17:14.4", "17:14.4", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Archer", "Braastad", "Champlin Park HS", "100569652", "4044", 1, "17:18.4", "17:18.4", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Nolan", "Mitchell", "Rochester Area", "100561757", "4221", 1, "17:29.2", "17:29.2", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Blake", "Louks", "Crosby-Ironton HS", "100534731", "4060", 1, "17:47.0", "17:47.0", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Isaak", "Thompson", "Crosby-Ironton HS", "100578357", "4062", 1, "17:53.4", "17:53.4", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Maulik", "Thapa", "Eastview HS", "100560688", "4069", 1, "17:57.9", "17:57.9", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Charlie", "Gresback", "Mankato West HS", "100571698", "4126", 1, "18:18.8", "18:18.8", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Bjorn", "Olsen", "Rochester Mayo", "100559770", "4227", 1, "18:24.7", "18:24.7", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Everett", "Hutton", "Hudson HS", "100510645", "4093", 1, "18:27.9", "18:27.9", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Calvin", "Carlton", "Crosby-Ironton HS", "100607261", "4057", 1, "18:30.7", "18:30.7", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Cam", "Slavey", "Winona", "100511907", "4304", 1, "18:42.1", "18:42.1", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Lucas", "Parker", "Lakeville North HS", "100531562", "4120", 1, "18:44.5", "18:44.5", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Michael", "Brost", "Rochester Mayo", "100524236", "4225", 1, "18:46.7", "18:46.7", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Charlie", "Rauchman", "Park HS", "100561124", "4206", 1, "18:59.9", "18:59.9", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Logan", "Deedrick", "Osseo Composite", "100603902", "4203", 1, "19:04.5", "19:04.5", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Cason", "Van Voorst", "ISD728", "100610958", "4105", 1, "19:05.6", "19:05.6", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Parker", "Daniels", "ISD728", "100621889", "4099", 1, "19:06.6", "19:06.6", nil, nil, nil, "finished", nil, nil ],
  [ 38, "Chet", "Weiler", "Hudson HS", "100604552", "4096", 1, "19:25.2", "19:25.2", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Parker", "Fox", "Lakeville North HS", "100604331", "4117", 1, "19:39.0", "19:39.0", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Judah", "Roder", "Maple Grove HS", "100617052", "4133", 1, "20:16.1", "20:16.1", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Carter", "Lowe", "ISD728", "100609565", "4103", 1, "20:18.3", "20:18.3", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Gavin", "Adair", "Lakeville North HS", "100571981", "4116", 1, "20:19.1", "20:19.1", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Leo", "Smith", "Hudson HS", "100578718", "4095", 1, "20:33.2", "20:33.2", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Max", "Datema", "Rochester Mayo", "100519315", "4226", 1, "20:36.5", "20:36.5", nil, nil, nil, "finished", nil, nil ],
  [ 45, "Logan", "Schroeder", "Minnesota Valley", "100529457", "4157", 1, "20:55.7", "20:55.7", nil, nil, nil, "finished", nil, nil ],
  [ 46, "Nathan", "Dascher", "Rochester Area", "100620248", "4218", 1, "20:56.2", "20:56.2", nil, nil, nil, "finished", nil, nil ],
  [ 47, "Quinlan", "Dietz", "Maple Grove HS", "100571151", "4130", 1, "20:59.2", "20:59.2", nil, nil, nil, "finished", nil, nil ],
  [ 48, "Noah", "Kagol", "Lakeville North HS", "100574302", "4119", 1, "21:00.6", "21:00.6", nil, nil, nil, "finished", nil, nil ],
  [ 49, "Noah", "Schularick", "Maple Grove HS", "100575088", "4135", 1, "21:05.3", "21:05.3", nil, nil, nil, "finished", nil, nil ],
  [ 50, "Derek", "Hernke", "ISD728", "100610115", "4101", 1, "21:09.7", "21:09.7", nil, nil, nil, "finished", nil, nil ],
  [ 51, "Rex", "Nelson", "Chanhassen HS", "100535767", "4047", 1, "21:46.5", "21:46.5", nil, nil, nil, "finished", nil, nil ],
  [ 52, "Joshua", "Mills", "Westonka", "100565775", "4298", 1, "21:49.6", "21:49.6", nil, nil, nil, "finished", nil, nil ],
  [ 53, "Max", "Von Bank", "Mankato West HS", "100532520", "4128", 1, "21:50.9", "21:50.9", nil, nil, nil, "finished", nil, nil ],
  [ 54, "Maxwell", "Sauer", "Park HS", "100604707", "4207", 1, "21:56.7", "21:56.7", nil, nil, nil, "finished", nil, nil ],
  [ 55, "Graham", "Wojcik", "Elk River", "100528484", "4083", 1, "21:57.7", "21:57.7", nil, nil, nil, "finished", nil, nil ],
  [ 56, "Owen", "Golden", "Rochester Area", "100530334", "4219", 1, "22:15.6", "22:15.6", nil, nil, nil, "finished", nil, nil ],
  [ 57, "Chase", "Hayes", "Lakeville North HS", "100604554", "4118", 1, "23:08.1", "23:08.1", nil, nil, nil, "finished", nil, nil ],
  [ 58, "Morgan", "Patterson", "Osseo Composite", "100529670", "4205", 1, "23:28.3", "23:28.3", nil, nil, nil, "finished", nil, nil ],
  [ 59, "Isaac", "Senst", "Rochester Area", "100559341", "4222", 1, "24:03.4", "24:03.4", nil, nil, nil, "finished", nil, nil ],
  [ 60, "Warren", "Nigon", "Hudson HS", "100608735", "4094", 1, "24:35.4", "24:35.4", nil, nil, nil, "finished", nil, nil ],
  [ 61, "Noah", "Scherger", "Austin HS", "100514010", "4018", 1, "24:44.7", "24:44.7", nil, nil, nil, "finished", nil, nil ],
  [ 62, "Jordin", "Little", "Mankato", "100622092", "4125", 1, "24:48.8", "24:48.8", nil, nil, nil, "finished", nil, nil ],
  [ 63, "Nathaniel", "Veraza", "Rochester Area", "100618454", "4224", 1, "25:05.3", "25:05.3", nil, nil, nil, "finished", nil, nil ],
  [ 64, "Nolan", "Clifton", "River Falls HS", "100601695", "4215", 1, "26:39.9", "21:39.9", nil, nil, nil, "finished", "5 Min Bike Swap", nil ]
]

# 8th Grade Boys D1 Results
results_8th_grade_boys_d1 = [
  [ 1, "Tyler", "Tate", "Orono HS", "100529334", "4201", 1, "15:36.6", "15:36.6", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Abraham", "Hanson", "Prior Lake HS", "100566775", "4211", 1, "17:10.7", "17:10.7", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Nick", "Campbell", "Orono HS", "100535629", "4200", 1, "17:16.6", "17:16.6", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Ezra", "Cook", "Stillwater Mountain Bike", "100565190", "4274", 1, "17:27.4", "17:27.4", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Roman", "Gutzwiller", "Brainerd HS", "100533664", "4035", 1, "17:27.8", "17:27.8", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Justin", "Jabs", "New Prague MS and HS", "100510679", "4198", 1, "17:45.0", "17:45.0", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Andrew", "Kaso", "Prior Lake HS", "100532158", "4212", 1, "17:45.5", "17:45.5", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Austin", "Anderson", "Prior Lake HS", "100529114", "4208", 1, "17:49.0", "17:49.0", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Landon", "Trost", "Stillwater Mountain Bike", "100511944", "4280", 1, "17:58.1", "17:58.1", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Eli", "Walgrave", "Prior Lake HS", "100565589", "4214", 1, "18:18.2", "18:18.2", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Dillon", "Bermel", "Prior Lake HS", "100565810", "4209", 1, "18:27.2", "18:27.2", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Briggs", "MacLaughlin", "Brainerd HS", "100535219", "4036", 1, "18:42.5", "18:42.5", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Arlo", "Ziebell", "Stillwater Mountain Bike", "100609666", "4281", 1, "18:43.5", "18:43.5", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Landen", "Clark", "Brainerd HS", "100535486", "4034", 1, "18:52.2", "18:52.2", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Espen", "Krogstad", "St Paul Central", "100562927", "4266", 1, "18:55.0", "18:55.0", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Leo", "Ackerman", "New Prague MS and HS", "100530753", "4196", 1, "19:50.9", "19:50.9", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Carter", "Daniels", "Prior Lake HS", "100530170", "4210", 1, "20:01.9", "20:01.9", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Ethan", "Nowak", "Prior Lake HS", "100611167", "4213", 1, "20:07.2", "20:07.2", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Zachary", "Ericson", "Lakeville South HS", "100613180", "4121", 1, "20:43.4", "20:43.4", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Anthony", "DeGrego", "New Prague MS and HS", "100618599", "4197", 1, "21:47.9", "21:47.9", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Felix", "Sederstrom", "Stillwater Mountain Bike", "100521275", "4279", 1, "22:38.0", "22:38.0", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Jackson", "Johnson", "Stillwater Mountain Bike", "100521093", "4276", 1, "22:39.0", "22:39.0", nil, nil, nil, "finished", nil, nil ]
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

puts "\n🎉 Race 6 - Gamehaven seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
