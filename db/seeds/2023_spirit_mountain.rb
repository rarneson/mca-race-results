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
  [1, "Grayson", "Rickert", "Osseo HS", "100469285", "7640", 1, "00:18:38.644", "00:18:38.644", nil, nil, nil, "finished", nil, nil],
  [2, "Tye", "Holmgren", "Tioga Trailblazers", "100429051", "7695", 1, "00:19:57.429", "00:19:57.429", nil, nil, nil, "finished", nil, nil],
  [3, "Jonah", "Geisler", "Tioga Trailblazers", "100482692", "7693", 1, "00:21:23.069", "00:21:23.069", nil, nil, nil, "finished", nil, nil],
  [4, "Finn", "Neuman", "Tioga Trailblazers", "100486486", "7696", 1, "00:21:53.534", "00:21:53.534", nil, nil, nil, "finished", nil, nil],
  [5, "Levi", "Harth", "Tioga Trailblazers", "100482243", "7694", 1, "00:21:59.411", "00:21:59.411", nil, nil, nil, "finished", nil, nil],
  [6, "Micah", "Friesner", "Crosby-Ironton HS", "100488249", "7550", 1, "00:22:21.728", "00:22:21.728", nil, nil, nil, "finished", nil, nil],
  [7, "James", "Hill", "Rochester Century HS", "100471454", "7653", 1, "00:22:44.694", "00:22:44.694", nil, nil, nil, "finished", nil, nil],
  [8, "Gavin", "Belich", "Cloquet-Esko-Carlton", "100460480", "7542", 1, "00:22:46.650", "00:22:46.650", nil, nil, nil, "finished", nil, nil],
  [9, "Asher", "Lind", "West Range", "100460280", "7703", 1, "00:24:06.640", "00:24:06.640", nil, nil, nil, "finished", nil, nil],
  [10, "Gabe", "Towers", "Tioga Trailblazers", "100486864", "7697", 1, "00:24:29.146", "00:24:29.146", nil, nil, nil, "finished", nil, nil],
  [11, "Owen", "Bianchet", "Roseville", "100462884", "7663", 1, "00:24:37.386", "00:24:37.386", nil, nil, nil, "finished", nil, nil],
  [12, "Ryan", "Cleary", "River Falls HS", "100461518", "7647", 1, "00:25:41.041", "00:25:41.041", nil, nil, nil, "finished", nil, nil],
  [13, "Asher", "Davidson", "Lakeville South HS", "100469515", "7596", 1, "00:25:43.871", "00:25:43.871", nil, nil, nil, "finished", nil, nil],
  [14, "Henry", "Gucinski", "St Cloud", "100483812", "7669", 1, "00:25:55.034", "00:25:55.034", nil, nil, nil, "finished", nil, nil],
  [15, "Croix", "Giedd", "River Falls HS", "100464719", "7650", 1, "00:26:02.000", "00:26:02.000", nil, nil, nil, "finished", nil, nil],
  [16, "Brecken", "Kildahl", "Lakeville South HS", "100482800", "7597", 1, "00:26:52.526", "00:26:52.526", nil, nil, nil, "finished", nil, nil],
  [17, "Ethan", "Mullen", "Rochester", "100470824", "7655", 1, "00:27:04.498", "00:27:04.498", nil, nil, nil, "finished", nil, nil],
  [18, "Jonathon", "Smanski", "Roseville", "100478637", "7665", 1, "00:27:35.598", "00:27:35.598", nil, nil, nil, "finished", nil, nil],
  [19, "Lucas", "Fugleberg", "Bloomington", "100459728", "7517", 1, "00:28:40.856", "00:28:40.856", nil, nil, nil, "finished", nil, nil],
  [20, "Garrett", "Leow", "Cloquet-Esko-Carlton", "100470060", "7546", 1, "00:29:35.998", "00:29:35.998", nil, nil, nil, "finished", nil, nil],
  [21, "Andre Gabriel", "Paredes", "Rochester", "100469133", "7651", 1, "00:31:29.223", "00:31:29.223", nil, nil, nil, "finished", nil, nil],
  [22, "Michael", "Pfeifer", "Cloquet-Esko-Carlton", "100479289", "7548", 1, "00:32:41.032", "00:32:41.032", nil, nil, nil, "finished", nil, nil],
  [23, "Kirby", "Peterson", "Kerkhoven", "100476389", "7592", 1, "00:34:48.434", "00:34:48.434", nil, nil, nil, "finished", nil, nil],
  [24, "Kellan", "Macadams", "Bloomington", "100463202", "7518", 0, "", "", nil, nil, nil, "DNF", nil, nil],
]

