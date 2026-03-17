require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - RACE 5N - DETROIT LAKES (2023-09-30)
# ===============================================================================

puts "Creating Race 5N - Detroit Lakes results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 5N - Detroit Lakes",
  race_date: Date.parse("2023-09-30")
) do |race|
  race.location = "Detroit Lakes, MN"
  race.year = 2023
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Jada", "Hollinbeck", "Armstrong Cycle", "100473324", "7005", 1, "00:20:35.803", "00:20:35.803", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Rue", "Nelson", "Crosby-Ironton HS", "100486017", "7022", 1, "00:21:46.258", "00:21:46.258", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Margot", "Toftness", "Crosby-Ironton HS", "100486370", "7023", 1, "00:22:06.323", "00:22:06.323", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Alyse", "Suchy", "Alexandria Youth Cycling", "100469138", "7004", 1, "00:22:08.924", "00:22:08.924", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Emelia", "Preston", "Alexandria Youth Cycling", "100473801", "7002", 1, "00:22:34.013", "00:22:34.013", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Lauren", "Krans", "Hopkins HS", "100473796", "7037", 1, "00:22:51.966", "00:22:51.966", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Fayanna", "Karel", "Mounds View HS", "100461301", "7050", 1, "00:23:35.920", "00:23:35.920", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Adiah", "Scherman", "New Prague MS and HS", "100483321", "7059", 1, "00:24:22.428", "00:24:22.428", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Lauren", "Mccann", "Hopkins HS", "100476201", "7038", 1, "00:26:27.580", "00:26:27.580", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Skyler", "Larson", "Alexandria Youth Cycling", "100484623", "7001", 1, "00:26:31.047", "00:26:31.047", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Nellie", "Reishus", "Alexandria Youth Cycling", "100470066", "7003", 1, "00:27:10.894", "00:27:10.894", nil, nil, nil, "finished", nil, nil ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Sam", "Schlauderaff", "Northwest", "100484745", "7638", 1, "00:18:42.908", "00:18:42.908", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Garrett", "Blaha", "Northwest", "100485466", "7637", 1, "00:19:09.733", "00:19:09.733", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Tye", "Holmgren", "Tioga Trailblazers", "100429051", "7695", 1, "00:19:20.610", "00:19:20.610", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Jonah", "Geisler", "Tioga Trailblazers", "100482692", "7693", 1, "00:20:10.677", "00:20:10.677", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Levi", "Harth", "Tioga Trailblazers", "100482243", "7694", 1, "00:20:53.177", "00:20:53.177", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Micah", "Friesner", "Crosby-Ironton HS", "100488249", "7550", 1, "00:21:26.556", "00:21:26.556", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Asher", "Lind", "West Range", "100460280", "7703", 1, "00:21:50.292", "00:21:50.292", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Riley", "Welch", "St Cloud", "100484619", "7672", 1, "00:21:50.772", "00:21:50.772", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Gavin", "Belich", "Cloquet-Esko-Carlton", "100460480", "7542", 1, "00:22:18.720", "00:22:18.720", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Owen", "Bianchet", "Roseville", "100462884", "7663", 1, "00:22:24.945", "00:22:24.945", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Gabe", "Towers", "Tioga Trailblazers", "100486864", "7697", 1, "00:22:35.700", "00:22:35.700", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Finn", "Neuman", "Tioga Trailblazers", "100486486", "7696", 1, "00:22:56.606", "00:22:56.606", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Henry", "Niskanen", "Independent HS", "100489235", "7712", 1, "00:23:04.032", "00:23:04.032", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Ian", "Lund", "North Dakota", "100480493", "7633", 1, "00:24:22.164", "00:24:22.164", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Cooper", "Greiner", "Cloquet-Esko-Carlton", "100462048", "7544", 1, "00:24:23.145", "00:24:23.145", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Jonathon", "Smanski", "Roseville", "100478637", "7665", 1, "00:24:26.282", "00:24:26.282", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Kirby", "Peterson", "Kerkhoven", "100476389", "7592", 1, "00:31:06.478", "00:31:06.478", nil, nil, nil, "finished", nil, nil ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [ 1, "Elliot", "Gruhn", "Hopkins HS", "100461645", "7586", 1, "00:20:23.671", "00:20:23.671", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Reid", "Anderson", "Wayzata Mountain Bike", "100486580", "7698", 1, "00:20:49.042", "00:20:49.042", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Charlie", "Mohr", "Wayzata Mountain Bike", "100486769", "7702", 1, "00:21:01.328", "00:21:01.328", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Copelan", "King-Ellison", "Wayzata Mountain Bike", "100462666", "7699", 1, "00:21:04.027", "00:21:04.027", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Jonah", "Ahlers", "Brainerd HS", "100488485", "7528", 1, "00:21:06.466", "00:21:06.466", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Korbin", "Kriel", "Alexandria Youth Cycling", "100473165", "7501", 1, "00:22:38.645", "00:22:38.645", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Asher", "Prevost", "Hopkins HS", "100461654", "7588", 1, "00:23:12.484", "00:23:12.484", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Cordell", "Weber", "Alexandria Youth Cycling", "100485288", "7504", 1, "00:23:13.132", "00:23:13.132", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Rowan", "Barrick", "Bloomington Jefferson", "100478238", "7520", 1, "00:23:29.273", "00:23:29.273", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Asher", "Plante", "Hopkins HS", "100480802", "7587", 1, "00:23:42.007", "00:23:42.007", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Elliot", "Candy", "Prior Lake HS", "100477563", "7641", 1, "00:24:50.782", "00:24:50.782", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Luke", "Johnson", "Armstrong Cycle", "100482608", "7507", 1, "00:25:06.831", "00:25:06.831", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Leo", "Calbone", "Bloomington Jefferson", "100459747", "7524", 1, "00:25:31.240", "00:25:31.240", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Samuel", "Anderson", "Brainerd HS", "100488361", "7529", 1, "00:26:04.625", "00:26:04.625", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Lee", "Evans", "Rock Ridge", "100460343", "7660", 1, "00:26:11.681", "00:26:11.681", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Garrett", "Malecha", "Mounds View HS", "100463030", "7620", 1, "00:27:16.880", "00:27:16.880", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Beckett", "Knoot", "Wayzata Mountain Bike", "100476959", "7700", 1, "00:28:45.706", "00:28:45.706", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Beckett", "Schroeder", "Prior Lake HS", "100477973", "7644", 1, "00:31:15.085", "00:31:15.085", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Will", "Koenig", "Prior Lake HS", "100485238", "7643", 1, "00:31:20.931", "00:31:20.931", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Girls Results
results_7th_grade_girls = [
  [ 1, "Claire", "Folkestad", "Alexandria Youth Cycling", "100412462", "6002", 1, "00:19:37.979", "00:19:37.979", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Cierah", "Mckibbon", "Cloquet-Esko-Carlton", "100406516", "6031", 1, "00:20:00.926", "00:20:00.926", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Peyton", "Stamschror", "Prior Lake HS", "100421499", "6078", 1, "00:20:10.898", "00:20:10.898", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Selah", "Beukema", "Rock Ridge", "100406949", "6084", 1, "00:20:38.691", "00:20:38.691", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Stella", "Museus", "Brainerd HS", "100431804", "6021", 1, "00:21:02.391", "00:21:02.391", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Nora", "Pulford", "Cloquet-Esko-Carlton", "100406069", "6032", 1, "00:21:43.268", "00:21:43.268", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Isabel", "Ricard", "St Cloud", "100484999", "6096", 1, "00:22:10.283", "00:22:10.283", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Lucy", "Grissman", "Hopkins HS", "100429919", "6042", 1, "00:22:45.886", "00:22:45.886", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Tahlia", "Rooney", "Alexandria Youth Cycling", "100411174", "6003", 1, "00:22:53.286", "00:22:53.286", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Megan", "Fritzen", "Prior Lake HS", "100412430", "6074", 1, "00:22:57.865", "00:22:57.865", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Sage", "Larson", "Brainerd HS", "100488621", "6020", 1, "00:23:12.631", "00:23:12.631", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Laney", "Tyminski", "Rock Ridge", "100392947", "6087", 1, "00:24:03.678", "00:24:03.678", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Lena", "Hill", "New Prague MS and HS", "100427524", "6072", 1, "00:25:00.341", "00:25:00.341", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Cora", "Metelak", "Tioga Trailblazers", "100400794", "6103", 1, "00:25:04.088", "00:25:04.088", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Aribelle", "Radinovich", "Crosby-Ironton HS", "100435059", "6033", 1, "00:26:48.200", "00:26:48.200", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Elaine", "Vanderziel", "Mounds View HS", "100485257", "6059", 1, "00:26:58.463", "00:26:58.463", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Audrey", "Jordan", "Cloquet-Esko-Carlton", "100423847", "6029", 1, "00:27:01.243", "00:27:01.243", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Posey", "Burres", "Bloomington Jefferson", "100417835", "6014", 1, "00:27:15.627", "00:27:15.627", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Naomi", "Menk", "Mounds View HS", "100476980", "6058", 1, "00:30:57.923", "00:30:57.923", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [ 1, "Owen", "Cawcutt", "Cloquet-Esko-Carlton", "100406443", "6553", 1, "00:18:14.159", "00:18:14.159", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Garrett", "Lusignan", "Minnesota Valley", "100426763", "6614", 1, "00:18:51.570", "00:18:51.570", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Carter", "Osvold", "Cloquet-Esko-Carlton", "100418932", "6554", 1, "00:19:25.897", "00:19:25.897", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Carter", "Bolster", "Minnesota Valley", "100389720", "6612", 1, "00:20:16.438", "00:20:16.438", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Beckett", "Craine", "Crosby-Ironton HS", "100390041", "6555", 1, "00:20:59.378", "00:20:59.378", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Evan", "Rasmussen", "Crosby-Ironton HS", "100484405", "6556", 1, "00:21:07.709", "00:21:07.709", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Alexander", "Mcnamara", "Totino Grace-Irondale", "100410387", "6760", 1, "00:21:22.274", "00:21:22.274", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Xavier", "Olson", "Minnesota Valley", "100408099", "6615", 1, "00:22:03.222", "00:22:03.222", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Calvin", "Winchester", "St Cloud", "100432690", "6735", 1, "00:22:07.248", "00:22:07.248", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Tucker", "Ferkinhoff", "St Cloud", "100485268", "6734", 1, "00:24:09.243", "00:24:09.243", nil, nil, nil, "finished", nil, nil ]
]

# 7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  [ 1, "Gus", "Layman", "Rock Ridge", "100405726", "6706", 1, "00:17:33.549", "00:17:33.549", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Charlie", "Knutson", "Armstrong Cycle", "100428818", "6511", 1, "00:17:43.154", "00:17:43.154", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Oliver", "Asrani", "Wayzata Mountain Bike", "100430527", "6762", 1, "00:18:28.853", "00:18:28.853", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Landon", "Hagen", "Brainerd HS", "100430928", "6533", 1, "00:18:54.672", "00:18:54.672", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Dain", "Peters", "Armstrong Cycle", "100476674", "6514", 1, "00:19:07.958", "00:19:07.958", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Rohan", "Goerke", "Wayzata Mountain Bike", "100465514", "6767", 1, "00:19:17.950", "00:19:17.950", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Michael", "Payne", "Armstrong Cycle", "100487162", "6513", 1, "00:19:28.922", "00:19:28.922", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Raphael", "Acharya", "Wayzata Mountain Bike", "100429681", "6761", 1, "00:19:54.504", "00:19:54.504", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Ethan", "Reid", "Brainerd HS", "100429282", "6534", 1, "00:19:58.202", "00:19:58.202", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Kellen", "Meyer", "Prior Lake HS", "100471655", "6688", 1, "00:20:02.182", "00:20:02.182", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Mason", "Thomforde", "Prior Lake HS", "100478323", "6692", 1, "00:20:03.550", "00:20:03.550", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Hudson", "Schuer", "Bloomington Jefferson", "100418217", "6528", 1, "00:20:06.341", "00:20:06.341", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Cameron", "Hysong", "Mounds View HS", "100406084", "6638", 1, "00:20:09.512", "00:20:09.512", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Brian", "Schrooten", "Bloomington Jefferson", "100405883", "6527", 1, "00:20:16.292", "00:20:16.292", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Tyler", "Hassis", "Armstrong Cycle", "100428895", "6509", 1, "00:20:27.357", "00:20:27.357", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Carson", "Downs", "Wayzata Mountain Bike", "100485811", "6765", 1, "00:20:32.823", "00:20:32.823", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Jonathan", "Bertelson", "Wayzata Mountain Bike", "100429514", "6764", 1, "00:20:52.812", "00:20:52.812", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Obadiah", "Reishus", "Alexandria Youth Cycling", "100424849", "6505", 1, "00:21:49.261", "00:21:49.261", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Noah", "Dahn", "New Prague MS and HS", "100420497", "6672", 1, "00:21:56.549", "00:21:56.549", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Dillon", "Larson", "Alexandria Youth Cycling", "100429585", "6504", 1, "00:22:07.268", "00:22:07.268", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Patrick", "Gramm", "Rock Ridge", "100420233", "6705", 1, "00:22:11.944", "00:22:11.944", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Camden", "Rigg", "Wayzata Mountain Bike", "100471123", "6774", 1, "00:22:19.070", "00:22:19.070", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Logan", "Duesler", "Rock Ridge", "100406433", "6704", 1, "00:22:31.034", "00:22:31.034", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Eli", "Franke", "Brainerd HS", "100488193", "6532", 1, "00:22:34.261", "00:22:34.261", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Nolan", "Struve", "Wayzata Mountain Bike", "100433849", "6775", 1, "00:22:36.264", "00:22:36.264", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Charlie", "Ellickson", "Wayzata Mountain Bike", "100427391", "6766", 1, "00:22:38.425", "00:22:38.425", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Ezra", "Metsa", "Rock Ridge", "100391716", "6707", 1, "00:22:39.858", "00:22:39.858", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Brock", "Barlage", "New Prague MS and HS", "100427535", "6671", 1, "00:22:47.118", "00:22:47.118", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Lucas", "Johnson", "Wayzata Mountain Bike", "100426756", "6769", 1, "00:24:01.843", "00:24:01.843", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Kieran", "Roark", "Rock Ridge", "100407570", "6709", 1, "00:24:14.565", "00:24:14.565", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Devin", "Schilling", "Bloomington Jefferson", "100458634", "6526", 1, "00:24:56.092", "00:24:56.092", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Christian", "Beecher", "Wayzata Mountain Bike", "100432720", "6763", 1, "00:25:07.756", "00:25:07.756", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Juhani", "Rosandich", "Rock Ridge", "100428417", "6710", 1, "00:25:42.166", "00:25:42.166", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Evan", "Sachs", "Prior Lake HS", "100421249", "6690", 1, "00:26:12.232", "00:26:12.232", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Otto", "Good", "Alexandria Youth Cycling", "100475269", "6502", 1, "00:26:41.482", "00:26:41.482", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Finnegan", "Pedersen", "Bloomington Jefferson", "100461167", "6525", 1, "00:26:54.163", "00:26:54.163", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Eian", "Bienias", "Alexandria Youth Cycling", "100482767", "6501", 1, "00:28:32.644", "00:28:32.644", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Girls Results
results_8th_grade_girls = [
  [ 1, "Vanessa", "Rickmeyer", "Crosby-Ironton HS", "100392315", "5016", 1, "00:19:24.193", "00:19:24.193", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Avery", "Lonergan", "Crosby-Ironton HS", "100391498", "5015", 1, "00:19:26.020", "00:19:26.020", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Josie", "Schroeder", "Hopkins HS", "100392529", "5033", 1, "00:19:57.420", "00:19:57.420", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Georgi", "Toftness", "Crosby-Ironton HS", "100486257", "5018", 1, "00:20:11.704", "00:20:11.704", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Addison", "Suchy", "Alexandria Youth Cycling", "100392777", "5003", 1, "00:20:40.493", "00:20:40.493", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Jadon", "Carlson", "Mounds View HS", "100409174", "5047", 1, "00:20:43.845", "00:20:43.845", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Callie", "Dornfeld", "Mounds View HS", "100462960", "5048", 1, "00:21:01.170", "00:21:01.170", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Ingrid", "Olson", "Minnesota Valley", "100408103", "5040", 1, "00:21:01.788", "00:21:01.788", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Norah", "Roth", "Crosby-Ironton HS", "100430559", "5017", 1, "00:21:06.711", "00:21:06.711", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Greta", "Nygren", "Hopkins HS", "100391958", "5032", 1, "00:21:08.502", "00:21:08.502", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Lydia", "Michals", "Hopkins HS", "100422641", "5031", 1, "00:21:34.551", "00:21:34.551", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Fern", "Shaffner", "Roseville", "100426662", "5077", 1, "00:22:17.623", "00:22:17.623", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Allison", "Claydon", "Roseville", "100389971", "5076", 1, "00:22:19.163", "00:22:19.163", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Allison", "Tobias", "Minnesota Valley", "100462936", "5042", 1, "00:22:21.977", "00:22:21.977", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Clara", "Davis", "Northwest", "100390104", "5066", 1, "00:22:26.766", "00:22:26.766", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Eva", "Folger", "Prior Lake HS", "100390402", "5069", 1, "00:23:31.488", "00:23:31.488", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Hailey", "Soine", "Kerkhoven", "100392669", "5036", 1, "00:25:28.912", "00:25:28.912", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Jillian", "Rud", "Minnesota Valley", "100487126", "5041", 1, "00:29:15.883", "00:29:15.883", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Nicolette", "Parmer", "North Dakota", "100392072", "5064", 1, "00:30:44.864", "00:30:44.864", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Boys D2 Results
results_8th_grade_boys_d2 = [
  [ 1, "Jack", "Larsen", "St Cloud", "100391366", "5566", 1, "00:15:57.768", "00:15:57.768", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Ezra", "Jacobson", "Crosby-Ironton HS", "100390997", "5364", 1, "00:16:23.262", "00:16:23.262", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Levi", "Raisanen", "Cloquet-Esko-Carlton", "100392257", "5358", 1, "00:17:26.126", "00:17:26.126", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Nolan", "Hendrickson", "Cloquet-Esko-Carlton", "100405947", "5355", 1, "00:17:31.606", "00:17:31.606", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Isaac", "Leiseth", "Northwest", "100391421", "5494", 1, "00:17:42.797", "00:17:42.797", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Levi", "Turner", "Crosby-Ironton HS", "100432168", "5367", 1, "00:17:44.734", "00:17:44.734", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Logan", "Gamache", "Cloquet-Esko-Carlton", "100390494", "5354", 1, "00:17:49.495", "00:17:49.495", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Alexander", "Nelson", "Cloquet-Esko-Carlton", "100391877", "5357", 1, "00:17:51.867", "00:17:51.867", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Bennett", "Schmaltz", "Roseville", "100392503", "5551", 1, "00:18:08.696", "00:18:08.696", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Graham", "Wilder", "Cloquet-Esko-Carlton", "100393143", "5361", 1, "00:18:25.815", "00:18:25.815", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Levi", "Geisler", "Tioga Trailblazers", "100390530", "5602", 1, "00:19:13.726", "00:19:13.726", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Calm", "Enz", "Northwest", "100390296", "5493", 1, "00:19:39.069", "00:19:39.069", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Rylan", "Macadams", "Bloomington", "100433388", "5319", 1, "00:19:40.902", "00:19:40.902", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Logan", "Waldo", "Cloquet-Esko-Carlton", "100413335", "5360", 1, "00:19:41.146", "00:19:41.146", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Mac", "Walli", "West Range", "100393037", "5621", 1, "00:19:42.594", "00:19:42.594", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Ian", "Artley", "Northwest", "100428031", "5492", 1, "00:20:03.772", "00:20:03.772", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Henry", "Loe", "Roseville", "100424568", "5550", 1, "00:20:03.782", "00:20:03.782", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Brady", "Mattson", "Tioga Trailblazers", "100391627", "5604", 1, "00:20:03.792", "00:20:03.792", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Lliam", "Zimny", "Cloquet-Esko-Carlton", "100407790", "5363", 1, "00:20:35.816", "00:20:35.816", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Abram", "Thwaits", "Cloquet-Esko-Carlton", "100407182", "5359", 1, "00:21:31.086", "00:21:31.086", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Thomas", "Segari", "Tioga Trailblazers", "100411446", "5605", 1, "00:21:47.085", "00:21:47.085", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Nolan", "Murtaugh", "Totino Grace-Irondale", "100475711", "5409", 1, "00:23:13.557", "00:23:13.557", nil, nil, nil, "finished", nil, nil ]
]

# 8th Grade Boys D1 Results
results_8th_grade_boys_d1 = [
  [ 1, "Lincoln", "Stuber", "New Prague MS and HS", "100392775", "5491", 1, "00:16:41.978", "00:16:41.978", nil, nil, nil, "finished", nil, nil ],
  [ 2, "Ben", "Rasmussen", "New Prague MS and HS", "100392267", "5490", 1, "00:16:45.653", "00:16:45.653", nil, nil, nil, "finished", nil, nil ],
  [ 3, "Elijah", "Hayes", "Brainerd HS", "100390768", "5330", 1, "00:17:23.858", "00:17:23.858", nil, nil, nil, "finished", nil, nil ],
  [ 4, "Charlie", "Gruhn", "Hopkins HS", "100390620", "5397", 1, "00:17:25.996", "00:17:25.996", nil, nil, nil, "finished", nil, nil ],
  [ 5, "Ethan", "Li", "Wayzata Mountain Bike", "100391462", "5613", 1, "00:17:50.385", "00:17:50.385", nil, nil, nil, "finished", nil, nil ],
  [ 6, "Casey", "Kelly", "New Prague MS and HS", "100391153", "5488", 1, "00:17:50.623", "00:17:50.623", nil, nil, nil, "finished", nil, nil ],
  [ 7, "Rowan", "Eaton", "Hopkins HS", "100437781", "5396", 1, "00:17:57.542", "00:17:57.542", nil, nil, nil, "finished", nil, nil ],
  [ 8, "Milo", "Needham", "Mounds View HS", "100391871", "5453", 1, "00:17:58.308", "00:17:58.308", nil, nil, nil, "finished", nil, nil ],
  [ 9, "Parker", "Chen", "Wayzata Mountain Bike", "100429402", "5609", 1, "00:17:59.766", "00:17:59.766", nil, nil, nil, "finished", nil, nil ],
  [ 10, "Joshua", "Henderson", "Mounds View HS", "100406311", "5451", 1, "00:18:03.126", "00:18:03.126", nil, nil, nil, "finished", nil, nil ],
  [ 11, "Hunter", "Hollinbeck", "Armstrong Cycle", "100429319", "5314", 1, "00:18:12.384", "00:18:12.384", nil, nil, nil, "finished", nil, nil ],
  [ 12, "Levi", "Preston", "Alexandria Youth Cycling", "100392225", "5309", 1, "00:18:23.382", "00:18:23.382", nil, nil, nil, "finished", nil, nil ],
  [ 13, "Brexten", "Hopke", "New Prague MS and HS", "100483347", "5487", 1, "00:18:47.064", "00:18:47.064", nil, nil, nil, "finished", nil, nil ],
  [ 14, "Mackean", "Haines", "Brainerd HS", "100390666", "5329", 1, "00:19:01.983", "00:19:01.983", nil, nil, nil, "finished", nil, nil ],
  [ 15, "Weston", "Graber", "New Prague MS and HS", "100426483", "5486", 1, "00:19:04.103", "00:19:04.103", nil, nil, nil, "finished", nil, nil ],
  [ 16, "Charlie", "Gustafson", "Wayzata Mountain Bike", "100390638", "5611", 1, "00:19:09.091", "00:19:09.091", nil, nil, nil, "finished", nil, nil ],
  [ 17, "Bjorn", "Moon", "Brainerd HS", "100486263", "5331", 1, "00:19:37.872", "00:19:37.872", nil, nil, nil, "finished", nil, nil ],
  [ 18, "Griffin", "Woeste", "Hopkins HS", "100420454", "5401", 1, "00:19:43.152", "00:19:43.152", nil, nil, nil, "finished", nil, nil ],
  [ 19, "Parker", "Jensen", "Alexandria Youth Cycling", "100428891", "5307", 1, "00:19:46.648", "00:19:46.648", nil, nil, nil, "finished", nil, nil ],
  [ 20, "Sam", "Corbett", "Wayzata Mountain Bike", "100390030", "5610", 1, "00:19:57.314", "00:19:57.314", nil, nil, nil, "finished", nil, nil ],
  [ 21, "Connor", "Long", "Prior Lake HS", "100391499", "5511", 1, "00:19:59.517", "00:19:59.517", nil, nil, nil, "finished", nil, nil ],
  [ 22, "Dominick", "Johnson", "Bloomington Jefferson", "100391056", "5322", 1, "00:20:01.000", "00:20:01.000", nil, nil, nil, "finished", nil, nil ],
  [ 23, "Nolan", "Macmillan", "Wayzata Mountain Bike", "100391535", "5614", 1, "00:20:16.165", "00:20:16.165", nil, nil, nil, "finished", nil, nil ],
  [ 24, "Caleb", "Crowser", "Alexandria Youth Cycling", "100390049", "5303", 1, "00:20:22.219", "00:20:22.219", nil, nil, nil, "finished", nil, nil ],
  [ 25, "Patrick", "Johnson", "Hopkins HS", "100429334", "5398", 1, "00:20:22.241", "00:20:22.241", nil, nil, nil, "finished", nil, nil ],
  [ 26, "Daniel", "Horter", "Prior Lake HS", "100390927", "5510", 1, "00:20:33.457", "00:20:33.457", nil, nil, nil, "finished", nil, nil ],
  [ 27, "Lance", "Karel", "Mounds View HS", "100391141", "5452", 1, "00:20:40.109", "00:20:40.109", nil, nil, nil, "finished", nil, nil ],
  [ 28, "Brewster", "Vittera", "Wayzata Mountain Bike", "100478199", "5620", 1, "00:20:43.453", "00:20:43.453", nil, nil, nil, "finished", nil, nil ],
  [ 29, "Josh", "Mohr", "Wayzata Mountain Bike", "100426269", "5615", 1, "00:21:01.605", "00:21:01.605", nil, nil, nil, "finished", nil, nil ],
  [ 30, "Kelton", "Hughes", "Alexandria Youth Cycling", "100434946", "5306", 1, "00:21:06.603", "00:21:06.603", nil, nil, nil, "finished", nil, nil ],
  [ 31, "Carlo", "Calbone", "Bloomington Jefferson", "100406760", "5320", 1, "00:21:21.174", "00:21:21.174", nil, nil, nil, "finished", nil, nil ],
  [ 32, "Gunner", "Rach", "Alexandria Youth Cycling", "100486184", "5310", 1, "00:21:26.155", "00:21:26.155", nil, nil, nil, "finished", nil, nil ],
  [ 33, "Camden", "Danielson", "Alexandria Youth Cycling", "100415033", "5304", 1, "00:21:49.577", "00:21:49.577", nil, nil, nil, "finished", nil, nil ],
  [ 34, "Sam", "Kelley", "Alexandria Youth Cycling", "100486429", "5308", 1, "00:21:52.967", "00:21:52.967", nil, nil, nil, "finished", nil, nil ],
  [ 35, "Pike", "Amundson", "Alexandria Youth Cycling", "100389433", "5301", 1, "00:22:06.801", "00:22:06.801", nil, nil, nil, "finished", nil, nil ],
  [ 36, "Griffen", "Bugher", "Alexandria Youth Cycling", "100389829", "5302", 1, "00:22:44.808", "00:22:44.808", nil, nil, nil, "finished", nil, nil ],
  [ 37, "Benjamin", "Erickson", "Mounds View HS", "100483370", "5449", 1, "00:22:56.198", "00:22:56.198", nil, nil, nil, "finished", nil, nil ],
  [ 38, "James", "Aaker", "Wayzata Mountain Bike", "100389379", "5607", 1, "00:23:00.208", "00:23:00.208", nil, nil, nil, "finished", nil, nil ],
  [ 39, "Gavin", "Gilbertson", "Alexandria Youth Cycling", "100429357", "5305", 1, "00:23:05.799", "00:23:05.799", nil, nil, nil, "finished", nil, nil ],
  [ 40, "Edward", "Shaul", "Prior Lake HS", "100473003", "5514", 1, "00:23:27.270", "00:23:27.270", nil, nil, nil, "finished", nil, nil ],
  [ 41, "Nils", "Stadsklev", "Alexandria Youth Cycling", "100486523", "5311", 1, "00:23:27.450", "00:23:27.450", nil, nil, nil, "finished", nil, nil ],
  [ 42, "Gavin", "Olinger", "Prior Lake HS", "100391997", "5513", 1, "00:23:54.642", "00:23:54.642", nil, nil, nil, "finished", nil, nil ],
  [ 43, "Will", "Center", "Mounds View HS", "100466138", "5448", 1, "00:24:22.772", "00:24:22.772", nil, nil, nil, "finished", nil, nil ],
  [ 44, "Ryan", "Jones", "Wayzata Mountain Bike", "100481981", "5612", 1, "00:25:10.420", "00:25:10.420", nil, nil, nil, "finished", nil, nil ]
]

# Freshman Boys D2 Results
results_freshman_boys_d2 = [
  [ 1, "Owen", "Ritter", "Crosby-Ironton HS", "100392330", "4810", 2, "00:32:36.902", "00:16:23.120", "00:16:13.782", nil, nil, "finished", nil, nil ],
  [ 2, "Ethan", "Kvitek", "Cloquet-Esko-Carlton", "100391323", "4473", 2, "00:33:21.582", "00:16:24.070", "00:16:57.512", nil, nil, "finished", nil, nil ],
  [ 3, "Liam", "Larson", "Bemidji", "100391377", "4425", 2, "00:33:49.169", "00:16:51.020", "00:16:58.149", nil, nil, "finished", nil, nil ],
  [ 4, "Hank", "Schlauderaff", "Northwest", "100392498", "4617", 2, "00:34:25.922", "00:17:33.451", "00:16:52.471", nil, nil, "finished", nil, nil ],
  [ 5, "Mikkol", "Yost", "Bemidji", "100393220", "4429", 2, "00:35:07.285", "00:17:35.189", "00:17:32.096", nil, nil, "finished", nil, nil ],
  [ 6, "Daniel", "Dewey", "Cloquet-Esko-Carlton", "100388196", "4472", 2, "00:35:14.126", "00:17:34.318", "00:17:39.808", nil, nil, "finished", nil, nil ],
  [ 7, "Arthur", "Goodman", "Duluth", "100390573", "4479", 2, "00:35:14.266", "00:17:35.194", "00:17:39.072", nil, nil, "finished", nil, nil ],
  [ 8, "Nolan", "Blaha", "Northwest", "100389685", "4616", 2, "00:35:58.174", "00:18:04.208", "00:17:53.966", nil, nil, "finished", nil, nil ],
  [ 9, "Alexander", "Smith", "Cloquet-Esko-Carlton", "100473528", "4476", 2, "00:36:26.784", "00:17:58.317", "00:18:28.467", nil, nil, "finished", nil, nil ],
  [ 10, "Finnegan", "Vandal", "Duluth", "100392968", "4480", 2, "00:36:28.524", "00:17:41.796", "00:18:46.728", nil, nil, "finished", nil, nil ],
  [ 11, "Eric", "Stangel", "Tioga Trailblazers", "100430925", "4770", 2, "00:36:43.267", "00:18:01.050", "00:18:42.217", nil, nil, "finished", nil, nil ],
  [ 12, "Jack", "Martin", "Bemidji", "100391606", "4428", 2, "00:36:56.841", "00:17:59.374", "00:18:57.467", nil, nil, "finished", nil, nil ],
  [ 13, "Wyatt", "Backowski", "Crosby-Ironton HS", "100389517", "4477", 2, "00:37:31.688", "00:18:06.436", "00:19:25.252", nil, nil, "finished", nil, nil ],
  [ 14, "Jacob", "Staehling", "St Cloud", "100392710", "4711", 2, "00:37:41.092", "00:18:35.661", "00:19:05.431", nil, nil, "finished", nil, nil ],
  [ 15, "Gavin", "Brey", "Tioga Trailblazers", "100483723", "4765", 2, "00:38:16.206", "00:18:34.678", "00:19:41.528", nil, nil, "finished", nil, nil ],
  [ 16, "Micah", "Strickland", "Kerkhoven", "100427219", "4532", 2, "00:38:16.931", "00:19:01.233", "00:19:15.698", nil, nil, "finished", nil, nil ],
  [ 17, "Ian", "Schneider", "St Cloud", "100392511", "4710", 2, "00:38:22.967", "00:19:03.361", "00:19:19.606", nil, nil, "finished", nil, nil ],
  [ 18, "Jonny", "Benson", "Kerkhoven", "100389618", "4530", 2, "00:38:48.219", "00:19:04.610", "00:19:43.609", nil, nil, "finished", nil, nil ],
  [ 19, "Ben", "Lindgren", "Bemidji", "100488732", "4426", 2, "00:39:28.328", "00:19:31.840", "00:19:56.488", nil, nil, "finished", nil, nil ],
  [ 20, "Emmett", "Lind", "West Range", "100391468", "4784", 2, "00:40:07.097", "00:19:26.122", "00:20:40.975", nil, nil, "finished", nil, nil ],
  [ 21, "David", "Robinson", "North Dakota", "100392352", "4605", 2, "00:40:13.172", "00:19:51.990", "00:20:21.182", nil, nil, "finished", nil, nil ],
  [ 22, "William", "Kenowski", "Tioga Trailblazers", "100391176", "4767", 2, "00:40:45.095", "00:19:37.843", "00:21:07.252", nil, nil, "finished", nil, nil ],
  [ 23, "Crosby", "Kuzel", "Bemidji", "100488753", "4424", 2, "00:42:25.726", "00:20:45.296", "00:21:40.430", nil, nil, "finished", nil, nil ],
  [ 24, "Ben", "Jones", "Bloomington", "100391098", "4436", 2, "00:42:28.502", "00:20:51.651", "00:21:36.851", nil, nil, "finished", nil, nil ],
  [ 25, "Joe", "Ayd", "Totino Grace-Irondale", "100462812", "4529", 2, "00:42:32.871", "00:20:53.409", "00:21:39.462", nil, nil, "finished", nil, nil ],
  [ 26, "Oscar", "Petrie", "Roseville", "100392165", "4688", 2, "00:44:15.242", "00:22:08.581", "00:22:06.661", nil, nil, "finished", nil, nil ],
  [ 27, "Owen", "Windorski", "Tioga Trailblazers", "100393175", "4772", 2, "00:44:32.589", "00:20:59.079", "00:23:33.510", nil, nil, "finished", nil, nil ],
  [ 28, "Thorvald", "Patenaude", "North Dakota Kindred", "100392085", "4607", 2, "00:45:11.904", "00:21:49.881", "00:23:22.023", nil, nil, "finished", nil, nil ],
  [ 29, "Ian", "Mcconn", "Roseville", "100391651", "4687", 2, "00:47:15.789", "00:23:44.331", "00:23:31.458", nil, nil, "finished", nil, nil ],
  [ 30, "Cooper", "Peterson", "Kerkhoven", "100423972", "4531", 2, "00:48:11.459", "00:23:45.637", "00:24:25.822", nil, nil, "finished", nil, nil ],
  [ 31, "Colt", "Christensen", "Tioga Trailblazers", "100484698", "4766", 2, "00:48:45.398", "00:23:33.373", "00:25:12.025", nil, nil, "finished", nil, nil ],
  [ 32, "Logan", "Sutherland", "Bemidji", "100487866", "4812", 0, "", "", "", nil, nil, "DNF", nil, nil ]
]

# Freshman Boys D1 Results
results_freshman_boys_d1 = [
  [ 1, "Rylan", "O'Hearn", "Brainerd HS", "100429671", "4807", 2, "00:32:02.414", "00:16:04.391", "00:15:58.023", nil, nil, "finished", nil, nil ],
  [ 2, "Roenen", "King-Ellison", "Wayzata Mountain Bike", "100391198", "4777", 2, "00:32:33.649", "00:16:26.716", "00:16:06.933", nil, nil, "finished", nil, nil ],
  [ 3, "Ian", "Halbmaier", "New Prague MS and HS", "100390667", "4612", 2, "00:33:00.254", "00:16:21.492", "00:16:38.762", nil, nil, "finished", nil, nil ],
  [ 4, "Anders", "Decker", "Armstrong Cycle", "100390117", "4413", 2, "00:33:07.605", "00:16:37.675", "00:16:29.930", nil, nil, "finished", nil, nil ],
  [ 5, "Hayden", "Braith", "New Prague MS and HS", "100389750", "4608", 2, "00:33:16.161", "00:16:21.508", "00:16:54.653", nil, nil, "finished", nil, nil ],
  [ 6, "Rigel", "Prior", "Wayzata Mountain Bike", "100392227", "4821", 2, "00:33:25.348", "00:16:19.327", "00:17:06.021", nil, nil, "finished", nil, nil ],
  [ 7, "Noah", "Lafrance", "Wayzata Mountain Bike", "100431235", "4778", 2, "00:33:27.359", "00:16:33.260", "00:16:54.099", nil, nil, "finished", nil, nil ],
  [ 8, "Thomas", "Quackenbush", "Mounds View HS", "100392241", "4575", 2, "00:33:47.670", "00:16:37.101", "00:17:10.569", nil, nil, "finished", nil, nil ],
  [ 9, "Nolan", "Haar", "Hopkins HS", "100390647", "4517", 2, "00:33:59.521", "00:16:40.319", "00:17:19.202", nil, nil, "finished", nil, nil ],
  [ 10, "Silas", "Johnson", "Hopkins HS", "100391088", "4519", 2, "00:35:11.415", "00:00:00.090", "00:35:11.325", nil, nil, "finished", nil, nil ],
  [ 11, "Wyatt", "Petrack", "Rock Ridge", "100392163", "4674", 2, "00:35:11.673", "00:17:21.191", "00:17:50.482", nil, nil, "finished", nil, nil ],
  [ 12, "Carson", "Loffler", "New Prague MS and HS", "100427517", "4613", 2, "00:35:23.632", "00:17:27.489", "00:17:56.143", nil, nil, "finished", nil, nil ],
  [ 13, "Eli", "Czajkowski", "Prior Lake HS", "100390065", "4632", 2, "00:35:26.440", "00:17:31.549", "00:17:54.891", nil, nil, "finished", nil, nil ],
  [ 14, "Henry", "Dahn", "New Prague MS and HS", "100420495", "4610", 2, "00:35:31.295", "00:17:34.394", "00:17:56.901", nil, nil, "finished", nil, nil ],
  [ 15, "Laken", "Bartel", "Mounds View HS", "100407702", "4567", 2, "00:35:47.695", "00:17:17.702", "00:18:29.993", nil, nil, "finished", nil, nil ],
  [ 16, "Patrick", "Ryan", "Brainerd HS", "100392417", "4808", 2, "00:35:59.727", "00:17:39.536", "00:18:20.191", nil, nil, "finished", nil, nil ],
  [ 17, "Henry", "Diaz", "Armstrong Cycle", "100390153", "4414", 2, "00:36:09.260", "00:17:22.504", "00:18:46.756", nil, nil, "finished", nil, nil ],
  [ 18, "Cohen", "Trumbull", "Prior Lake HS", "100392925", "4643", 2, "00:36:10.252", "00:17:45.196", "00:18:25.056", nil, nil, "finished", nil, nil ],
  [ 19, "Breck", "Swanson", "Armstrong Cycle", "100427609", "4418", 2, "00:36:43.019", "00:17:43.644", "00:18:59.375", nil, nil, "finished", nil, nil ],
  [ 20, "Logan", "Strohmeyer", "Duluth East HS", "100431163", "4815", 2, "00:37:41.573", "00:18:11.361", "00:19:30.212", nil, nil, "finished", nil, nil ],
  [ 21, "Connor", "Kelsey", "Prior Lake HS", "100470838", "4639", 2, "00:37:47.485", "00:19:02.560", "00:18:44.925", nil, nil, "finished", nil, nil ],
  [ 22, "Luke", "Forster", "Prior Lake HS", "100422846", "4635", 2, "00:37:47.489", "00:18:42.051", "00:19:05.438", nil, nil, "finished", nil, nil ],
  [ 23, "Greysen", "Charnstrom", "New Prague MS and HS", "100389926", "4609", 2, "00:37:49.800", "00:18:21.982", "00:19:27.818", nil, nil, "finished", nil, nil ],
  [ 24, "Austin", "Dvorak", "New Prague MS and HS", "100476926", "4611", 2, "00:37:49.801", "00:19:03.531", "00:18:46.270", nil, nil, "finished", nil, nil ],
  [ 25, "Will", "Nichols", "Alexandria Youth Cycling", "100391916", "4406", 2, "00:37:55.882", "00:18:22.760", "00:19:33.122", nil, nil, "finished", nil, nil ],
  [ 26, "Ben", "Scholten", "Alexandria Youth Cycling", "100392520", "4408", 2, "00:38:13.518", "00:18:27.620", "00:19:45.898", nil, nil, "finished", nil, nil ],
  [ 27, "Jackson", "Engelbrecht", "Alexandria Youth Cycling", "100390288", "4402", 2, "00:38:49.973", "00:18:28.494", "00:20:21.479", nil, nil, "finished", nil, nil ],
  [ 28, "Alex", "Fisher", "Prior Lake HS", "100390381", "4634", 2, "00:39:24.174", "00:19:03.535", "00:20:20.639", nil, nil, "finished", nil, nil ],
  [ 29, "Walter", "Ratwik", "Mounds View HS", "100407894", "4819", 2, "00:39:49.856", "00:19:39.135", "00:20:10.721", nil, nil, "finished", nil, nil ],
  [ 30, "Sami", "Smith", "Prior Lake HS", "100486053", "4641", 2, "00:39:51.541", "00:19:15.802", "00:20:35.739", nil, nil, "finished", nil, nil ],
  [ 31, "Finn", "Dolmar", "Bloomington Jefferson", "100390192", "4439", 2, "00:40:08.552", "00:19:42.872", "00:20:25.680", nil, nil, "finished", nil, nil ],
  [ 32, "Kaegan", "Museus", "Brainerd HS", "100391857", "4447", 2, "00:40:11.131", "00:19:12.273", "00:20:58.858", nil, nil, "finished", nil, nil ],
  [ 33, "Austin", "Cleghorn", "Prior Lake HS", "100389975", "4631", 2, "00:40:14.620", "00:19:43.756", "00:20:30.864", nil, nil, "finished", nil, nil ],
  [ 34, "Jonas", "Klicker", "Brainerd HS", "100489143", "4446", 2, "00:40:17.642", "00:19:52.296", "00:20:25.346", nil, nil, "finished", nil, nil ],
  [ 35, "Tyler", "Rosemeier", "New Prague MS and HS", "100411201", "4614", 2, "00:40:31.041", "00:19:59.133", "00:20:31.908", nil, nil, "finished", nil, nil ],
  [ 36, "Camden", "Esser", "Brainerd HS", "100486570", "4445", 2, "00:41:30.255", "00:21:24.391", "00:20:05.864", nil, nil, "finished", nil, nil ],
  [ 37, "Isaac", "Grieve", "Alexandria Youth Cycling", "100390613", "4404", 2, "00:42:19.047", "00:20:29.234", "00:21:49.813", nil, nil, "finished", nil, nil ],
  [ 38, "Corben", "Asuma", "Rock Ridge", "100389501", "4669", 2, "00:42:34.742", "00:20:30.122", "00:22:04.620", nil, nil, "finished", nil, nil ],
  [ 39, "Ian", "Mariette", "Armstrong Cycle", "100391584", "4417", 2, "00:43:41.703", "00:21:08.531", "00:22:33.172", nil, nil, "finished", nil, nil ],
  [ 40, "Dylan", "Cover", "Armstrong Cycle", "100390040", "4412", 2, "00:44:08.855", "00:21:33.004", "00:22:35.851", nil, nil, "finished", nil, nil ],
  [ 41, "Chase", "Ofstad", "Rock Ridge", "100473577", "4673", 2, "00:44:16.643", "00:21:31.646", "00:22:44.997", nil, nil, "finished", nil, nil ],
  [ 42, "Garrett", "Thurston", "Prior Lake HS", "100392864", "4642", 2, "00:44:24.336", "00:21:57.097", "00:22:27.239", nil, nil, "finished", nil, nil ],
  [ 43, "Logan", "Delahay", "Mounds View HS", "100461864", "4569", 2, "00:44:31.951", "00:21:58.277", "00:22:33.674", nil, nil, "finished", nil, nil ],
  [ 44, "Carter", "Gamm", "Alexandria Youth Cycling", "100428770", "4403", 2, "00:44:37.358", "00:21:52.398", "00:22:44.960", nil, nil, "finished", nil, nil ],
  [ 45, "Austin", "Hagerty", "Wayzata Mountain Bike", "100468487", "4775", 2, "00:44:54.685", "00:21:53.442", "00:23:01.243", nil, nil, "finished", nil, nil ],
  [ 46, "Gavin", "Peterson", "Alexandria Youth Cycling", "100392155", "4407", 2, "00:45:40.813", "00:21:45.737", "00:23:55.076", nil, nil, "finished", nil, nil ],
  [ 47, "Thomas", "Jonell", "Prior Lake HS", "100391096", "4638", 2, "00:45:42.427", "00:22:12.872", "00:23:29.555", nil, nil, "finished", nil, nil ],
  [ 48, "Avery", "Pliscott", "Brainerd HS", "100428605", "4448", 2, "00:46:18.345", "00:22:24.676", "00:23:53.669", nil, nil, "finished", nil, nil ],
  [ 49, "Cael", "Harty", "Wayzata Mountain Bike", "100476355", "4776", 2, "00:49:05.067", "00:23:13.561", "00:25:51.506", nil, nil, "finished", nil, nil ],
  [ 50, "Everett", "Knudson", "Rock Ridge", "100485095", "4672", 2, "00:53:51.890", "00:26:02.857", "00:27:49.033", nil, nil, "finished", nil, nil ],
  [ 51, "Baron", "Tikalsky", "New Prague MS and HS", "100424730", "4615", 1, "00:18:25.286", "00:18:25.286", "", nil, nil, "DNF", nil, nil ],
  [ 52, "Jackson", "White", "Prior Lake HS", "100475578", "4645", 0, "", "", "", nil, nil, "DNF", nil, nil ]
]

# Freshman Girls Results
results_freshman_girls = [
  [ 1, "Natalia", "Kunze", "Duluth", "100391315", "4022", 2, "00:36:53.985", "00:18:19.148", "00:18:34.837", nil, nil, "finished", nil, nil ],
  [ 2, "Ava", "Mckibbon", "Cloquet-Esko-Carlton", "100406513", "4020", 2, "00:36:57.699", "00:18:20.448", "00:18:37.251", nil, nil, "finished", nil, nil ],
  [ 3, "Alexis", "Ridgeway", "New Prague MS and HS", "100420802", "4079", 2, "00:38:02.245", "00:18:28.922", "00:19:33.323", nil, nil, "finished", nil, nil ],
  [ 4, "Stella", "Huseth", "Hopkins HS", "100390963", "4031", 2, "00:38:14.992", "00:19:08.941", "00:19:06.051", nil, nil, "finished", nil, nil ],
  [ 5, "Clementine", "Handler", "Hopkins HS", "100431613", "4080", 2, "00:38:20.622", "00:19:09.679", "00:19:10.943", nil, nil, "finished", nil, nil ],
  [ 6, "Arabella", "Fritzen", "Prior Lake HS", "100390462", "4052", 2, "00:38:30.509", "00:18:53.704", "00:19:36.805", nil, nil, "finished", nil, nil ],
  [ 7, "Dallas", "Layman", "Rock Ridge", "100391401", "4059", 2, "00:39:19.212", "00:19:07.050", "00:20:12.162", nil, nil, "finished", nil, nil ],
  [ 8, "Phoebe", "Hackensack", "St Cloud", "100430601", "4087", 2, "00:39:23.625", "00:19:10.605", "00:20:13.020", nil, nil, "finished", nil, nil ],
  [ 9, "Kiera", "Kylander-Johnson", "Duluth", "100431359", "4021", 2, "00:39:32.403", "00:19:07.723", "00:20:24.680", nil, nil, "finished", nil, nil ],
  [ 10, "Lily", "Wilcox", "St Cloud", "100393138", "4067", 2, "00:40:03.263", "00:19:07.786", "00:20:55.477", nil, nil, "finished", nil, nil ],
  [ 11, "Sienna", "Sams", "Hermantown-Proctor", "100460392", "4030", 2, "00:40:06.277", "00:19:43.116", "00:20:23.161", nil, nil, "finished", nil, nil ],
  [ 12, "Abigail", "Britz", "Wayzata Mountain Bike", "100389782", "4073", 2, "00:40:06.282", "00:19:47.265", "00:20:19.017", nil, nil, "finished", nil, nil ],
  [ 13, "Nora", "Hackensack", "St Cloud", "100430600", "4066", 2, "00:41:17.533", "00:20:09.897", "00:21:07.636", nil, nil, "finished", nil, nil ],
  [ 14, "Madison", "White", "Duluth", "100432143", "4085", 2, "00:42:04.652", "00:20:29.309", "00:21:35.343", nil, nil, "finished", nil, nil ],
  [ 15, "Abigail", "Thomes", "Brainerd HS", "100392848", "4009", 2, "00:42:11.236", "00:20:59.922", "00:21:11.314", nil, nil, "finished", nil, nil ],
  [ 16, "Anna", "Moors", "Northwest", "100433146", "4048", 2, "00:43:43.509", "00:21:12.860", "00:22:30.649", nil, nil, "finished", nil, nil ],
  [ 17, "Paige", "Worcester", "Duluth East HS", "100393201", "4084", 2, "00:46:00.914", "00:22:28.879", "00:23:32.035", nil, nil, "finished", nil, nil ],
  [ 18, "Rebecca", "Miller", "Wayzata Mountain Bike", "100391749", "4075", 2, "00:46:30.340", "00:22:45.171", "00:23:45.169", nil, nil, "finished", nil, nil ],
  [ 19, "Lara", "Mueller", "Bemidji", "100434585", "4081", 2, "00:47:39.458", "00:23:53.948", "00:23:45.510", nil, nil, "finished", nil, nil ],
  [ 20, "Georgey", "Herzberg", "Wayzata Mountain Bike", "100390839", "4074", 2, "00:49:46.784", "00:23:56.848", "00:25:49.936", nil, nil, "finished", nil, nil ],
  [ 21, "Jacobi", "Burmeister Pater", "Bemidji", "100488021", "4004", 2, "00:50:07.181", "00:23:59.824", "00:26:07.357", nil, nil, "finished", nil, nil ],
  [ 22, "Mialynn", "Metsa", "Rock Ridge", "100391717", "4060", 2, "00:50:13.020", "00:23:34.967", "00:26:38.053", nil, nil, "finished", nil, nil ],
  [ 23, "Finn", "Jorgensen", "Bemidji", "100391113", "4005", 2, "00:54:28.747", "00:26:30.248", "00:27:58.499", nil, nil, "finished", nil, nil ],
  [ 24, "Mya", "Weckman", "New Prague MS and HS", "100425915", "4047", 2, "00:58:38.653", "00:27:28.394", "00:31:10.259", nil, nil, "finished", nil, nil ],
  [ 25, "Sarah", "Biros", "Mounds View HS", "100405745", "4045", 2, "01:06:31.261", "00:32:04.164", "00:34:27.097", nil, nil, "finished", nil, nil ],
  [ 26, "Lillian", "Kainz", "Rock Ridge", "100427192", "4058", 2, "01:08:32.214", "00:32:09.795", "00:36:22.419", nil, nil, "finished", nil, nil ]
]

# JV2 Girls Results
results_jv2_girls = [
  [ 1, "Ainsley", "Mccollough", "Duluth East HS", "100485890", "2026", 2, "00:39:35.247", "00:19:13.079", "00:20:22.168", nil, nil, "finished", nil, nil ],
  [ 2, "Katerina", "Kostal", "Mounds View HS", "100391259", "2056", 2, "00:40:32.388", "00:19:57.938", "00:20:34.450", nil, nil, "finished", nil, nil ],
  [ 3, "Lacey", "Siira", "Alexandria Youth Cycling", "100419075", "2002", 2, "00:40:37.663", "00:19:50.201", "00:20:47.462", nil, nil, "finished", nil, nil ],
  [ 4, "Sophie", "Roark", "Rock Ridge", "100392342", "2083", 2, "00:41:09.727", "00:20:38.833", "00:20:30.894", nil, nil, "finished", nil, nil ],
  [ 5, "Addison", "Ridgeway", "New Prague MS and HS", "100420801", "2070", 2, "00:41:16.697", "00:20:33.125", "00:20:43.572", nil, nil, "finished", nil, nil ],
  [ 6, "Astrid", "Levy", "Duluth", "100391448", "2023", 2, "00:41:59.005", "00:20:04.305", "00:21:54.700", nil, nil, "finished", nil, nil ],
  [ 7, "Esther", "Wilcox", "St Cloud", "100393135", "2093", 2, "00:42:05.518", "00:20:56.013", "00:21:09.505", nil, nil, "finished", nil, nil ],
  [ 8, "Lucy", "Lewandowski", "Crosby-Ironton HS", "100485181", "2022", 2, "00:42:09.285", "00:21:00.709", "00:21:08.576", nil, nil, "finished", nil, nil ],
  [ 9, "Elizabeth", "Fackert", "Wayzata Mountain Bike", "100390334", "2108", 2, "00:42:14.024", "00:21:00.677", "00:21:13.347", nil, nil, "finished", nil, nil ],
  [ 10, "Chelsea", "Halvorson", "Hopkins HS", "100429267", "2034", 2, "00:43:07.410", "00:21:11.844", "00:21:55.566", nil, nil, "finished", nil, nil ],
  [ 11, "Althea", "Sharland", "Duluth East HS", "100485578", "2027", 2, "00:43:34.224", "00:21:10.051", "00:22:24.173", nil, nil, "finished", nil, nil ],
  [ 12, "Kamdyn", "Karel", "Mounds View HS", "100405966", "2053", 2, "00:43:57.473", "00:21:15.818", "00:22:41.655", nil, nil, "finished", nil, nil ],
  [ 13, "Bree", "Torgerson", "Duluth", "100428592", "2024", 2, "00:44:22.324", "00:21:02.117", "00:23:20.207", nil, nil, "finished", nil, nil ],
  [ 14, "Mya", "Frank", "Brainerd HS", "100488587", "2014", 2, "00:44:41.667", "00:22:03.601", "00:22:38.066", nil, nil, "finished", nil, nil ],
  [ 15, "Kyra", "Bednarz", "Armstrong Cycle", "100389591", "2005", 2, "00:46:08.244", "00:22:28.092", "00:23:40.152", nil, nil, "finished", nil, nil ],
  [ 16, "River", "Galloway", "Rock Ridge", "100390489", "2080", 2, "00:46:40.359", "00:22:37.277", "00:24:03.082", nil, nil, "finished", nil, nil ],
  [ 17, "Beatrice", "Javaherian", "Duluth East HS", "100429302", "2025", 2, "00:47:23.787", "00:23:07.329", "00:24:16.458", nil, nil, "finished", nil, nil ],
  [ 18, "Mckenna", "Karel", "Mounds View HS", "100461300", "2054", 2, "00:48:17.673", "00:23:44.905", "00:24:32.768", nil, nil, "finished", nil, nil ],
  [ 19, "Billie", "White", "Roseville", "100479736", "2086", 2, "00:48:40.227", "00:22:56.707", "00:25:43.520", nil, nil, "finished", nil, nil ],
  [ 20, "Olive", "Burres", "Bloomington Jefferson", "100389850", "2012", 2, "00:50:00.071", "00:24:04.478", "00:25:55.593", nil, nil, "finished", nil, nil ],
  [ 21, "Sadie", "Salo", "Prior Lake HS", "100392438", "2074", 2, "00:52:34.174", "00:24:06.528", "00:28:27.646", nil, nil, "finished", nil, nil ],
  [ 22, "Ariella", "Rosenwald", "Wayzata Mountain Bike", "100431384", "2109", 2, "00:52:47.067", "00:25:44.990", "00:27:02.077", nil, nil, "finished", nil, nil ],
  [ 23, "Cora", "Martensen", "Brainerd HS", "100391599", "2015", 2, "00:53:21.232", "00:24:32.021", "00:28:49.211", nil, nil, "finished", nil, nil ],
  [ 24, "Clara", "Niskanen", "Independent HS", "100489234", "2120", 2, "00:53:36.264", "00:26:15.252", "00:27:21.012", nil, nil, "finished", nil, nil ],
  [ 25, "Norah", "Kainz", "Rock Ridge", "100427190", "2081", 2, "01:03:30.304", "00:30:21.337", "00:33:08.967", nil, nil, "finished", nil, nil ],
  [ 26, "Apres", "Surla", "Rock Ridge", "100481520", "2084", 0, "", "", "", nil, nil, "DNF", nil, "Pulled by Ref - Placed last" ]
]

# JV3 Boys Results
results_jv3_boys = [
  [ 1, "Oden", "Olson", "Minnesota Valley", "100392020", "810", 3, "00:48:34.581", "00:16:52.170", "00:15:41.086", "00:16:01.325", nil, "finished", nil, nil ],
  [ 2, "Isaac", "Schwarz", "North Dakota Kindred", "100392557", "844", 3, "00:49:47.692", "00:16:52.668", "00:16:13.441", "00:16:41.583", nil, "finished", nil, nil ],
  [ 3, "Holden", "Zak", "St Cloud", "100393228", "894", 3, "00:50:19.822", "00:16:53.281", "00:16:40.457", "00:16:46.084", nil, "finished", nil, nil ],
  [ 4, "Cooper", "Craine", "Crosby-Ironton HS", "100390042", "749", 3, "00:50:27.804", "00:16:56.911", "00:16:46.287", "00:16:44.606", nil, "finished", nil, nil ],
  [ 5, "Owen", "Rogholt", "St Cloud", "100392366", "893", 3, "00:50:42.338", "00:16:58.665", "00:16:44.528", "00:16:59.145", nil, "finished", nil, nil ],
  [ 6, "Finn", "Nelson", "Crosby-Ironton HS", "100429637", "752", 3, "00:50:57.778", "00:17:01.271", "00:16:42.562", "00:17:13.945", nil, "finished", nil, nil ],
  [ 7, "Sam", "Galloway", "Wayzata Mountain Bike", "100390487", "921", 3, "00:50:58.291", "00:16:57.481", "00:16:52.759", "00:17:08.051", nil, "finished", nil, nil ],
  [ 8, "Carson", "Stenger", "New Prague MS and HS", "100392736", "847", 3, "00:51:12.406", "00:17:02.495", "00:16:48.793", "00:17:21.118", nil, "finished", nil, nil ],
  [ 9, "Parker", "Converse", "Alexandria Youth Cycling", "100390013", "703", 3, "00:51:12.427", "00:17:10.000", "00:16:59.846", "00:17:02.581", nil, "finished", nil, nil ],
  [ 10, "Sam", "Anderson", "Wayzata Mountain Bike", "100389457", "918", 3, "00:51:13.924", "00:16:57.477", "00:17:03.826", "00:17:12.621", nil, "finished", nil, nil ],
  [ 11, "Andrew", "Roloff", "Mounds View HS", "100392371", "822", 3, "00:51:31.444", "00:17:03.655", "00:17:09.752", "00:17:18.037", nil, "finished", nil, nil ],
  [ 12, "Garrett", "Tobias", "New Prague MS and HS", "100426799", "849", 3, "00:51:38.236", "00:17:04.202", "00:17:14.511", "00:17:19.523", nil, "finished", nil, nil ],
  [ 13, "Carson", "Rajkowski", "Duluth East HS", "100472972", "955", 3, "00:52:10.041", "00:16:53.286", "00:17:52.857", "00:17:23.898", nil, "finished", nil, nil ],
  [ 14, "Owen", "Vandal", "Duluth", "100392969", "755", 3, "00:52:10.045", "00:16:52.647", "00:17:29.226", "00:17:48.172", nil, "finished", nil, nil ],
  [ 15, "Allen", "Ormsbee", "Wayzata Mountain Bike", "100431457", "925", 3, "00:52:11.729", "00:17:39.137", "00:17:15.168", "00:17:17.424", nil, "finished", nil, nil ],
  [ 16, "Jacob", "Herness", "Wayzata Mountain Bike", "100430362", "922", 3, "00:52:11.743", "00:17:08.611", "00:17:23.793", "00:17:39.339", nil, "finished", nil, nil ],
  [ 17, "Bishop", "Noetzel", "Brainerd HS", "100391937", "725", 3, "00:52:14.612", "00:16:59.693", "00:17:14.872", "00:18:00.047", nil, "finished", nil, nil ],
  [ 18, "Oskar", "Nelson", "Crosby-Ironton HS", "100429635", "753", 3, "00:52:58.684", "00:16:53.277", "00:16:41.439", "00:19:23.968", nil, "finished", nil, nil ],
  [ 19, "Braden", "Erdahl", "Prior Lake HS", "100390297", "863", 3, "00:52:59.489", "00:17:15.747", "00:17:43.541", "00:18:00.201", nil, "finished", nil, nil ],
  [ 20, "Kellan", "Orourke", "Armstrong Cycle", "100428742", "716", 3, "00:53:10.335", "00:17:23.506", "00:18:24.843", "00:17:21.986", nil, "finished", nil, nil ],
  [ 21, "Jaret", "Soxman", "Brainerd HS", "100392691", "727", 3, "00:53:19.054", "00:17:45.687", "00:17:43.602", "00:17:49.765", nil, "finished", nil, nil ],
  [ 22, "Jack", "Liiste", "Totino Grace-Irondale", "100391465", "954", 3, "00:53:22.876", "00:17:05.757", "00:17:55.918", "00:18:21.201", nil, "finished", nil, nil ],
  [ 23, "Will", "Breuing", "Wayzata Mountain Bike", "100389778", "919", 3, "00:53:27.812", "00:17:09.315", "00:18:16.367", "00:18:02.130", nil, "finished", nil, nil ],
  [ 24, "Jayden", "Johnson", "Cloquet-Esko-Carlton", "100407213", "747", 3, "00:53:42.406", "00:17:49.491", "00:18:04.969", "00:17:47.946", nil, "finished", nil, nil ],
  [ 25, "Zach", "Fahey", "Minnesota Valley", "100390336", "809", 3, "00:53:48.040", "00:17:23.072", "00:18:26.930", "00:17:58.038", nil, "finished", nil, nil ],
  [ 26, "Gabriel", "Javaherian", "Duluth East HS", "100432402", "951", 3, "00:53:48.594", "00:17:02.491", "00:18:22.847", "00:18:23.256", nil, "finished", nil, nil ],
  [ 27, "Griffin", "Lampe", "Hopkins HS", "100391347", "782", 3, "00:53:51.191", "00:17:10.465", "00:18:17.807", "00:18:22.919", nil, "finished", nil, nil ],
  [ 28, "Tanner", "Long", "Prior Lake HS", "100391502", "869", 3, "00:53:51.191", "00:17:39.714", "00:18:11.340", "00:18:00.137", nil, "finished", nil, nil ],
  [ 29, "John", "Maines", "Prior Lake HS", "100391553", "870", 3, "00:54:13.112", "00:17:43.605", "00:18:10.821", "00:18:18.686", nil, "finished", nil, nil ],
  [ 30, "Jeremiah", "Stuber", "New Prague MS and HS", "100392774", "848", 3, "00:54:17.097", "00:17:39.812", "00:18:22.783", "00:18:14.502", nil, "finished", nil, nil ],
  [ 31, "Drake", "Wetherill", "Mounds View HS", "100393105", "823", 3, "00:54:17.098", "00:17:46.266", "00:18:10.090", "00:18:20.742", nil, "finished", nil, nil ],
  [ 32, "Jacob", "Nicholson", "Northwest", "100391918", "850", 3, "00:54:17.143", "00:17:22.033", "00:18:30.706", "00:18:24.404", nil, "finished", nil, nil ],
  [ 33, "Mason", "Horter", "Prior Lake HS", "100390929", "868", 3, "00:54:18.058", "00:17:47.990", "00:18:10.644", "00:18:19.424", nil, "finished", nil, nil ],
  [ 34, "Quinn", "Spohn", "Duluth", "100428923", "754", 3, "00:54:30.108", "00:17:10.983", "00:18:23.313", "00:18:55.812", nil, "finished", nil, nil ],
  [ 35, "Brody", "Parmer", "North Dakota", "100392073", "842", 3, "00:54:54.116", "00:17:43.601", "00:18:13.383", "00:18:57.132", nil, "finished", nil, nil ],
  [ 36, "Tyler", "Siira", "Alexandria Youth Cycling", "100419077", "707", 3, "00:55:02.159", "00:17:15.719", "00:18:34.790", "00:19:11.650", nil, "finished", nil, nil ],
  [ 37, "Arron", "Lockwood", "Brainerd HS", "100391488", "724", 3, "00:55:14.208", "00:17:50.176", "00:18:44.376", "00:18:39.656", nil, "finished", nil, nil ],
  [ 38, "Samuel", "Dahn", "New Prague MS and HS", "100390076", "845", 3, "00:55:32.971", "00:17:39.796", "00:18:48.760", "00:19:04.415", nil, "finished", nil, nil ],
  [ 39, "Seth", "Hein", "North Dakota", "100390793", "841", 3, "00:56:01.724", "00:17:04.837", "00:18:56.495", "00:20:00.392", nil, "finished", nil, nil ],
  [ 40, "Treffen", "Spore", "Armstrong Cycle", "100428902", "718", 3, "00:56:12.419", "00:17:47.500", "00:18:54.888", "00:19:30.031", nil, "finished", nil, nil ],
  [ 41, "Andrew", "Hackenmueller", "St Cloud", "100431795", "892", 3, "00:56:25.032", "00:17:50.630", "00:19:14.539", "00:19:19.863", nil, "finished", nil, nil ],
  [ 42, "Rukshan", "Rajan", "Wayzata Mountain Bike", "100392259", "926", 3, "00:56:28.331", "00:17:59.870", "00:19:08.071", "00:19:20.390", nil, "finished", nil, nil ],
  [ 43, "Spencer", "Hollenhorst", "Crosby-Ironton HS", "100390893", "750", 3, "00:56:31.366", "00:18:17.309", "00:19:14.359", "00:18:59.698", nil, "finished", nil, nil ],
  [ 44, "Samuel", "Beukema", "Rock Ridge", "100389648", "884", 3, "00:56:36.170", "00:17:50.241", "00:19:31.609", "00:19:14.320", nil, "finished", nil, nil ],
  [ 45, "William", "Heston", "Bloomington Jefferson", "100390844", "723", 3, "00:57:17.876", "00:17:55.817", "00:19:37.177", "00:19:44.882", nil, "finished", nil, nil ],
  [ 46, "Charlie", "Diaz", "Armstrong Cycle", "100390152", "710", 3, "00:57:18.799", "00:17:58.357", "00:19:54.322", "00:19:26.120", nil, "finished", nil, nil ],
  [ 47, "Cameron", "Usher", "Alexandria Youth Cycling", "100428655", "708", 3, "00:57:27.242", "00:18:40.810", "00:19:36.681", "00:19:09.751", nil, "finished", nil, nil ],
  [ 48, "Jacob", "Kilian", "New Prague MS and HS", "100391188", "846", 3, "00:57:41.207", "00:18:28.471", "00:19:53.048", "00:19:19.688", nil, "finished", nil, nil ],
  [ 49, "Treston", "Hughes", "Alexandria Youth Cycling", "100390946", "705", 3, "00:58:10.247", "00:18:35.563", "00:19:53.909", "00:19:40.775", nil, "finished", nil, nil ],
  [ 50, "Aj", "Herzberg", "Wayzata Mountain Bike", "100390838", "923", 3, "00:58:16.480", "00:19:17.230", "00:19:28.336", "00:19:30.914", nil, "finished", nil, nil ],
  [ 51, "Tristan", "Ehn", "Armstrong Cycle", "100427928", "711", 3, "00:58:17.653", "00:18:54.002", "00:19:38.876", "00:19:44.775", nil, "finished", nil, nil ],
  [ 52, "Pj", "O'Shea", "Hopkins HS", "100392046", "784", 3, "00:58:32.542", "00:17:56.917", "00:20:30.665", "00:20:04.960", nil, "finished", nil, nil ],
  [ 53, "Shea", "Becker", "Hopkins HS", "100427336", "777", 3, "00:59:18.043", "00:18:40.814", "00:20:06.934", "00:20:30.295", nil, "finished", nil, nil ],
  [ 54, "Jack", "Guggenheimer", "Hopkins HS", "100390625", "779", 3, "00:59:19.931", "00:19:21.049", "00:20:06.527", "00:19:52.355", nil, "finished", nil, nil ],
  [ 55, "Owen", "Anderson", "Alexandria Youth Cycling", "100424931", "701", 3, "00:59:24.436", "00:18:57.669", "00:21:06.061", "00:19:20.706", nil, "finished", nil, nil ],
  [ 56, "Benjamin", "Fricke", "Armstrong Cycle", "100390449", "712", 3, "00:59:32.056", "00:18:53.508", "00:20:41.430", "00:19:57.118", nil, "finished", nil, nil ],
  [ 57, "Howie", "Lind", "West Range", "100391469", "928", 3, "00:59:40.910", "00:18:56.926", "00:21:06.707", "00:19:37.277", nil, "finished", nil, nil ],
  [ 58, "Seth", "Almanaseer", "North Dakota", "100389421", "839", 3, "01:00:30.205", "00:18:15.506", "00:21:05.870", "00:21:08.829", nil, "finished", nil, nil ],
  [ 59, "Enoch", "Anderson", "Crosby-Ironton HS", "100389447", "748", 3, "01:00:37.866", "00:19:17.996", "00:19:34.614", "00:21:45.256", nil, "finished", nil, nil ],
  [ 60, "Rex", "Walli", "West Range", "100393038", "929", 3, "01:01:20.061", "00:18:56.921", "00:21:08.762", "00:21:14.378", nil, "finished", nil, nil ],
  [ 61, "Jameson", "Kubitschek-Myers", "Armstrong Cycle", "100391301", "715", 3, "01:02:24.417", "00:19:26.087", "00:21:38.244", "00:21:20.086", nil, "finished", nil, nil ],
  [ 62, "Justin", "Johnson", "Armstrong Cycle", "100391074", "714", 3, "01:02:39.015", "00:19:27.646", "00:21:52.891", "00:21:18.478", nil, "finished", nil, nil ],
  [ 63, "Noah", "Sauvageau", "North Dakota Kindred", "100392461", "843", 3, "01:04:32.685", "00:20:37.363", "00:21:48.413", "00:22:06.909", nil, "finished", nil, nil ],
  [ 64, "Elliot", "Meents", "Hopkins HS", "100391697", "783", 3, "01:04:38.109", "00:19:21.556", "00:22:57.381", "00:22:19.172", nil, "finished", nil, nil ],
  [ 65, "Broden", "Percival", "Prior Lake HS", "100392132", "872", 3, "01:04:49.366", "00:19:28.366", "00:22:55.000", "00:22:26.000", nil, "finished", nil, nil ],
  [ 66, "Ravonte", "Kriegler", "Hopkins HS", "100432256", "781", 3, "01:05:01.153", "00:16:55.881", "00:17:59.106", "00:30:06.166", nil, "finished", nil, nil ],
  [ 67, "Jobe", "Glashagel", "Prior Lake HS", "100419186", "867", 3, "01:05:21.985", "00:19:52.770", "00:20:21.746", "00:25:07.469", nil, "finished", nil, nil ],
  [ 68, "Charlie", "Boese", "North Dakota", "100389707", "840", 3, "01:06:26.667", "00:20:33.119", "00:21:48.192", "00:24:05.356", nil, "finished", nil, nil ],
  [ 69, "Sawyer", "Filipiak", "Alexandria Youth Cycling", "100431032", "704", 3, "01:08:07.954", "00:20:42.791", "00:19:10.033", "00:18:15.130", nil, "finished", "10 Min", "Bike Swap" ],
  [ 70, "Mason", "Schaefer", "Armstrong Cycle", "100392469", "717", 3, "01:13:04.279", "00:20:20.413", "00:21:57.522", "00:20:46.344", nil, "finished", "10 Min", "Bike Swap" ],
  [ 71, "Max", "Patrick-Dropik", "Alexandria Youth Cycling", "100392087", "706", 1, "00:17:44.975", "00:17:44.975", "", "", nil, "DNF", nil, nil ],
  [ 72, "Hayden", "Patton", "Brainerd HS", "100392092", "726", 1, "00:18:17.858", "00:18:17.858", "", "", nil, "DNF", nil, nil ]
]

# Varsity Boys Results
results_varsity_boys = [
  [ 1, "Aidan", "Rosemeier", "New Prague MS and HS", "100392384", "250", 4, "01:02:02.250", "00:15:01.477", "00:15:24.439", "00:15:36.704", "00:15:59.630", "finished", nil, nil ],
  [ 2, "Gavin", "Mayhew", "Bloomington Jefferson", "100391635", "210", 4, "01:02:02.700", "00:15:01.473", "00:15:24.447", "00:15:37.156", "00:15:59.624", "finished", nil, nil ],
  [ 3, "Alex", "Krawza", "Prior Lake HS", "100391266", "256", 4, "01:02:22.357", "00:15:12.971", "00:15:45.838", "00:15:51.149", "00:15:32.399", "finished", nil, nil ],
  [ 4, "Tegan", "Moore", "Prior Lake HS", "100391809", "259", 4, "01:02:50.029", "00:15:12.476", "00:15:47.351", "00:15:52.590", "00:15:57.612", "finished", nil, nil ],
  [ 5, "Max", "Fahrmann", "Bloomington Jefferson", "100390339", "208", 4, "01:02:50.140", "00:15:06.842", "00:15:52.429", "00:15:51.757", "00:15:59.112", "finished", nil, nil ],
  [ 6, "Corban", "Carlson", "Mounds View HS", "100409178", "282", 4, "01:04:50.135", "00:15:32.728", "00:16:24.124", "00:16:29.031", "00:16:24.252", "finished", nil, nil ],
  [ 7, "Ethan", "Lindgren", "Cloquet-Esko-Carlton", "100391471", "218", 4, "01:04:59.980", "00:16:09.866", "00:16:38.214", "00:16:07.905", "00:16:03.995", "finished", nil, nil ],
  [ 8, "Oliver", "Toftness", "Crosby-Ironton HS", "100392889", "221", 4, "01:05:01.219", "00:15:52.132", "00:16:33.488", "00:16:30.900", "00:16:04.699", "finished", nil, nil ],
  [ 9, "Reed", "Kuzel", "Bemidji", "100391321", "206", 4, "01:05:12.250", "00:15:22.126", "00:16:39.090", "00:16:30.651", "00:16:40.383", "finished", nil, nil ],
  [ 10, "Antonin", "Kostal", "Mounds View HS", "100391258", "241", 4, "01:05:20.716", "00:16:16.120", "00:16:33.292", "00:16:13.912", "00:16:17.392", "finished", nil, nil ],
  [ 11, "Colton", "Dewey", "Cloquet-Esko-Carlton", "100390150", "216", 4, "01:05:49.497", "00:16:23.233", "00:16:33.183", "00:16:08.023", "00:16:45.058", "finished", nil, nil ],
  [ 12, "Jacob T", "Olson", "Northwest", "100392016", "252", 4, "01:06:15.277", "00:15:30.121", "00:16:34.960", "00:17:16.394", "00:16:53.802", "finished", nil, nil ],
  [ 13, "Ethan", "Ishaug", "Bloomington Jefferson", "100429063", "209", 4, "01:06:48.987", "00:16:21.390", "00:16:51.946", "00:17:09.269", "00:16:26.382", "finished", nil, nil ],
  [ 14, "Oscar", "Tix", "Hopkins HS", "100392880", "236", 4, "01:06:51.889", "00:16:23.708", "00:16:34.399", "00:16:50.254", "00:17:03.528", "finished", nil, nil ],
  [ 15, "Colin", "Mcshane", "Duluth East HS", "100391688", "224", 4, "01:07:23.257", "00:16:25.243", "00:17:02.163", "00:16:52.938", "00:17:02.913", "finished", nil, nil ],
  [ 16, "Will", "Copps", "Hopkins HS", "100428054", "280", 4, "01:07:52.637", "00:16:24.574", "00:16:55.324", "00:17:11.367", "00:17:21.372", "finished", nil, nil ],
  [ 17, "Jon", "Maroney", "Crosby-Ironton HS", "100391592", "281", 4, "01:07:58.426", "00:16:29.786", "00:16:58.724", "00:17:04.868", "00:17:25.048", "finished", nil, nil ],
  [ 18, "Robert", "Mccroskey", "Prior Lake HS", "100391653", "257", 4, "01:08:13.105", "00:16:29.782", "00:17:14.689", "00:17:21.800", "00:17:06.834", "finished", nil, nil ],
  [ 19, "Carl", "Morse", "Duluth East HS", "100431756", "225", 4, "01:08:18.243", "00:16:10.427", "00:17:12.243", "00:17:09.379", "00:17:46.194", "finished", nil, nil ],
  [ 20, "Daniel", "Ridgeway Jr.", "New Prague MS and HS", "100420800", "249", 4, "01:08:22.783", "00:16:17.628", "00:17:13.438", "00:17:29.245", "00:17:22.472", "finished", nil, nil ],
  [ 21, "Bodee", "Mcfadden", "Duluth", "100391659", "223", 4, "01:08:31.757", "00:16:18.157", "00:17:13.885", "00:17:29.369", "00:17:30.346", "finished", nil, nil ],
  [ 22, "Max", "Foster", "Cloquet-Esko-Carlton", "100390409", "217", 4, "01:08:32.863", "00:16:08.877", "00:16:39.780", "00:17:36.580", "00:18:07.626", "finished", nil, nil ],
  [ 23, "Simon", "Bjerketvedt", "Hopkins HS", "100389678", "235", 4, "01:08:36.609", "00:16:09.849", "00:17:00.884", "00:17:35.084", "00:17:50.792", "finished", nil, nil ],
  [ 24, "Lukas", "Robinson", "North Dakota", "100392353", "247", 4, "01:08:41.583", "00:16:21.351", "00:17:09.407", "00:17:30.059", "00:17:40.766", "finished", nil, nil ],
  [ 25, "Samuel", "Coughlin", "Crosby-Ironton HS", "100390039", "220", 4, "01:09:10.738", "00:16:23.713", "00:17:09.259", "00:17:38.638", "00:17:59.128", "finished", nil, nil ],
  [ 26, "Tyler", "Fath", "Alexandria Youth Cycling", "100390344", "202", 4, "01:10:01.922", "00:16:44.577", "00:17:31.130", "00:17:53.772", "00:17:52.443", "finished", nil, nil ],
  [ 27, "Hayden", "Leiseth", "Northwest", "100391420", "251", 4, "01:10:51.107", "00:16:22.071", "00:17:13.679", "00:18:03.696", "00:19:11.661", "finished", nil, nil ],
  [ 28, "Keegan", "Ghani", "Armstrong Cycle", "100390536", "205", 4, "01:11:07.723", "00:16:50.115", "00:18:18.570", "00:18:18.275", "00:17:40.763", "finished", nil, nil ],
  [ 29, "Maxwell", "Chinn", "Alexandria Youth Cycling", "100389940", "278", 4, "01:11:33.569", "00:17:12.534", "00:17:49.093", "00:18:17.426", "00:18:14.516", "finished", nil, nil ],
  [ 30, "Rye", "Truitt", "Duluth East HS", "100392923", "226", 4, "01:12:21.023", "00:16:23.177", "00:17:59.560", "00:18:37.770", "00:19:20.516", "finished", nil, nil ],
  [ 31, "Hayden", "Hagen", "Brainerd HS", "100390659", "211", 4, "01:12:53.741", "00:16:22.061", "00:16:59.751", "00:17:16.618", "00:22:15.311", "finished", nil, nil ],
  [ 32, "Hayden", "Backowski", "Crosby-Ironton HS", "100389516", "219", 4, "01:19:37.835", "00:18:31.845", "00:19:17.897", "00:20:12.455", "00:21:35.638", "finished", nil, nil ],
  [ 33, "Henry", "Rausch", "Roseville", "100428256", "265", 4, "01:37:38.346", "00:23:44.952", "00:21:43.536", "00:21:07.542", "00:21:02.316", "finished", "10 Min", "Bike Swap" ],
  [ 34, "Luke", "Walsh", "Alexandria Youth Cycling", "100393041", "204", 2, "00:32:26.332", "00:15:52.136", "00:16:34.196", "", "", "DNF", nil, nil ],
  [ 35, "Elijah", "Schwarz", "North Dakota Kindred", "100392556", "248", 1, "00:16:09.397", "00:16:09.397", "", "", "", "DNF", nil, nil ]
]

# JV3 Girls Results
results_jv3_girls = [
  [ 1, "Esme", "Needham", "Mounds View HS", "100391870", "421", 3, "00:57:44.740", "00:19:08.755", "00:19:17.373", "00:19:18.612", nil, "finished", nil, nil ],
  [ 2, "Annabelle", "Tautges", "St Cloud", "100433886", "450", 3, "00:57:45.211", "00:19:26.341", "00:19:16.857", "00:19:02.013", nil, "finished", nil, nil ],
  [ 3, "Lila", "Golomb", "Wayzata Mountain Bike", "100390568", "439", 3, "00:58:00.910", "00:19:08.752", "00:19:20.181", "00:19:31.977", nil, "finished", nil, nil ],
  [ 4, "Ashley", "Schultz", "Northwest", "100462375", "428", 3, "00:58:02.409", "00:19:11.772", "00:19:17.157", "00:19:33.480", nil, "finished", nil, nil ],
  [ 5, "Isabelle", "Mayer", "Hopkins HS", "100391634", "415", 3, "00:58:25.810", "00:19:09.710", "00:19:17.502", "00:19:58.598", nil, "finished", nil, nil ],
  [ 6, "Josephine", "Ryan", "Duluth East HS", "100392416", "411", 3, "00:58:56.653", "00:19:09.320", "00:19:43.507", "00:20:03.826", nil, "finished", nil, nil ],
  [ 7, "Faye", "Calvert", "Bemidji", "100426764", "443", 3, "00:59:00.959", "00:19:13.687", "00:19:48.565", "00:19:58.707", nil, "finished", nil, nil ],
  [ 8, "Sarah", "Rich", "Prior Lake HS", "100392307", "431", 3, "01:01:39.822", "00:20:26.749", "00:20:08.282", "00:21:04.791", nil, "finished", nil, nil ],
  [ 9, "Stella", "Hagen", "Brainerd HS", "100390660", "403", 3, "01:02:19.474", "00:20:28.863", "00:21:03.771", "00:20:46.840", nil, "finished", nil, nil ],
  [ 10, "Lexi", "Halvorson", "Wayzata Mountain Bike", "100422289", "440", 3, "01:02:20.515", "00:20:27.859", "00:21:07.773", "00:20:44.883", nil, "finished", nil, nil ],
  [ 11, "Megan", "Swanson", "Armstrong Cycle", "100392795", "401", 3, "01:04:00.235", "00:20:28.575", "00:21:10.524", "00:22:21.136", nil, "finished", nil, nil ],
  [ 12, "Wrenna", "Galloway", "Rock Ridge", "100390490", "433", 3, "01:04:06.452", "00:20:28.708", "00:21:22.800", "00:22:14.944", nil, "finished", nil, nil ],
  [ 13, "Ava", "Johnson", "Crosby-Ironton HS", "100391042", "408", 3, "01:06:43.628", "00:20:35.925", "00:22:56.522", "00:23:11.181", nil, "finished", nil, nil ],
  [ 14, "Isabelle", "Smith", "Brainerd HS", "100429090", "404", 3, "01:07:27.081", "00:21:59.226", "00:22:17.996", "00:23:09.859", nil, "finished", nil, nil ],
  [ 15, "Aleah", "Lindgren", "Cloquet-Esko-Carlton", "100391470", "407", 3, "01:08:52.953", "00:21:58.589", "00:22:51.887", "00:24:02.477", nil, "finished", nil, nil ],
  [ 16, "Roslyn", "Hartley", "Duluth East HS", "100390735", "410", 3, "01:09:34.952", "00:21:57.912", "00:23:51.431", "00:23:45.609", nil, "finished", nil, nil ],
  [ 17, "Hayden", "Mielke", "Hopkins HS", "100391736", "444", 0, "", "", "", "", nil, "DNF", nil, nil ],
  [ 18, "Jenna", "Pettes", "Prior Lake HS", "100392168", "430", 0, "", "", "", "", nil, "DNF", nil, nil ]
]

# Varsity Girls Results
results_varsity_girls = [
  [ 1, "Phoebe", "Leege", "Duluth East HS", "100391414", "11", 4, "01:11:38.036", "00:18:19.830", "00:17:55.469", "00:17:14.073", "00:18:08.664", "finished", nil, nil ],
  [ 2, "Caroline", "Haag", "Bloomington Jefferson", "100390645", "2", 4, "01:13:43.317", "00:18:19.922", "00:17:56.863", "00:18:39.132", "00:18:47.400", "finished", nil, nil ],
  [ 3, "Layla", "Hagelin", "Independent HS", "100390657", "15", 4, "01:15:18.863", "00:18:19.891", "00:18:20.906", "00:19:25.900", "00:19:12.166", "finished", nil, nil ],
  [ 4, "Madeline", "Dornfeld", "Mounds View HS", "100390197", "27", 4, "01:15:51.719", "00:18:19.860", "00:18:41.584", "00:19:30.881", "00:19:19.394", "finished", nil, nil ],
  [ 5, "Charli", "Worcester", "Duluth East HS", "100393202", "25", 4, "01:16:10.596", "00:18:46.020", "00:19:03.582", "00:19:08.437", "00:19:12.557", "finished", nil, nil ],
  [ 6, "Thea", "Kramer", "Duluth East HS", "100391263", "10", 4, "01:16:28.338", "00:18:20.546", "00:19:01.526", "00:19:36.423", "00:19:29.843", "finished", nil, nil ],
  [ 7, "Megan", "Schrooten", "Bloomington Jefferson", "100392532", "3", 4, "01:16:29.080", "00:18:46.412", "00:19:02.435", "00:19:08.392", "00:19:31.841", "finished", nil, nil ],
  [ 8, "Tiahna", "Goeke", "Alexandria Youth Cycling", "100390558", "1", 4, "01:19:06.261", "00:18:46.704", "00:19:31.639", "00:20:24.878", "00:20:23.040", "finished", nil, nil ],
  [ 9, "Ella", "Dols", "St Cloud", "100390193", "21", 4, "01:19:52.279", "00:18:57.951", "00:20:14.188", "00:20:38.443", "00:20:01.697", "finished", nil, nil ],
  [ 10, "Leah", "Coleman", "Duluth East HS", "100389992", "8", 4, "01:19:57.473", "00:18:58.555", "00:20:14.318", "00:20:38.920", "00:20:05.680", "finished", nil, nil ],
  [ 11, "Michon", "Harju", "Duluth East HS", "100390718", "26", 4, "01:23:49.731", "00:20:46.777", "00:20:41.999", "00:21:13.157", "00:21:07.798", "finished", nil, nil ],
  [ 12, "Courtney", "Hislop", "Duluth East HS", "100390864", "9", 4, "01:25:54.241", "00:19:59.881", "00:23:15.835", "00:21:56.823", "00:20:41.702", "finished", nil, nil ],
  [ 13, "Jadah", "Kelly", "North Dakota", "100391156", "19", 4, "01:25:59.427", "00:20:48.083", "00:22:10.299", "00:22:20.740", "00:20:40.305", "finished", nil, nil ],
  [ 14, "Courtney", "Weber", "Hopkins HS", "100393069", "14", 1, "00:18:46.121", "00:18:46.121", "", "", "", "DNF", nil, nil ]
]

# JV2 Boys D2 Results
results_jv2_boys_d2 = [
  [ 1, "Ladd", "Nelson", "Crosby-Ironton HS", "100429640", "2409", 2, "00:33:51.759", "00:17:01.742", "00:16:50.017", nil, nil, "finished", nil, nil ],
  [ 2, "Carson", "Kronlund", "Cloquet-Esko-Carlton", "100391281", "2405", 2, "00:34:26.342", "00:17:04.613", "00:17:21.729", nil, nil, "finished", nil, nil ],
  [ 3, "Gabe", "Lindstrom", "Northwest", "100426536", "2652", 2, "00:34:40.473", "00:17:05.300", "00:17:35.173", nil, nil, "finished", nil, nil ],
  [ 4, "Aiden", "True", "Cloquet-Esko-Carlton", "100392921", "2407", 2, "00:34:41.177", "00:17:04.532", "00:17:36.645", nil, nil, "finished", nil, nil ],
  [ 5, "Ayden", "Chopskie", "Cloquet-Esko-Carlton", "100389945", "2404", 2, "00:34:42.533", "00:17:04.501", "00:17:38.032", nil, nil, "finished", nil, nil ],
  [ 6, "Alexander", "Klinnert", "Northwest", "100431778", "2650", 2, "00:34:53.309", "00:17:05.296", "00:17:48.013", nil, nil, "finished", nil, nil ],
  [ 7, "Joe", "Jensen", "Northwest", "100391029", "2649", 2, "00:35:11.929", "00:17:04.159", "00:18:07.770", nil, nil, "finished", nil, nil ],
  [ 8, "Tucker", "Pederson", "Crosby-Ironton HS", "100392114", "2410", 2, "00:35:51.309", "00:17:35.147", "00:18:16.162", nil, nil, "finished", nil, nil ],
  [ 9, "Dylan", "Schmidt", "Duluth", "100489228", "2414", 2, "00:35:52.090", "00:17:33.139", "00:18:18.951", nil, nil, "finished", nil, nil ],
  [ 10, "Braydon", "Mckibbon", "Cloquet-Esko-Carlton", "100391671", "2406", 2, "00:35:56.658", "00:16:51.536", "00:19:05.122", nil, nil, "finished", nil, nil ],
  [ 11, "Brevik", "Brown", "Tioga Trailblazers", "100427947", "2816", 2, "00:36:45.060", "00:18:29.321", "00:18:15.739", nil, nil, "finished", nil, nil ],
  [ 12, "Jonah", "Ricard", "St Cloud", "100392305", "2768", 2, "00:36:45.900", "00:18:17.122", "00:18:28.778", nil, nil, "finished", nil, nil ],
  [ 13, "Tommy", "Fosse", "Northwest", "100390406", "2647", 2, "00:36:48.429", "00:18:24.030", "00:18:24.399", nil, nil, "finished", nil, nil ],
  [ 14, "Max", "Connelly", "Tioga Trailblazers", "100390002", "2817", 2, "00:36:51.053", "00:18:12.486", "00:18:38.567", nil, nil, "finished", nil, nil ],
  [ 15, "Ben", "Schroeder", "Tioga Trailblazers", "100406383", "2819", 2, "00:36:52.047", "00:18:16.558", "00:18:35.489", nil, nil, "finished", nil, nil ],
  [ 16, "Jack", "Squires", "Bloomington", "100425641", "2339", 2, "00:36:53.021", "00:18:23.947", "00:18:29.074", nil, nil, "finished", nil, nil ],
  [ 17, "Eli", "Cherne", "Tioga Trailblazers", "100389936", "2881", 2, "00:37:03.025", "00:18:17.127", "00:18:45.898", nil, nil, "finished", nil, nil ],
  [ 18, "Ari", "Greenberg", "North Dakota", "100390603", "2637", 2, "00:37:34.150", "00:18:19.251", "00:19:14.899", nil, nil, "finished", nil, nil ],
  [ 19, "Simon", "Englund", "Roseville", "100390293", "2743", 2, "00:38:22.659", "00:18:27.865", "00:19:54.794", nil, nil, "finished", nil, nil ],
  [ 20, "Keaton", "Sauvageau", "North Dakota Kindred", "100392460", "2640", 2, "00:38:22.692", "00:18:27.870", "00:19:54.822", nil, nil, "finished", nil, nil ],
  [ 21, "Jack", "Hildenbrand", "Bemidji", "100486264", "2332", 2, "00:38:32.267", "00:18:57.892", "00:19:34.375", nil, nil, "finished", nil, nil ],
  [ 22, "Max", "Zorman", "Bemidji", "100488385", "2335", 2, "00:38:42.142", "00:18:59.486", "00:19:42.656", nil, nil, "finished", nil, nil ],
  [ 23, "Elijah", "Lane", "Tioga Trailblazers", "100430909", "2818", 2, "00:38:54.360", "00:18:57.266", "00:19:57.094", nil, nil, "finished", nil, nil ],
  [ 24, "Willem", "Nibbelink", "Roseville", "100391909", "2744", 2, "00:39:23.839", "00:19:41.742", "00:19:42.097", nil, nil, "finished", nil, nil ],
  [ 25, "Deacon", "French", "Crosby-Ironton HS", "100390433", "2408", 2, "00:39:33.708", "00:18:53.580", "00:20:40.128", nil, nil, "finished", nil, nil ],
  [ 26, "Marcus", "Olson", "Northwest", "100392017", "2654", 2, "00:39:55.371", "00:19:35.789", "00:20:19.582", nil, nil, "finished", nil, nil ],
  [ 27, "Ezra", "Rude", "Duluth", "100487664", "2412", 2, "00:40:23.606", "00:19:40.165", "00:20:43.441", nil, nil, "finished", nil, nil ],
  [ 28, "Braden", "Thornburg", "Bloomington", "100392857", "2340", 2, "00:40:54.617", "00:19:27.979", "00:21:26.638", nil, nil, "finished", nil, nil ],
  [ 29, "Logan", "Spletzer", "Minnesota Valley", "100476940", "2547", 2, "00:40:55.206", "00:19:15.713", "00:21:39.493", nil, nil, "finished", nil, nil ],
  [ 30, "Timothy", "Gabbard", "Northwest", "100390476", "2648", 2, "00:40:55.234", "00:19:02.521", "00:21:52.713", nil, nil, "finished", nil, nil ],
  [ 31, "Benjamin", "Strickland", "Kerkhoven", "100427217", "2505", 2, "00:41:52.208", "00:19:59.346", "00:21:52.862", nil, nil, "finished", nil, nil ],
  [ 32, "Justin", "Rosenboom", "Kerkhoven", "100392387", "2504", 2, "00:41:57.630", "00:20:00.378", "00:21:57.252", nil, nil, "finished", nil, nil ],
  [ 33, "Rikelor", "Durston", "Roseville", "100435170", "2742", 2, "00:42:03.023", "00:20:41.330", "00:21:21.693", nil, nil, "finished", nil, nil ],
  [ 34, "Quin", "Peterson", "Kerkhoven", "100423976", "2503", 2, "00:42:25.115", "00:20:42.286", "00:21:42.829", nil, nil, "finished", nil, nil ],
  [ 35, "Ben", "Solem", "Tioga Trailblazers", "100392672", "2820", 2, "00:42:41.549", "00:21:01.205", "00:21:40.344", nil, nil, "finished", nil, nil ],
  [ 36, "Erik", "Olsen", "Kerkhoven", "100478801", "2502", 2, "00:42:58.800", "00:20:19.673", "00:22:39.127", nil, nil, "finished", nil, nil ],
  [ 37, "Charley", "Crowson", "Roseville", "100390051", "2740", 2, "00:44:13.567", "00:21:08.655", "00:23:04.912", nil, nil, "finished", nil, nil ],
  [ 38, "Lance", "Tabbert", "Tioga Trailblazers", "100392808", "2821", 2, "00:45:18.702", "00:22:22.903", "00:22:55.799", nil, nil, "finished", nil, nil ],
  [ 39, "Xander", "Vail", "Minnesota Valley", "100473718", "2548", 2, "00:45:24.074", "00:21:59.996", "00:23:24.078", nil, nil, "finished", nil, nil ],
  [ 40, "Carl", "Benson", "Kerkhoven", "100389615", "2501", 2, "00:47:39.616", "00:22:22.821", "00:25:16.795", nil, nil, "finished", nil, nil ],
  [ 41, "Philip", "Hodapp", "Bemidji", "100486254", "2333", 2, "00:47:56.909", "00:23:01.400", "00:24:55.509", nil, nil, "finished", nil, nil ],
  [ 42, "Isaiah", "Bucholz", "Minnesota Valley", "100483237", "2641", 2, "00:47:58.066", "00:23:22.317", "00:24:35.749", nil, nil, "finished", nil, nil ],
  [ 43, "Lukas", "Skinner", "Roseville", "100392629", "2745", 2, "00:50:20.569", "00:23:26.069", "00:26:54.500", nil, nil, "finished", nil, nil ],
  [ 44, "Cody", "Mendoza", "West Range", "100479942", "2843", 2, "00:57:07.778", "00:23:26.669", "00:28:41.109", nil, nil, "finished", "5 Min", "Outside Assistance" ]
]

# JV2 Boys D1 Results
results_jv2_boys_d1 = [
  [ 1, "Joseph", "Larson", "New Prague MS and HS", "100407084", "2644", 2, "00:33:30.037", "00:16:19.068", "00:17:10.969", nil, nil, "finished", nil, nil ],
  [ 2, "Haaken", "Dohse", "Hopkins HS", "100390182", "2483", 2, "00:34:44.334", "00:16:56.916", "00:17:47.418", nil, nil, "finished", nil, nil ],
  [ 3, "Mac", "Pedersen", "Bloomington Jefferson", "100392109", "2350", 2, "00:34:58.802", "00:17:00.584", "00:17:58.218", nil, nil, "finished", nil, nil ],
  [ 4, "Noah", "Mcclish", "Brainerd HS", "100391647", "2358", 2, "00:35:02.156", "00:17:22.114", "00:17:40.042", nil, nil, "finished", nil, nil ],
  [ 5, "Sullivan", "Rooney", "Alexandria Youth Cycling", "100411162", "2309", 2, "00:35:04.340", "00:17:23.868", "00:17:40.472", nil, nil, "finished", nil, nil ],
  [ 6, "Kellgren", "Jabs", "New Prague MS and HS", "100390989", "2643", 2, "00:35:06.647", "00:17:11.046", "00:17:55.601", nil, nil, "finished", nil, nil ],
  [ 7, "Kaden", "Baribeau", "Rock Ridge", "100412126", "2707", 2, "00:35:30.899", "00:17:35.674", "00:17:55.225", nil, nil, "finished", nil, nil ],
  [ 8, "Logan", "Ishaug", "Bloomington Jefferson", "100429066", "2344", 2, "00:35:55.445", "00:18:06.602", "00:17:48.843", nil, nil, "finished", nil, nil ],
  [ 9, "Silas", "Today", "Rock Ridge", "100392884", "2715", 2, "00:35:57.595", "00:17:23.434", "00:18:34.161", nil, nil, "finished", nil, nil ],
  [ 10, "Erik", "Rodewald", "Alexandria Youth Cycling", "100406990", "2308", 2, "00:36:53.949", "00:17:58.406", "00:18:55.543", nil, nil, "finished", nil, nil ],
  [ 11, "Rowan", "Schaefer", "Armstrong Cycle", "100392468", "2322", 2, "00:37:04.360", "00:17:59.242", "00:19:05.118", nil, nil, "finished", nil, nil ],
  [ 12, "Ben", "Tomczik", "Wayzata Mountain Bike", "100392894", "2839", 2, "00:37:14.778", "00:18:23.810", "00:18:50.968", nil, nil, "finished", nil, nil ],
  [ 13, "Silas", "Wright", "Brainerd HS", "100487081", "2360", 2, "00:37:15.834", "00:18:38.550", "00:18:37.284", nil, nil, "finished", nil, nil ],
  [ 14, "Nicholas", "Orr", "Wayzata Mountain Bike", "100478567", "2837", 2, "00:37:16.782", "00:18:11.779", "00:19:05.003", nil, nil, "finished", nil, nil ],
  [ 15, "Alden", "Knudson", "Rock Ridge", "100432637", "2713", 2, "00:37:17.353", "00:18:21.262", "00:18:56.091", nil, nil, "finished", nil, nil ],
  [ 16, "Benedict", "Swelstad", "Alexandria Youth Cycling", "100480623", "2312", 2, "00:37:41.180", "00:18:12.919", "00:19:28.261", nil, nil, "finished", nil, nil ],
  [ 17, "Harrison", "Voelkel", "Bloomington Jefferson", "100392998", "2354", 2, "00:37:41.288", "00:18:39.746", "00:19:01.542", nil, nil, "finished", nil, nil ],
  [ 18, "William", "Carberry", "Wayzata Mountain Bike", "100389884", "2828", 2, "00:37:51.488", "00:18:38.637", "00:19:12.851", nil, nil, "finished", nil, nil ],
  [ 19, "Christian", "Urness", "Alexandria Youth Cycling", "100392957", "2313", 2, "00:38:01.378", "00:18:39.406", "00:19:21.972", nil, nil, "finished", nil, nil ],
  [ 20, "Lucas", "Bakker", "Alexandria Youth Cycling", "100389530", "2302", 2, "00:38:27.537", "00:18:40.422", "00:19:47.115", nil, nil, "finished", nil, nil ],
  [ 21, "Corbin", "Johnson", "Hopkins HS", "100391055", "2487", 2, "00:38:28.704", "00:18:58.824", "00:19:29.880", nil, nil, "finished", nil, nil ],
  [ 22, "Aidan", "Katke", "Brainerd HS", "100428751", "2357", 2, "00:38:32.006", "00:18:43.426", "00:19:48.580", nil, nil, "finished", nil, nil ],
  [ 23, "Branden", "Moser", "Bloomington Jefferson", "100391835", "2349", 2, "00:38:41.840", "00:18:44.160", "00:19:57.680", nil, nil, "finished", nil, nil ],
  [ 24, "Wyatt", "Tyminski", "Rock Ridge", "100392948", "2716", 2, "00:39:04.631", "00:19:03.612", "00:20:01.019", nil, nil, "finished", nil, nil ],
  [ 25, "Brandon", "Garcia-Huerta", "Armstrong Cycle", "100428991", "2316", 2, "00:39:07.711", "00:18:53.692", "00:20:14.019", nil, nil, "finished", nil, nil ],
  [ 26, "Benjamin", "Rasmussen", "Bloomington Jefferson", "100406823", "2352", 2, "00:39:19.429", "00:19:20.340", "00:19:59.089", nil, nil, "finished", nil, nil ],
  [ 27, "Sawyer", "Larson", "Alexandria Youth Cycling", "100484626", "2306", 2, "00:39:22.911", "00:19:28.266", "00:19:54.645", nil, nil, "finished", nil, nil ],
  [ 28, "Jediah", "Soxman", "Brainerd HS", "100392690", "2359", 2, "00:39:36.609", "00:18:50.238", "00:20:46.371", nil, nil, "finished", nil, nil ],
  [ 29, "Logan", "Casey", "Mounds View HS", "100389911", "2585", 2, "00:39:58.430", "00:19:28.977", "00:20:29.453", nil, nil, "finished", nil, nil ],
  [ 30, "Parker", "Moore", "Prior Lake HS", "100391808", "2680", 2, "00:40:03.218", "00:20:08.742", "00:19:54.476", nil, nil, "finished", nil, nil ],
  [ 31, "Arridian", "Cooper", "Hopkins HS", "100390019", "2481", 2, "00:40:17.633", "00:19:28.269", "00:20:49.364", nil, nil, "finished", nil, nil ],
  [ 32, "Simon", "Beukema", "Rock Ridge", "100389649", "2708", 2, "00:40:20.008", "00:20:08.767", "00:20:11.241", nil, nil, "finished", nil, nil ],
  [ 33, "Sam", "Johnson", "Bloomington Jefferson", "100391087", "2346", 2, "00:40:23.344", "00:19:38.273", "00:20:45.071", nil, nil, "finished", nil, nil ],
  [ 34, "Samuel", "Kalina", "Alexandria Youth Cycling", "100427670", "2305", 2, "00:40:26.481", "00:19:50.071", "00:20:36.410", nil, nil, "finished", nil, nil ],
  [ 35, "Ian", "Hartman", "Alexandria Youth Cycling", "100486349", "2303", 2, "00:40:28.660", "00:19:37.234", "00:20:51.426", nil, nil, "finished", nil, nil ],
  [ 36, "Joseph", "Halvorson", "Hopkins HS", "100427566", "2485", 2, "00:40:28.764", "00:19:45.589", "00:20:43.175", nil, nil, "finished", nil, nil ],
  [ 37, "Eli", "Burton", "Mounds View HS", "100389853", "2583", 2, "00:40:47.377", "00:18:42.151", "00:22:05.226", nil, nil, "finished", nil, nil ],
  [ 38, "Carter", "Rush", "Alexandria Youth Cycling", "100428728", "2310", 2, "00:41:05.037", "00:20:03.594", "00:21:01.443", nil, nil, "finished", nil, nil ],
  [ 39, "Liam", "Nordby", "New Prague MS and HS", "100391940", "2645", 2, "00:41:12.795", "00:19:43.155", "00:21:29.640", nil, nil, "finished", nil, nil ],
  [ 40, "Henry", "Andersson", "Mounds View HS", "100389463", "2579", 2, "00:41:15.171", "00:19:38.663", "00:21:36.508", nil, nil, "finished", nil, nil ],
  [ 41, "Aidan", "Michals", "Hopkins HS", "100391733", "2490", 2, "00:41:30.701", "00:19:45.275", "00:21:45.426", nil, nil, "finished", nil, nil ],
  [ 42, "Trevor", "Imbach", "Armstrong Cycle", "100427492", "2320", 2, "00:41:33.657", "00:19:52.287", "00:21:41.370", nil, nil, "finished", nil, nil ],
  [ 43, "Wyatt", "Zarns", "Wayzata Mountain Bike", "100476239", "2841", 2, "00:41:41.585", "00:20:11.748", "00:21:29.837", nil, nil, "finished", nil, nil ],
  [ 44, "Isaiah", "Anderson", "Alexandria Youth Cycling", "100408035", "2301", 2, "00:41:57.493", "00:20:41.372", "00:21:16.121", nil, nil, "finished", nil, nil ],
  [ 45, "Logan", "Holtz", "Alexandria Youth Cycling", "100482354", "2304", 2, "00:42:16.259", "00:20:55.847", "00:21:20.412", nil, nil, "finished", nil, nil ],
  [ 46, "Jonah", "Leonardson", "Armstrong Cycle", "100391438", "2321", 2, "00:42:20.074", "00:20:23.368", "00:21:56.706", nil, nil, "finished", nil, nil ],
  [ 47, "Weston", "Kinney", "Wayzata Mountain Bike", "100486457", "2834", 2, "00:42:21.214", "00:21:09.655", "00:21:11.559", nil, nil, "finished", nil, nil ],
  [ 48, "Dutch", "Hedblom", "Rock Ridge", "100390779", "2711", 2, "00:42:30.536", "00:20:15.715", "00:22:14.821", nil, nil, "finished", nil, nil ],
  [ 49, "Griffin", "Boldt", "Mounds View HS", "100389719", "2582", 2, "00:42:43.967", "00:21:14.316", "00:21:29.651", nil, nil, "finished", nil, nil ],
  [ 50, "John", "Sanden", "Alexandria Youth Cycling", "100392447", "2311", 2, "00:43:09.647", "00:20:51.739", "00:22:17.908", nil, nil, "finished", nil, nil ],
  [ 51, "Aidan", "Scott", "Prior Lake HS", "100392562", "2683", 2, "00:44:03.412", "00:21:08.005", "00:22:55.407", nil, nil, "finished", nil, nil ],
  [ 52, "Luke", "Biros", "Mounds View HS", "100389670", "2581", 2, "00:44:07.508", "00:22:15.417", "00:21:52.091", nil, nil, "finished", nil, nil ],
  [ 53, "Zander", "Cesari", "Bloomington Jefferson", "100433953", "2341", 2, "00:44:36.182", "00:20:45.236", "00:23:50.946", nil, nil, "finished", nil, nil ],
  [ 54, "Jacob", "Fischer", "Wayzata Mountain Bike", "100390378", "2831", 2, "00:44:51.719", "00:21:47.078", "00:23:04.641", nil, nil, "finished", nil, nil ],
  [ 55, "Joey", "Engdahl", "Wayzata Mountain Bike", "100390282", "2830", 2, "00:45:13.782", "00:21:14.872", "00:23:58.910", nil, nil, "finished", nil, nil ],
  [ 56, "Luca", "Koppelman", "Hopkins HS", "100487776", "2488", 2, "00:45:19.394", "00:21:57.450", "00:23:21.944", nil, nil, "finished", nil, nil ],
  [ 57, "Tyler", "Mann", "Wayzata Mountain Bike", "100488289", "2836", 2, "00:46:17.435", "00:22:03.587", "00:24:13.848", nil, nil, "finished", nil, nil ],
  [ 58, "George", "Hillstrom", "Brainerd HS", "100424422", "2356", 2, "00:46:32.390", "00:21:50.518", "00:24:41.872", nil, nil, "finished", nil, nil ],
  [ 59, "Galen", "Prahl", "Bloomington Jefferson", "100411935", "2351", 2, "00:47:37.358", "00:22:57.784", "00:24:39.574", nil, nil, "finished", nil, nil ],
  [ 60, "Jacob", "Hammerstrom", "Armstrong Cycle", "100390682", "2317", 2, "00:48:11.501", "00:22:51.487", "00:25:20.014", nil, nil, "finished", nil, nil ],
  [ 61, "Brody", "Hahn", "Prior Lake HS", "100390662", "2677", 2, "00:48:32.924", "00:23:34.958", "00:24:57.966", nil, nil, "finished", nil, nil ],
  [ 62, "Zachary", "Stay", "Wayzata Mountain Bike", "100426009", "2838", 2, "00:52:36.550", "00:26:34.918", "00:26:01.632", nil, nil, "finished", nil, nil ],
  [ 63, "Tucker", "Connelly", "New Prague MS and HS", "100427242", "2642", 0, "", "", "", nil, nil, "DNF", nil, nil ],
  [ 64, "Cameron", "Lucky", "Wayzata Mountain Bike", "100391516", "2835", 0, "", "", "", nil, nil, "DNF", nil, nil ]
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

puts "\n Race 5N - Detroit Lakes seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