#6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [1, "Jonah", "Ahlers", "Brainerd HS", "100488485", "7528", 1, "00:20:57.171", "00:20:57.171", nil, nil, nil, "finished", nil, nil],
  [2, "Boden", "Bishofsky", "Stillwater Mountain Bike", "100482114", "7688", 1, "00:22:43.254", "00:22:43.254", nil, nil, nil, "finished", nil, nil],
  [3, "Rowan", "Barrick", "Bloomington Jefferson", "100478238", "7520", 1, "00:24:36.323", "00:24:36.323", nil, nil, nil, "finished", nil, nil],
  [4, "Lucas", "Miller", "Lakeville North HS", "100481880", "7594", 1, "00:25:43.603", "00:25:43.603", nil, nil, nil, "finished", nil, nil],
  [5, "Korbin", "Kriel", "Alexandria Youth Cycling", "100473165", "7501", 1, "00:25:44.681", "00:25:44.681", nil, nil, nil, "finished", nil, nil],
  [6, "Callan", "Alcivar", "Bloomington Jefferson", "100460458", "7519", 1, "00:25:54.347", "00:25:54.347", nil, nil, nil, "finished", nil, nil],
  [7, "Zach", "Skogstad", "Prior Lake HS", "100475574", "7645", 1, "00:26:49.684", "00:26:49.684", nil, nil, nil, "finished", nil, nil],
  [8, "Peter", "Beckmann", "Bloomington Jefferson", "100460664", "7522", 1, "00:26:52.133", "00:26:52.133", nil, nil, nil, "finished", nil, nil],
  [9, "Eli", "Brash", "Stillwater Mountain Bike", "100389759", "7689", 1, "00:26:52.740", "00:26:52.740", nil, nil, nil, "finished", nil, nil],
  [10, "Nolan", "Aldrich", "Mounds View HS", "100484039", "7617", 1, "00:27:07.730", "00:27:07.730", nil, nil, nil, "finished", nil, nil],
  [11, "Jack", "Sexton", "Lakeville North HS", "100468703", "7595", 1, "00:27:33.951", "00:27:33.951", nil, nil, nil, "finished", nil, nil],
  [12, "Elliot", "Candy", "Prior Lake HS", "100477563", "7641", 1, "00:27:53.480", "00:27:53.480", nil, nil, nil, "finished", nil, nil],
  [13, "Owen", "Kes", "Lakeville North HS", "100466579", "7593", 1, "00:28:11.385", "00:28:11.385", nil, nil, nil, "finished", nil, nil],
  [14, "Cormac", "Molloy", "Stillwater Mountain Bike", "100486463", "7691", 1, "00:28:46.650", "00:28:46.650", nil, nil, nil, "finished", nil, nil],
  [15, "Garrett", "Malecha", "Mounds View HS", "100463030", "7620", 1, "00:29:03.609", "00:29:03.609", nil, nil, nil, "finished", nil, nil],
  [16, "Will", "Koenig", "Prior Lake HS", "100485238", "7643", 1, "00:30:27.005", "00:30:27.005", nil, nil, nil, "finished", nil, nil],
  [17, "Brandt", "Montag", "Alexandria Youth Cycling", "100486731", "7502", 1, "00:30:37.998", "00:30:37.998", nil, nil, nil, "finished", nil, nil],
  [18, "Leo", "Calbone", "Bloomington Jefferson", "100459747", "7524", 1, "00:30:42.788", "00:30:42.788", nil, nil, nil, "finished", nil, nil],
  [19, "Owen", "Harlan", "Prior Lake HS", "100482320", "7642", 1, "00:32:16.653", "00:32:16.653", nil, nil, nil, "finished", nil, nil],
  [20, "Jack", "Alaspa", "Rock Ridge", "100477796", "7659", 1, "00:33:01.861", "00:33:01.861", nil, nil, nil, "finished", nil, nil],
  [21, "Beckett", "Schroeder", "Prior Lake HS", "100477973", "7644", 1, "00:39:27.868", "00:39:27.868", nil, nil, nil, "finished", nil, nil],
]

#7th Grade Girls Results
results_7th_grade_girls = [
  [1, "Eleanor", "Meyer", "St Paul South", "100405792", "6099", 1, "00:19:55.733", "00:19:55.733", nil, nil, nil, "finished", nil, nil],
  [2, "Hannah", "Moore", "Maple Grove HS", "100427867", "6050", 1, "00:20:09.678", "00:20:09.678", nil, nil, nil, "finished", nil, nil],
  [3, "Cierah", "Mckibbon", "Cloquet-Esko-Carlton", "100406516", "6031", 1, "00:20:13.190", "00:20:13.190", nil, nil, nil, "finished", nil, nil],
  [4, "Claire", "Folkestad", "Alexandria Youth Cycling", "100412462", "6002", 1, "00:20:24.392", "00:20:24.392", nil, nil, nil, "finished", nil, nil],
  [5, "Selah", "Beukema", "Rock Ridge", "100406949", "6084", 1, "00:21:28.006", "00:21:28.006", nil, nil, nil, "finished", nil, nil],
  [6, "Peyton", "Stamschror", "Prior Lake HS", "100421499", "6078", 1, "00:21:28.184", "00:21:28.184", nil, nil, nil, "finished", nil, nil],
  [7, "Stella", "Museus", "Brainerd HS", "100431804", "6021", 1, "00:22:02.617", "00:22:02.617", nil, nil, nil, "finished", nil, nil],
  [8, "Clara", "Oachs", "Woodbury HS", "100406281", "6107", 1, "00:22:32.363", "00:22:32.363", nil, nil, nil, "finished", nil, nil],
  [9, "Hazel", "Bruns", "St Croix", "100407661", "6098", 1, "00:22:45.052", "00:22:45.052", nil, nil, nil, "finished", nil, nil],
  [10, "Isabel", "Ricard", "St Cloud", "100484999", "6096", 1, "00:23:15.216", "00:23:15.216", nil, nil, nil, "finished", nil, nil],
  [11, "Tahlia", "Rooney", "Alexandria Youth Cycling", "100411174", "6003", 1, "00:23:48.236", "00:23:48.236", nil, nil, nil, "finished", nil, nil],
  [12, "Nora", "Pulford", "Cloquet-Esko-Carlton", "100406069", "6032", 1, "00:24:14.426", "00:24:14.426", nil, nil, nil, "finished", nil, nil],
  [13, "Amelia", "Halvorson", "River Falls HS", "100409750", "6080", 1, "00:24:33.536", "00:24:33.536", nil, nil, nil, "finished", nil, nil],
  [14, "Addison", "Kannas", "Borealis", "100422621", "6017", 1, "00:24:44.430", "00:24:44.430", nil, nil, nil, "finished", nil, nil],
  [15, "Lena", "Hill", "New Prague MS and HS", "100427524", "6072", 1, "00:24:47.671", "00:24:47.671", nil, nil, nil, "finished", nil, nil],
  [16, "Megan", "Fritzen", "Prior Lake HS", "100412430", "6074", 1, "00:24:49.854", "00:24:49.854", nil, nil, nil, "finished", nil, nil],
  [17, "Hazel", "March", "Stillwater Mountain Bike", "100405762", "6102", 1, "00:25:17.250", "00:25:17.250", nil, nil, nil, "finished", nil, nil],
  [18, "Sage", "Larson", "Brainerd HS", "100488621", "6020", 1, "00:25:28.045", "00:25:28.045", nil, nil, nil, "finished", nil, nil],
  [19, "Laney", "Tyminski", "Rock Ridge", "100392947", "6087", 1, "00:25:53.361", "00:25:53.361", nil, nil, nil, "finished", nil, nil],
  [20, "Esmae", "Harvey", "River Falls HS", "100462340", "6081", 1, "00:27:42.277", "00:27:42.277", nil, nil, nil, "finished", nil, nil],
  [21, "Aribelle", "Radinovich", "Crosby-Ironton HS", "100435059", "6033", 1, "00:28:01.183", "00:28:01.183", nil, nil, nil, "finished", nil, nil],
  [22, "Siiri", "Nelson", "Borealis", "100472767", "6018", 1, "00:28:04.466", "00:28:04.466", nil, nil, nil, "finished", nil, nil],
  [23, "Ava", "Johnson", "Stillwater Mountain Bike", "100423613", "6101", 1, "00:29:33.764", "00:29:33.764", nil, nil, nil, "finished", nil, nil],
  [24, "Elaine", "Vanderziel", "Mounds View HS", "100485257", "6059", 1, "00:29:51.515", "00:29:51.515", nil, nil, nil, "finished", nil, nil],
  [25, "Audrey", "Jordan", "Cloquet-Esko-Carlton", "100423847", "6029", 1, "00:31:08.519", "00:31:08.519", nil, nil, nil, "finished", nil, nil],
  [26, "Naomi", "Menk", "Mounds View HS", "100476980", "6058", 1, "00:33:48.244", "00:33:48.244", nil, nil, nil, "finished", nil, nil],
  [27, "Cora", "Metelak", "Tioga Trailblazers", "100400794", "6103", 1, "00:38:09.319", "00:38:09.319", nil, nil, nil, "finished", "5 Min", "Outside Assistance"],
]

#7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [1, "Owen", "Lawson", "East Ridge HS", "100411092", "6564", 1, "00:18:16.073", "00:18:16.073", nil, nil, nil, "finished", nil, nil],
  [2, "Hudson", "Lueders", "East Ridge HS", "100408914", "6565", 1, "00:18:48.365", "00:18:48.365", nil, nil, nil, "finished", nil, nil],
  [3, "Lucas", "Truckenmiller", "East Ridge HS", "100409698", "6567", 1, "00:18:56.200", "00:18:56.200", nil, nil, nil, "finished", nil, nil],
  [4, "Garrett", "Nelson", "Osseo", "100422586", "6677", 1, "00:19:21.957", "00:19:21.957", nil, nil, nil, "finished", nil, nil],
  [5, "Garrett", "Lusignan", "Minnesota Valley", "100426763", "6614", 1, "00:19:28.800", "00:19:28.800", nil, nil, nil, "finished", nil, nil],
  [6, "Owen", "Cawcutt", "Cloquet-Esko-Carlton", "100406443", "6553", 1, "00:19:33.193", "00:19:33.193", nil, nil, nil, "finished", nil, nil],
  [7, "Theo", "Gaalswyk", "Rockford", "100485454", "6714", 1, "00:20:23.750", "00:20:23.750", nil, nil, nil, "finished", nil, nil],
  [8, "Carter", "Osvold", "Cloquet-Esko-Carlton", "100418932", "6554", 1, "00:20:37.541", "00:20:37.541", nil, nil, nil, "finished", nil, nil],
  [9, "Graham", "Bernu", "Champlin Park HS", "100427273", "6539", 1, "00:21:40.869", "00:21:40.869", nil, nil, nil, "finished", nil, nil],
  [10, "Beckett", "Craine", "Crosby-Ironton HS", "100390041", "6555", 1, "00:21:44.934", "00:21:44.934", nil, nil, nil, "finished", nil, nil],
  [11, "Henry", "Stephenson", "Hudson HS", "100407380", "6597", 1, "00:22:04.039", "00:22:04.039", nil, nil, nil, "finished", nil, nil],
  [12, "Aksel", "Drevlow", "East Ridge HS", "100390211", "6562", 1, "00:22:17.880", "00:22:17.880", nil, nil, nil, "finished", nil, nil],
  [13, "Carter", "Bolster", "Minnesota Valley", "100389720", "6612", 1, "00:22:23.550", "00:22:23.550", nil, nil, nil, "finished", nil, nil],
  [14, "Evan", "Rasmussen", "Crosby-Ironton HS", "100484405", "6556", 1, "00:22:25.045", "00:22:25.045", nil, nil, nil, "finished", nil, nil],
  [15, "Owen", "Cabbage", "Rochester", "100413341", "6700", 1, "00:22:55.609", "00:22:55.609", nil, nil, nil, "finished", nil, nil],
  [16, "Alexander", "Mcnamara", "Totino Grace-Irondale", "100410387", "6760", 1, "00:23:54.016", "00:23:54.016", nil, nil, nil, "finished", nil, nil],
  [17, "Grady", "Anderson", "Borealis", "100430812", "6529", 1, "00:24:05.297", "00:24:05.297", nil, nil, nil, "finished", nil, nil],
  [18, "Franklin", "Miller", "St Paul Highland Park", "100391752", "6749", 1, "00:24:06.707", "00:24:06.707", nil, nil, nil, "finished", nil, nil],
  [19, "Carlos Mateo", "Villalpando", "Roseville", "100485451", "6724", 1, "00:24:41.232", "00:24:41.232", nil, nil, nil, "finished", nil, nil],
  [20, "Andy", "Schmidt", "Hudson HS", "100410015", "6596", 1, "00:25:06.466", "00:25:06.466", nil, nil, nil, "finished", nil, nil],
  [21, "Xavier", "Olson", "Minnesota Valley", "100408099", "6615", 1, "00:25:08.657", "00:25:08.657", nil, nil, nil, "finished", nil, nil],
  [22, "Austin", "Smith", "Champlin Park HS", "100471897", "6542", 1, "00:25:50.488", "00:25:50.488", nil, nil, nil, "finished", nil, nil],
  [23, "Andy", "Joa", "Park HS", "100467280", "6680", 1, "00:26:01.266", "00:26:01.266", nil, nil, nil, "finished", nil, nil],
  [24, "Owen", "Rice", "Rockford", "100488151", "6716", 1, "00:27:00.209", "00:27:00.209", nil, nil, nil, "finished", nil, nil],
  [25, "Cai", "Holte", "Champlin Park HS", "100480468", "6541", 1, "00:27:40.037", "00:27:40.037", nil, nil, nil, "finished", nil, nil],
  [26, "Sawyer", "Chick", "Borealis", "100413745", "6530", 1, "00:27:47.616", "00:27:47.616", nil, nil, nil, "finished", nil, nil],
  [27, "Ryder", "Olson", "Osseo HS", "100471663", "6678", 1, "00:27:55.355", "00:27:55.355", nil, nil, nil, "finished", nil, nil],
  [28, "Eli", "Gale", "Champlin Park HS", "100479981", "6540", 1, "00:28:25.130", "00:28:25.130", nil, nil, nil, "finished", nil, nil],
  [29, "Chase", "Halverson", "Park HS", "100466803", "6679", 1, "00:29:18.280", "00:29:18.280", nil, nil, nil, "finished", nil, nil],
  [30, "Baek", "Martin-Kohls", "St Paul North", "100427381", "6751", 1, "00:32:02.744", "00:32:02.744", nil, nil, nil, "finished", nil, nil],
]

#7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  [1, "Gus", "Layman", "Rock Ridge", 100405726, 6706, 1, "00:18:18.631", "00:18:18.631", nil, nil, nil, "finished", nil, nil],
  [2, "Teddy", "Sanderson", "Stillwater Mountain Bike", 100406264, 6755, 1, "00:19:20.603", "00:19:20.603", nil, nil, nil, "finished", nil, nil],
  [3, "Landon", "Hagen", "Brainerd HS", 100430928, 6533, 1, "00:19:47.504", "00:19:47.504", nil, nil, nil, "finished", nil, nil],
  [4, "Myles", "Ingvalson", "Lakeville North HS", 100420382, 6602, 1, "00:20:57.261", "00:20:57.261", nil, nil, nil, "finished", nil, nil],
  [5, "James", "Stephan", "Stillwater Mountain Bike", 100427085, 6757, 1, "00:21:37.690", "00:21:37.690", nil, nil, nil, "finished", nil, nil],
  [6, "Mason", "Thomforde", "Prior Lake HS", 100478323, 6692, 1, "00:22:10.062", "00:22:10.062", nil, nil, nil, "finished", nil, nil],
  [7, "Brian", "Schrooten", "Bloomington Jefferson", 100405883, 6527, 1, "00:22:24.979", "00:22:24.979", nil, nil, nil, "finished", nil, nil],
  [8, "Hudson", "Schuer", "Bloomington Jefferson", 100418217, 6528, 1, "00:22:31.614", "00:22:31.614", nil, nil, nil, "finished", nil, nil],
  [9, "Ethan", "Reid", "Brainerd HS", 100429282, 6534, 1, "00:22:44.681", "00:22:44.681", nil, nil, nil, "finished", nil, nil],
  [10, "Noah", "Dahn", "New Prague MS and HS", 100420497, 6672, 1, "00:22:55.509", "00:22:55.509", nil, nil, nil, "finished", nil, nil],
  [11, "Kellen", "Meyer", "Prior Lake HS", 100471655, 6688, 1, "00:23:05.351", "00:23:05.351", nil, nil, nil, "finished", nil, nil],
  [12, "Henry", "Weis", "Stillwater Mountain Bike", 100416467, 6758, 1, "00:23:29.237", "00:23:29.237", nil, nil, nil, "finished", nil, nil],
  [13, "Obadiah", "Reishus", "Alexandria Youth Cycling", 100424849, 6505, 1, "00:23:46.390", "00:23:46.390", nil, nil, nil, "finished", nil, nil],
  [14, "Nolan", "Hemminger", "Stillwater Mountain Bike", 100418378, 6753, 1, "00:24:37.507", "00:24:37.507", nil, nil, nil, "finished", nil, nil],
  [15, "Gavin", "Mccusker", "Lakeville North HS", 100475649, 6603, 1, "00:25:07.037", "00:25:07.037", nil, nil, nil, "finished", nil, nil],
  [16, "Declan", "Turco", "Mounds View HS", 100476563, 6643, 1, "00:25:26.142", "00:25:26.142", nil, nil, nil, "finished", nil, nil],
  [17, "Dillon", "Larson", "Alexandria Youth Cycling", 100429585, 6504, 1, "00:25:32.402", "00:25:32.402", nil, nil, nil, "finished", nil, nil],
  [18, "Hudson", "Holste", "Lakeville North HS", 100419508, 6601, 1, "00:25:49.646", "00:25:49.646", nil, nil, nil, "finished", nil, nil],
  [19, "Theo", "Althaus-Kotila", "Bloomington Jefferson", 100471624, 6524, 1, "00:26:03.661", "00:26:03.661", nil, nil, nil, "finished", nil, nil],
  [20, "Logan", "Duesler", "Rock Ridge", 100406433, 6704, 1, "00:26:04.004", "00:26:04.004", nil, nil, nil, "finished", nil, nil],
  [21, "Ezra", "Metsa", "Rock Ridge", 100391716, 6707, 1, "00:26:10.057", "00:26:10.057", nil, nil, nil, "finished", nil, nil],
  [22, "Ryan", "Wu", "Mounds View HS", 100465482, 6644, 1, "00:26:21.618", "00:26:21.618", nil, nil, nil, "finished", nil, nil],
  [23, "Eli", "Franke", "Brainerd HS", 100488193, 6532, 1, "00:26:26.957", "00:26:26.957", nil, nil, nil, "finished", nil, nil],
  [24, "Finn", "Softich", "Rock Ridge", 100407440, 6712, 1, "00:26:35.434", "00:26:35.434", nil, nil, nil, "finished", nil, nil],
  [25, "Braxton", "Rothleutner", "Rock Ridge", 100460745, 6711, 1, "00:27:05.019", "00:27:05.019", nil, nil, nil, "finished", nil, nil],
  [26, "Andrew", "Alvig", "Prior Lake HS", 100483231, 6681, 1, "00:27:29.423", "00:27:29.423", nil, nil, nil, "finished", nil, nil],
  [27, "Devin", "Schilling", "Bloomington Jefferson", 100458634, 6526, 1, "00:28:37.429", "00:28:37.429", nil, nil, nil, "finished", nil, nil],
  [28, "Easton", "Friendshuh", "Prior Lake HS", 100411765, 6682, 1, "00:29:06.490", "00:29:06.490", nil, nil, nil, "finished", nil, nil],
  [29, "Juhani", "Rosandich", "Rock Ridge", 100428417, 6710, 1, "00:31:24.807", "00:31:24.807", nil, nil, nil, "finished", nil, nil],
  [30, "Evan", "Sachs", "Prior Lake HS", 100421249, 6690, 1, "00:31:25.630", "00:31:25.630", nil, nil, nil, "finished", nil, nil],
  [31, "Logan", "Jopp", "Prior Lake HS", 100478971, 6685, 1, "00:33:23.481", "00:33:23.481", nil, nil, nil, "finished", nil, nil],
  [32, "Sam", "Nelson", "Prior Lake HS", 100428174, 6689, 0, "", "", nil, nil, nil, "DNF", nil, nil],
  [33, "Cameron", "Hysong", "Mounds View HS", 100406084, 6638, 0, "", "", nil, nil, nil, "DNF", nil, nil],
  [34, "Brock", "Barlage", "New Prague MS and HS", 100427535, 6671, 0, "", "", nil, nil, nil, "DNF", nil, nil],
]

#8th Grade Girls Results
results_8th_grade_girls = [
  [1, "Vanessa", "Rickmeyer", "Crosby-Ironton HS", 100392315, 5016, 1, "00:19:35.662", "00:19:35.662", nil, nil, nil, "finished", nil, nil],
  [2, "Marg", "Minich", "Stillwater Mountain Bike", 100391764, 5086, 1, "00:19:43.618", "00:19:43.618", nil, nil, nil, "finished", nil, nil],
  [3, "Georgi", "Toftness", "Crosby-Ironton HS", 100486257, 5018, 1, "00:19:57.778", "00:19:57.778", nil, nil, nil, "finished", nil, nil],
  [4, "Piper", "Nickleski", "River Falls HS", 100391922, 5072, 1, "00:20:47.804", "00:20:47.804", nil, nil, nil, "finished", nil, nil],
  [5, "Haley", "Honmyhr", "Maple Grove HS", 100427676, 5039, 1, "00:20:48.405", "00:20:48.405", nil, nil, nil, "finished", nil, nil],
  [6, "Avery", "Lonergan", "Crosby-Ironton HS", 100391498, 5015, 1, "00:21:08.943", "00:21:08.943", nil, nil, nil, "finished", nil, nil],
  [7, "Ingrid", "Olson", "Minnesota Valley", 100408103, 5040, 1, "00:21:13.493", "00:21:13.493", nil, nil, nil, "finished", nil, nil],
  [8, "Quinn", "Van Heyst", "East Ridge HS", 100408713, 5022, 1, "00:21:13.727", "00:21:13.727", nil, nil, nil, "finished", nil, nil],
  [9, "Addison", "Suchy", "Alexandria Youth Cycling", 100392777, 5003, 1, "00:21:40.635", "00:21:40.635", nil, nil, nil, "finished", nil, nil],
  [10, "Addison", "Wakeling", "St Croix", 100393022, 5080, 1, "00:22:29.271", "00:22:29.271", nil, nil, nil, "finished", nil, nil],
  [11, "Dublin", "Sullivan", "Stillwater Mountain Bike", 100416023, 5087, 1, "00:22:36.957", "00:22:36.957", nil, nil, nil, "finished", nil, nil],
  [12, "Allison", "Tobias", "Minnesota Valley", 100462936, 5042, 1, "00:22:43.495", "00:22:43.495", nil, nil, nil, "finished", nil, nil],
  [13, "Jadon", "Carlson", "Mounds View HS", 100409174, 5047, 1, "00:22:44.320", "00:22:44.320", nil, nil, nil, "finished", nil, nil],
  [14, "Adele", "Denton", "Totino Grace-Irondale", 100390129, 5089, 1, "00:23:01.979", "00:23:01.979", nil, nil, nil, "finished", nil, nil],
  [15, "Mari", "Sathre", "Cloquet-Esko-Carlton", 100469857, 5014, 1, "00:23:18.180", "00:23:18.180", nil, nil, nil, "finished", nil, nil],
  [16, "Elleny", "Hutton", "Hudson HS", 100390969, 5035, 1, "00:23:32.736", "00:23:32.736", nil, nil, nil, "finished", nil, nil],
  [17, "Morgan", "Rother", "Champlin Park HS", 100392393, 5008, 1, "00:23:35.598", "00:23:35.598", nil, nil, nil, "finished", nil, nil],
  [18, "Mila", "Olson", "Prior Lake HS", 100392019, 5070, 1, "00:23:56.388", "00:23:56.388", nil, nil, nil, "finished", nil, nil],
  [19, "Norah", "Roth", "Crosby-Ironton HS", 100430559, 5017, 1, "00:25:15.784", "00:25:15.784", nil, nil, nil, "finished", nil, nil],
  [20, "Adeline", "Wilichowski", "Stillwater Mountain Bike", 100393145, 5088, 1, "00:25:20.211", "00:25:20.211", nil, nil, nil, "finished", nil, nil],
  [21, "Millie", "Frederick", "Cloquet-Esko-Carlton", 100390429, 5013, 1, "00:25:51.925", "00:25:51.925", nil, nil, nil, "finished", nil, nil],
  [22, "Maria", "Droogsma", "Rockford", 100390220, 5075, 1, "00:25:52.107", "00:25:52.107", nil, nil, nil, "finished", nil, nil],
  [23, "Sidse", "Sprout", "Champlin Park HS", 100482290, 5010, 1, "00:25:58.969", "00:25:58.969", nil, nil, nil, "finished", nil, nil],
  [24, "Kathryn", "Stanke", "Bloomington", 100487185, 5005, 1, "00:26:11.897", "00:26:11.897", nil, nil, nil, "finished", nil, nil],
  [25, "Eva", "Folger", "Prior Lake HS", 100390402, 5069, 1, "00:27:10.288", "00:27:10.288", nil, nil, nil, "finished", nil, nil],
  [26, "Hailey", "Soine", "Kerkhoven", 100392669, 5036, 1, "00:28:02.298", "00:28:02.298", nil, nil, nil, "finished", nil, nil],
  [27, "Jillian", "Rud", "Minnesota Valley", 100487126, 5041, 1, "00:31:31.025", "00:31:31.025", nil, nil, nil, "finished", nil, nil],
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

puts "\n🎉 Race 4 - Spirit Mountain seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
