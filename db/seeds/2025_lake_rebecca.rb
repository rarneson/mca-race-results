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

puts "Creating Race 2 - Lake Rebecca results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 2 - Lake Rebecca",
  race_date: Date.parse("September 6, 2025"),
) do |race|
  race.location = "Lake Rebecca"
  race.year = 2025
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Zoie", "Reese", "Watertown-Mayer", "100537117", "7094", 1, "20:57.2", "20:57.2", "finished" ],
  [ 2, "Marah", "Strong", "Eagan HS", "100557441", "7020", 1, "21:07.2", "21:07.2", "finished" ],
  [ 3, "Maeva", "Gartner", "Apple Valley HS", "100565750", "7005", 1, "22:23.1", "22:23.1", "finished" ],
  [ 4, "Aspen", "Rach", "Alexandria Youth Cycling", "100560214", "7002", 1, "22:37.3", "22:37.3", "finished" ],
  [ 5, "Clara", "Bert", "Mahtomedi HS", "100557251", "7045", 1, "22:56.1", "22:56.1", "finished" ],
  [ 6, "Frances", "Langer", "Cloquet-Esko-Carlton", "100566111", "7013", 1, "23:22.1", "23:22.1", "finished" ],
  [ 7, "Zoe", "Asmus", "Crosby-Ironton HS", "100557273", "7017", 1, "23:46.0", "23:46.0", "finished" ],
  [ 8, "Ilene", "Shaffner", "Roseville", "100558309", "7085", 1, "24:41.2", "24:41.2", "finished" ],
  [ 9, "Ellie", "Gucinski", "St Cloud", "100566233", "7087", 1, "25:04.9", "25:04.9", "finished" ],
  [ 10, "Isabelle", "Seaquist", "Mankato", "100575160", "7051", 1, "25:11.7", "25:11.7", "finished" ],
  [ 11, "Esme", "Jordan", "Cloquet-Esko-Carlton", "100557596", "7012", 1, "25:24.7", "25:24.7", "finished" ],
  [ 12, "Colette", "Kuhlmann", "Minnetonka HS", "100561706", "7066", 1, "25:32.4", "25:32.4", "finished" ],
  [ 13, "Marit", "Willey", "Armstrong Cycle", "100574497", "7007", 1, "25:36.9", "25:36.9", "finished" ],
  [ 14, "Elsa", "Caruso", "Minnetonka HS", "100564316", "7064", 1, "25:45.6", "25:45.6", "finished" ],
  [ 15, "Eliana", "Menk", "Mounds View HS", "100557512", "7069", 1, "25:49.1", "25:49.1", "finished" ],
  [ 16, "Ailie", "Lorenz", "Lake Area Composite", "100560484", "7041", 1, "26:49.5", "26:49.5", "finished" ],
  [ 17, "Henley", "Harrison", "Mankato", "100575669", "7050", 1, "27:02.3", "27:02.3", "finished" ],
  [ 18, "Keilana", "Sjostrom", "Mounds View HS", "100557244", "7070", 1, "27:23.4", "27:23.4", "finished" ],
  [ 19, "Piper", "Schiller", "Rock Ridge", "100557162", "7084", 1, "27:31.3", "27:31.3", "finished" ],
  [ 20, "Clara", "Gress", "Lakeville South HS", "100565088", "7043", 1, "27:40.0", "27:40.0", "finished" ],
  [ 21, "June", "Steffel", "Mounds View HS", "100575024", "7071", 1, "28:22.4", "28:22.4", "finished" ],
  [ 22, "Elise", "Greiber", "Minnetonka HS", "100565634", "7065", 1, "28:47.6", "28:47.6", "finished" ],
  [ 23, "Hannah", "Dobbelmann", "Mahtomedi HS", "100569697", "7047", 1, "29:11.7", "29:11.7", "finished" ],
  [ 24, "Meredith", "Katzenberger", "Crosby-Ironton HS", "100577922", "7018", 1, "29:17.2", "29:17.2", "finished" ],
  [ 25, "Piper", "Bloom", "Mahtomedi HS", "100569051", "7046", 1, "29:19.0", "29:19.0", "finished" ],
  [ 26, "Sara", "Shopbell", "Minnetonka HS", "100562879", "7067", 1, "30:51.0", "30:51.0", "finished" ],
  [ 27, "Kyla", "Walters", "Maple Grove HS", "100557163", "7052", 1, "31:56.4", "31:56.4", "finished" ],
  [ 28, "Lainey", "Ankley", "Rock Ridge", "100573375", "7082", 1, "32:20.9", "32:20.9", "finished" ],
  [ 29, "Talley", "Oates", "Rock Ridge", "100565858", "7083", 1, "32:44.3", "32:44.3", "finished" ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Wyatt", "Dirksen", "Rosemount HS", "100565157", "7706", 1, "20:51.2", "20:51.2", "finished" ],
  [ 2, "William", "Raabe", "Bloomington", "100557477", "7524", 1, "21:00.6", "21:00.6", "finished" ],
  [ 3, "Thomas", "Hairrell", "Champlin Park HS", "100557454", "7543", 1, "21:24.8", "21:24.8", "finished" ],
  [ 4, "Joey", "Wormwood", "Mahtomedi HS", "100560074", "7606", 1, "21:47.6", "21:47.6", "finished" ],
  [ 5, "Ari", "Lund", "Northwest", "100561967", "7667", 1, "21:48.3", "21:48.3", "finished" ],
  [ 6, "Milo", "Rathe", "St Louis Park HS", "100565782", "7720", 1, "22:11.8", "22:11.8", "finished" ],
  [ 7, "Knox", "Connelly", "Tioga Trailblazers", "100535807", "7738", 1, "22:18.0", "22:18.0", "finished" ],
  [ 8, "Quintin", "Sorensen", "Chaska HS", "100575005", "7550", 1, "22:25.8", "22:25.8", "finished" ],
  [ 9, "Graham", "Stutsman", "Watertown-Mayer", "100565697", "7740", 1, "22:26.5", "22:26.5", "finished" ],
  [ 10, "Theodor", "Boulton", "Roseville", "100571176", "7707", 1, "22:36.3", "22:36.3", "finished" ],
  [ 11, "Sebastian", "Tovsen", "Apple Valley HS", "100573915", "7514", 1, "22:48.5", "22:48.5", "finished" ],
  [ 12, "Everett", "Doepke", "Apple Valley HS", "100564766", "7512", 1, "22:52.3", "22:52.3", "finished" ],
  [ 13, "Garrett", "Miller", "Osseo Composite", "100571749", "7672", 1, "22:56.6", "22:56.6", "finished" ],
  [ 14, "Coen", "Rathe", "St Louis Park HS", "100565784", "7719", 1, "23:03.0", "23:03.0", "finished" ],
  [ 15, "Ian", "Golden", "Hermantown-Proctor", "100557133", "7579", 1, "23:08.4", "23:08.4", "finished" ],
  [ 16, "Kale", "Booker", "St Cloud", "100570556", "7713", 1, "23:08.6", "23:08.6", "finished" ],
  [ 17, "Dylan", "Maier", "Apple Valley HS", "100565303", "7513", 1, "23:08.7", "23:08.7", "finished" ],
  [ 18, "Teddy", "Osler", "Bloomington Jefferson", "100575384", "7529", 1, "23:15.5", "23:15.5", "finished" ],
  [ 19, "William", "Geyerman", "Lakeville South HS", "100575670", "7602", 1, "23:17.4", "23:17.4", "finished" ],
  [ 20, "Peyton", "Welch", "St Cloud", "100559724", "7715", 1, "23:27.9", "23:27.9", "finished" ],
  [ 21, "Parker", "Labeau", "Lakeville South HS", "100573590", "7603", 1, "23:31.8", "23:31.8", "finished" ],
  [ 22, "Pascal", "Schmidt", "Breck", "100565768", "7540", 1, "23:32.2", "23:32.2", "finished" ],
  [ 23, "Carson", "Bjergaard", "Totino Grace-Irondale", "100558868", "7739", 1, "23:52.1", "23:52.1", "finished" ],
  [ 24, "Fisher", "Swanson", "St Louis Park HS", "100558724", "7723", 1, "23:52.2", "23:52.2", "finished" ],
  [ 25, "Blake", "Nutz", "St Louis Park HS", "100578742", "7718", 1, "24:07.6", "24:07.6", "finished" ],
  [ 26, "Truman", "Winchester", "St Cloud", "100559639", "7716", 1, "24:16.2", "24:16.2", "finished" ],
  [ 27, "Xander", "Alcivar", "Bloomington Jefferson", "100557242", "7525", 1, "24:17.9", "24:17.9", "finished" ],
  [ 28, "Traxton", "Reddinger", "Eagan HS", "100562792", "7559", 1, "24:26.8", "24:26.8", "finished" ],
  [ 29, "Brooks", "Creighton", "Roseville", "100578499", "7708", 1, "24:46.3", "24:46.3", "finished" ],
  [ 30, "Asher", "Landin", "Woodbury HS", "100561905", "7749", 1, "24:46.7", "24:46.7", "finished" ],
  [ 31, "Dominic", "Valleen", "Champlin Park HS", "100563279", "7545", 1, "24:54.0", "24:54.0", "finished" ],
  [ 32, "Gideon", "Yoder", "Osseo Composite", "100578480", "7673", 1, "25:28.5", "25:28.5", "finished" ],
  [ 33, "Kaleb", "Grundhofer", "Chanhassen HS", "100561054", "7547", 1, "25:49.0", "25:49.0", "finished" ],
  [ 34, "Billy", "Swenson", "Orono HS", "100557553", "7671", 1, "26:10.4", "26:10.4", "finished" ],
  [ 35, "Sam", "Johnson", "Lake Area Composite", "100559305", "7600", 1, "26:30.0", "26:30.0", "finished" ],
  [ 36, "Peder", "Nelson", "Chanhassen HS", "100577947", "7548", 1, "26:33.6", "26:33.6", "finished" ],
  [ 37, "Levi", "Bahnemann", "Lake Area Composite", "100557173", "7597", 1, "26:44.4", "26:44.4", "finished" ],
  [ 38, "Gregory", "Jakoblich", "Lake Area Composite", "100564953", "7599", 1, "26:45.3", "26:45.3", "finished" ],
  [ 39, "Dom", "Knorp", "Orono HS", "100562269", "7670", 1, "26:53.4", "26:53.4", "finished" ],
  [ 40, "Tregg", "Jones", "Orono HS", "100565270", "7669", 1, "27:00.5", "27:00.5", "finished" ],
  [ 41, "Aiden", "Clarin", "Lake Area Composite", "100574961", "7598", 1, "28:41.7", "28:41.7", "finished" ],
  [ 42, "Richie", "Beutz", "Eden Prairie HS", "100574948", "7564", 1, "28:44.7", "28:44.7", "finished" ],
  [ 43, "Walker", "Wendlandt", "Hutchinson Tigers", "100578206", "7594", 1, "29:46.0", "29:46.0", "finished" ],
  [ 44, "Rucker", "Hitchcock", "Osseo HS", "100575049", "7674", 1, "30:09.2", "30:09.2", "finished" ],
  [ 45, "Lyra", "Miel", "St Cloud", "100561729", "7714", 1, "30:26.5", "30:26.5", "finished" ],
  [ 46, "Beckham", "Buesing", "Maple Grove HS", "100577280", "7610", 1, "30:34.7", "30:34.7", "finished" ],
  [ 47, "Cooper", "Hestick", "Maple Grove HS", "100579832", "7612", 1, "31:14.3", "31:14.3", "finished" ],
  [ 48, "Henry", "Bahler", "Cannon Valley", "100563206", "7542", 1, "31:38.7", "31:38.7", "finished" ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [ 1, "Axel", "Wood", "Minnetonka HS", "100561861", "7654", 1, "19:26.5", "19:26.5", "finished" ],
  [ 2, "Phillip", "Majka", "Brainerd HS", "100568035", "7539", 1, "20:41.3", "20:41.3", "finished" ],
  [ 3, "Callum", "Mcarthur", "Minnetonka HS", "100565633", "7647", 1, "21:09.5", "21:09.5", "finished" ],
  [ 4, "Winston", "Toftness", "Crosby-Ironton HS", "100566190", "7557", 1, "21:10.7", "21:10.7", "finished" ],
  [ 5, "Finnian", "Roark", "Rock Ridge", "100561104", "7702", 1, "21:46.4", "21:46.4", "finished" ],
  [ 6, "Jaxon", "Heiser", "Alexandria Youth Cycling", "100575231", "7505", 1, "22:01.7", "22:01.7", "finished" ],
  [ 7, "Jaden", "Centanni", "Mounds View HS", "100557139", "7656", 1, "22:03.2", "22:03.2", "finished" ],
  [ 8, "Kieran", "Schimnich", "St Paul Central", "100557274", "7724", 1, "22:06.7", "22:06.7", "finished" ],
  [ 9, "Jack", "Reithel", "Minnetonka HS", "100561535", "7649", 1, "22:06.7", "22:06.7", "finished" ],
  [ 10, "Levi", "Anderson", "Minnetonka HS", "100563356", "7642", 1, "22:43.7", "22:43.7", "finished" ],
  [ 11, "Abraham", "Franke", "Brainerd HS", "100578571", "7538", 1, "22:46.8", "22:46.8", "finished" ],
  [ 12, "Sully", "Riess", "Mounds View HS", "100564422", "7659", 1, "22:47.9", "22:47.9", "finished" ],
  [ 13, "Jack", "Jorgensen", "Cloquet-Esko-Carlton", "100558614", "7552", 1, "22:48.3", "22:48.3", "finished" ],
  [ 14, "Robert", "Mark", "Minnetonka HS", "100562133", "7646", 1, "22:50.4", "22:50.4", "finished" ],
  [ 15, "Ryder", "Miller", "Minnetonka HS", "100563349", "7648", 1, "23:05.8", "23:05.8", "finished" ],
  [ 16, "Jack", "Ficek", "Minnetonka HS", "100565756", "7643", 1, "23:19.0", "23:19.0", "finished" ],
  [ 17, "Thor", "Toftoy", "Minnetonka HS", "100565104", "7652", 1, "24:23.0", "24:23.0", "finished" ],
  [ 18, "George", "Barthel", "Alexandria Youth Cycling", "100579561", "7501", 1, "24:41.1", "24:41.1", "finished" ],
  [ 19, "Martin", "Campbell", "Mounds View HS", "100564595", "7655", 1, "24:57.8", "24:57.8", "finished" ],
  [ 20, "Micah", "Klaetsch", "Alexandria Youth Cycling", "100557147", "7506", 1, "24:57.9", "24:57.9", "finished" ],
  [ 21, "Brecken", "Medway", "Alexandria Youth Cycling", "100574562", "7507", 1, "25:03.2", "25:03.2", "finished" ],
  [ 22, "Easton", "Spilseth", "Minnetonka HS", "100561712", "7650", 1, "25:03.3", "25:03.3", "finished" ],
  [ 23, "William", "Cass", "Alexandria Youth Cycling", "100576343", "7502", 1, "25:10.6", "25:10.6", "finished" ],
  [ 24, "Alex", "Munyon", "Mounds View HS", "100565048", "7657", 1, "25:20.1", "25:20.1", "finished" ],
  [ 25, "Owen", "Corbett", "Crosby-Ironton HS", "100557136", "7556", 1, "25:28.6", "25:28.6", "finished" ],
  [ 26, "James", "Babler", "Crosby-Ironton HS", "100571175", "7555", 1, "25:34.5", "25:34.5", "finished" ],
  [ 27, "Griffin", "Peterson", "Alexandria Youth Cycling", "100560455", "7508", 1, "25:43.8", "25:43.8", "finished" ],
  [ 28, "Jackson", "Roehm", "Mounds View HS", "100557496", "7660", 1, "26:07.7", "26:07.7", "finished" ],
  [ 29, "Jameson", "Dillon", "Alexandria Youth Cycling", "100572708", "7503", 1, "26:15.2", "26:15.2", "finished" ],
  [ 30, "Samuel", "Rankl", "Alexandria Youth Cycling", "100571677", "7510", 1, "26:25.0", "26:25.0", "finished" ],
  [ 31, "David", "Lashkowitz", "Minnetonka HS", "100565996", "7645", 1, "27:36.8", "27:36.8", "finished" ],
  [ 32, "Bodi", "Cerise", "Brainerd HS", "100571320", "7536", 1, "28:21.3", "28:21.3", "finished" ],
  [ 33, "Joel", "Preston", "Alexandria Youth Cycling", "100559044", "7509", 1, "28:39.8", "28:39.8", "finished" ],
  [ 34, "Emmitt", "Good", "Alexandria Youth Cycling", "100577866", "7504", 1, "31:22.2", "31:22.2", "finished" ],
  [ 35, "Dominic", "Altrichter", "Minnetonka HS", "100565846", "7641", 1, "36:45.2", "36:45.2", "finished" ],
  [ 36, "Anderson", "Steiner", "Minnetonka HS", "100561899", "7651", 1, "36:56.9", "36:56.9", "finished" ],
  [ 37, "Luke", "Tungseth", "Alexandria Youth Cycling", "100576962", "7511", 0, "", "", "dnf" ]
]

# 7th Grade Girls Results
results_7th_grade_girls = [
  [ 1, "Mariella", "Andeson", "Eastview HS", "100532236", "6036", 1, "18:17.1", "18:17.1", "finished" ],
  [ 2, "Lucia", "Drevlow", "Eastview HS", "100512776", "6033", 1, "18:23.2", "18:23.2", "finished" ],
  [ 3, "Summit", "Beukema", "Rock Ridge", "100511314", "6079", 1, "19:07.9", "19:07.9", "finished" ],
  [ 4, "Clara", "Walz", "Roseville", "100530811", "6085", 1, "19:34.3", "19:34.3", "finished" ],
  [ 5, "Megan", "Pierson", "Armstrong Cycle", "100521906", "6005", 1, "19:36.6", "19:36.6", "finished" ],
  [ 6, "Courtney", "Hollinbeck", "Armstrong Cycle", "100511875", "6003", 1, "19:40.3", "19:40.3", "finished" ],
  [ 7, "Olive", "Wilcox", "Maple Grove HS", "100519538", "6054", 1, "20:08.4", "20:08.4", "finished" ],
  [ 8, "Megan", "Ryan", "Brainerd HS", "100534426", "6017", 1, "20:36.7", "20:36.7", "finished" ],
  [ 9, "Gemma", "Oberding", "Eastview HS", "100521787", "6037", 1, "21:26.3", "21:26.3", "finished" ],
  [ 10, "Netta", "Wheeler", "St Paul Central", "100514278", "6101", 1, "21:31.0", "21:31.0", "finished" ],
  [ 11, "Hartley", "Biorn", "Maple Grove HS", "100530790", "6052", 1, "21:42.3", "21:42.3", "finished" ],
  [ 12, "Emma", "Metsa", "Rock Ridge", "100567332", "6080", 1, "21:52.4", "21:52.4", "finished" ],
  [ 13, "Kinley", "Kuhlmann", "Minnetonka HS", "100520839", "6067", 1, "22:00.1", "22:00.1", "finished" ],
  [ 14, "Olive", "Thiessen", "St Cloud", "100534823", "6092", 1, "22:01.2", "22:01.2", "finished" ],
  [ 15, "Addy", "Schilling", "Bloomington Jefferson", "100511093", "6014", 1, "22:02.1", "22:02.1", "finished" ],
  [ 16, "Natalie", "Schmidt", "Minnetonka HS", "100522933", "6068", 1, "22:11.1", "22:11.1", "finished" ],
  [ 17, "Olivia", "Hoyord", "Minnetonka HS", "100527853", "6066", 1, "22:12.9", "22:12.9", "finished" ],
  [ 18, "Brooke", "Migliori", "Lakeville South HS", "100513290", "6050", 1, "22:18.6", "22:18.6", "finished" ],
  [ 19, "Talia", "Touchet", "Armstrong Cycle", "100521607", "6006", 1, "22:27.8", "22:27.8", "finished" ],
  [ 20, "Freya", "Mollet", "St Louis Park HS", "100531804", "6095", 1, "22:49.5", "22:49.5", "finished" ],
  [ 21, "Annalee", "Knollmaier", "Bloomington Jefferson", "100510560", "6012", 1, "22:53.3", "22:53.3", "finished" ],
  [ 22, "Elena", "Hendrickson", "Cloquet-Esko-Carlton", "100516593", "6024", 1, "23:26.7", "23:26.7", "finished" ],
  [ 23, "Kate", "Evans", "Breck", "100566721", "6019", 1, "23:27.3", "23:27.3", "finished" ],
  [ 24, "Juliana", "Spaulding", "Breck", "100566990", "6020", 1, "23:30.8", "23:30.8", "finished" ],
  [ 25, "Katrina", "Bjergaard", "Totino Grace-Irondale", "100558884", "6110", 1, "23:31.0", "23:31.0", "finished" ],
  [ 26, "Emelyn", "Hendrickson", "Cloquet-Esko-Carlton", "100516595", "6025", 1, "23:33.6", "23:33.6", "finished" ],
  [ 27, "Edith", "Schulz", "St Paul Central", "100577184", "6100", 1, "23:33.7", "23:33.7", "finished" ],
  [ 28, "Evelyn", "Eigen", "Alexandria Youth Cycling", "100532348", "6002", 1, "23:38.2", "23:38.2", "finished" ],
  [ 29, "Britta", "Droogsma", "Rockford", "100510939", "6083", 1, "23:44.8", "23:44.8", "finished" ],
  [ 30, "Gwendolyn", "Guettler-Johnson", "Woodbury HS", "100516708", "6115", 1, "23:51.5", "23:51.5", "finished" ],
  [ 31, "Gwynn", "Moon", "Brainerd HS", "100577115", "6016", 1, "24:11.9", "24:11.9", "finished" ],
  [ 32, "Lilja", "Bergquist", "Bloomington", "100516074", "6010", 1, "24:26.6", "24:26.6", "finished" ],
  [ 33, "Gwen", "Mcgreevy", "Bloomington Jefferson", "100532223", "6013", 1, "24:56.6", "24:56.6", "finished" ],
  [ 34, "Kiah", "Droogsma", "Rockford", "100510943", "6084", 1, "25:22.3", "25:22.3", "finished" ],
  [ 35, "Avery", "Burkhart", "Maple Grove HS", "100577069", "6053", 1, "25:33.2", "25:33.2", "finished" ],
  [ 36, "Adellie", "Szczodroski", "Brainerd HS", "100579236", "6018", 1, "25:41.9", "25:41.9", "finished" ],
  [ 37, "Quinn", "Farmer", "Mounds View HS", "100564123", "6069", 1, "25:50.1", "25:50.1", "finished" ],
  [ 38, "Anna", "Martensen", "Brainerd HS", "100518416", "6015", 1, "26:30.1", "26:30.1", "finished" ],
  [ 39, "Irie", "Kronstedt", "Crosby-Ironton HS", "100577722", "6030", 1, "26:39.5", "26:39.5", "finished" ],
  [ 40, "Olivia", "Miller", "Crosby-Ironton HS", "100578532", "6031", 1, "27:00.4", "27:00.4", "finished" ],
  [ 41, "Allison", "Hamilton", "Crosby-Ironton HS", "100534870", "6029", 1, "27:08.2", "27:08.2", "finished" ],
  [ 42, "Macie", "Steinke", "Crosby-Ironton HS", "100579749", "6032", 1, "27:27.6", "27:27.6", "finished" ],
  [ 43, "Everleigh", "Cruze", "Alexandria Youth Cycling", "100571990", "6001", 1, "27:37.4", "27:37.4", "finished" ],
  [ 44, "Norah", "Lawson", "East Ridge HS", "100510479", "6034", 1, "28:03.4", "28:03.4", "finished" ],
  [ 45, "Ellie", "Nurmela", "Lakeville North HS", "100522316", "6049", 1, "31:10.9", "31:10.9", "finished" ],
  [ 46, "Sylviana", "Bonczyk", "Bloomington", "100559859", "6011", 1, "31:46.6", "31:46.6", "finished" ],
  [ 47, "Amelia", "Olson", "Cloquet-Esko-Carlton", "100558400", "6027", 0, "", "", "dnf" ],
  [ 48, "Audii", "Rosandich", "Rock Ridge", "100532616", "6082", 0, "", "", "dnf" ]
]

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [ 1, "Quincy", "Grotenhuis", "Lakeville South HS", "100521373", "6626", 1, "17:00.0", "17:00.0", "finished" ],
  [ 2, "Ryan", "Kokotovich", "Roseville", "100510797", "6745", 1, "17:09.5", "17:09.5", "finished" ],
  [ 3, "Levi", "Hansen", "St Cloud", "100531503", "6755", 1, "17:18.8", "17:18.8", "finished" ],
  [ 4, "Tyler", "Tate", "Orono HS", "100529334", "6703", 1, "17:36.4", "17:36.4", "finished" ],
  [ 5, "Emin", "Erenler", "St Louis Park HS", "100517696", "6761", 1, "17:42.6", "17:42.6", "finished" ],
  [ 6, "Henry", "Osburn", "Bloomington Jefferson", "100510972", "6532", 1, "18:14.3", "18:14.3", "finished" ],
  [ 7, "Henry", "Brouwer", "Rockford", "100513879", "6739", 1, "18:41.0", "18:41.0", "finished" ],
  [ 8, "Olin", "Bujold", "Tioga Trailblazers", "100489293", "6783", 1, "18:41.3", "18:41.3", "finished" ],
  [ 9, "Kai", "Lander", "Eastview HS", "100520776", "6584", 1, "18:48.9", "18:48.9", "finished" ],
  [ 10, "Will", "Bakken", "St Louis Park HS", "100516837", "6759", 1, "18:51.8", "18:51.8", "finished" ],
  [ 11, "Rhone", "Urban", "Rosemount HS", "100526006", "6741", 1, "18:52.9", "18:52.9", "finished" ],
  [ 12, "Nick", "Campbell", "Orono HS", "100535629", "6701", 1, "19:21.6", "19:21.6", "finished" ],
  [ 13, "Gavin", "Taylor", "Chaska HS", "100535430", "6558", 1, "19:38.9", "19:38.9", "finished" ],
  [ 14, "Jacob", "Pshon", "St Louis Park HS", "100510609", "6766", 1, "19:53.4", "19:53.4", "finished" ],
  [ 15, "Caleb", "Maxwell", "Northwoods Cycling", "100576196", "6699", 1, "20:07.7", "20:07.7", "finished" ],
  [ 16, "Madden", "Lorenz", "Lake Area Composite", "100532574", "6620", 1, "20:17.0", "20:17.0", "finished" ],
  [ 17, "Aiden", "Sutherland", "Tioga Trailblazers", "100534292", "6786", 1, "20:20.1", "20:20.1", "finished" ],
  [ 18, "Tristen", "Peters", "Armstrong Cycle", "100522931", "6515", 1, "20:21.9", "20:21.9", "finished" ],
  [ 19, "Elliot", "Freeman", "Roseville", "100530582", "6744", 1, "20:22.7", "20:22.7", "finished" ],
  [ 20, "Willem", "Sheldon", "Minneapolis Northside", "100538513", "6635", 1, "20:23.4", "20:23.4", "finished" ],
  [ 21, "Jack", "Bond", "Eden Prairie HS", "100534454", "6587", 1, "20:26.1", "20:26.1", "finished" ],
  [ 22, "Neil", "Imholte", "Tioga Trailblazers", "100535255", "6784", 1, "20:27.9", "20:27.9", "finished" ],
  [ 23, "Landon", "Maxwell", "Northwoods Cycling", "100576214", "6700", 1, "20:30.5", "20:30.5", "finished" ],
  [ 24, "Leo", "Lick", "Tioga Trailblazers", "100569911", "6785", 1, "20:34.1", "20:34.1", "finished" ],
  [ 25, "Merrick", "Helgerson", "Apple Valley HS", "100525046", "6511", 1, "20:54.0", "20:54.0", "finished" ],
  [ 26, "Greylin", "Cline", "Breck", "100535312", "6539", 1, "21:01.9", "21:01.9", "finished" ],
  [ 27, "Elliot", "Curtis", "St Louis Park HS", "100515026", "6760", 1, "21:09.0", "21:09.0", "finished" ],
  [ 28, "Jax", "Schildgen", "Lake Area Composite", "100532634", "6621", 1, "21:13.0", "21:13.0", "finished" ],
  [ 29, "Gilbert", "Nelson", "Osseo Composite", "100528205", "6704", 1, "21:15.8", "21:15.8", "finished" ],
  [ 30, "Charlie", "Dixon", "Roseville", "100521844", "6742", 1, "21:16.1", "21:16.1", "finished" ],
  [ 31, "Morgan", "Patterson", "Champlin Park HS", "100529670", "6550", 1, "21:18.8", "21:18.8", "finished" ],
  [ 32, "Sam", "Heitman", "Hutchinson Tigers", "100521405", "6617", 1, "21:23.1", "21:23.1", "finished" ],
  [ 33, "George", "Martin", "Bloomington", "100514224", "6526", 1, "21:25.5", "21:25.5", "finished" ],
  [ 34, "Oliver", "Lewis", "Eastview HS", "100563409", "6585", 1, "21:26.3", "21:26.3", "finished" ],
  [ 35, "Vincent", "Howe", "St Louis Park HS", "100534616", "6762", 1, "21:34.8", "21:34.8", "finished" ],
  [ 36, "Leif", "Reed", "Eagan HS", "100517970", "6580", 1, "21:38.6", "21:38.6", "finished" ],
  [ 37, "Lucas", "Parker", "Lakeville North HS", "100531562", "6625", 1, "21:49.4", "21:49.4", "finished" ],
  [ 38, "Oliver", "Kozicki", "St Louis Park HS", "100526052", "6763", 1, "21:55.1", "21:55.1", "finished" ],
  [ 39, "Benjamin", "Birznieks", "Rockford", "100568192", "6738", 1, "22:09.3", "22:09.3", "finished" ],
  [ 40, "Henry", "Medhus", "North Dakota", "100523070", "6697", 1, "22:14.4", "22:14.4", "finished" ],
  [ 41, "Ezekiel", "Josterud", "Chaska HS", "100535951", "6557", 1, "22:18.1", "22:18.1", "finished" ],
  [ 42, "Evan", "Hoppe", "Champlin Park HS", "100576776", "6548", 1, "22:44.1", "22:44.1", "finished" ],
  [ 43, "Anders", "Dolmar", "Bloomington Jefferson", "100516525", "6531", 1, "22:44.8", "22:44.8", "finished" ],
  [ 44, "Rex", "Nelson", "Chanhassen HS", "100535767", "6553", 1, "22:47.9", "22:47.9", "finished" ],
  [ 45, "Jameson", "La Barbera", "St Louis Park HS", "100523472", "6764", 1, "22:50.6", "22:50.6", "finished" ],
  [ 46, "Carson", "Henton", "Lake Area Composite", "100561347", "6619", 1, "22:53.9", "22:53.9", "finished" ],
  [ 47, "Sully", "Verdeck", "Bloomington", "100535361", "6527", 1, "22:54.6", "22:54.6", "finished" ],
  [ 48, "Archer", "Braastad", "Champlin Park HS", "100569652", "6547", 1, "22:55.3", "22:55.3", "finished" ],
  [ 49, "Juhl", "Sakstrup", "Breck", "100563539", "6544", 1, "22:56.1", "22:56.1", "finished" ],
  [ 50, "Kai", "Richardson", "BBBikers", "100562155", "6522", 1, "22:56.5", "22:56.5", "finished" ],
  [ 51, "Eli", "Owens", "Mankato West HS", "100512534", "6630", 1, "22:57.7", "22:57.7", "finished" ],
  [ 52, "Gabriel", "Cesari", "Bloomington", "100531095", "6524", 1, "22:58.3", "22:58.3", "finished" ],
  [ 53, "Samuel", "Dybvig", "BBBikers", "100530115", "6519", 1, "22:59.9", "22:59.9", "finished" ],
  [ 54, "Parker", "Elsen", "Bloomington", "100512134", "6525", 1, "22:59.9", "22:59.9", "finished" ],
  [ 55, "Eli", "Haglof", "Totino Grace-Irondale", "100514481", "6787", 1, "23:01.4", "23:01.4", "finished" ],
  [ 56, "Joaquin", "Villalpando", "Roseville", "100530160", "6747", 1, "23:03.2", "23:03.2", "finished" ],
  [ 57, "Harrison", "Young", "St Louis Park HS", "100522519", "6767", 1, "23:06.7", "23:06.7", "finished" ],
  [ 58, "Owen", "Wetterlund", "Lake Area Composite", "100563945", "6622", 1, "23:20.1", "23:20.1", "finished" ],
  [ 59, "Benjamin", "Zachmann", "St Michael / Albertville", "100577763", "6768", 1, "23:28.2", "23:28.2", "finished" ],
  [ 60, "Odin", "Arendt", "Westonka", "100579657", "6796", 1, "23:49.8", "23:49.8", "finished" ],
  [ 61, "Carter", "Crane", "Chanhassen HS", "100535579", "6551", 1, "23:54.5", "23:54.5", "finished" ],
  [ 62, "Luke", "Druckman", "Armstrong Cycle", "100530251", "6514", 1, "24:03.0", "24:03.0", "finished" ],
  [ 63, "Eero", "Decoux", "Cannon Valley", "100510780", "6546", 1, "24:08.1", "24:08.1", "finished" ],
  [ 64, "Quinlan", "Dietz", "Maple Grove HS", "100571151", "6633", 1, "24:20.8", "24:20.8", "finished" ],
  [ 65, "Drew", "Blakeley", "Maple Grove HS", "100567117", "6632", 1, "24:29.5", "24:29.5", "finished" ],
  [ 66, "Teague", "Bennett", "Cannon Valley", "100576460", "6545", 1, "24:29.8", "24:29.8", "finished" ],
  [ 67, "Declan", "Nordos", "St Cloud", "100563160", "6756", 1, "24:31.9", "24:31.9", "finished" ],
  [ 68, "Charles", "Siekert", "Eagan HS", "100562491", "6581", 1, "24:32.7", "24:32.7", "finished" ],
  [ 69, "Jennings", "Gall", "St Cloud", "100561065", "6754", 1, "24:36.7", "24:36.7", "finished" ],
  [ 70, "Noah", "Schularick", "Maple Grove HS", "100575088", "6634", 1, "24:54.2", "24:54.2", "finished" ],
  [ 71, "Henry", "Hauschild", "Breck", "100518441", "6541", 1, "26:09.9", "26:09.9", "finished" ],
  [ 72, "Charlie", "Rauchman", "Park HS", "100561124", "6705", 1, "26:17.3", "26:17.3", "finished" ],
  [ 73, "Joshua", "Mills", "Westonka", "100565775", "6798", 1, "27:17.0", "27:17.0", "finished" ],
  [ 74, "Carter", "Hanson", "Chaska HS", "100519868", "6556", 1, "29:24.4", "29:24.4", "finished" ],
  [ 75, "Matthew", "Kriesel", "Totino Grace-Irondale", "100564705", "6788", 1, "30:33.5", "30:33.5", "finished" ],
  [ 76, "Rio", "De Paz", "Rosemount HS", "100562774", "6578", 1, "32:00.0", "32:00.0", "finished" ],
  [ 77, "Max", "Von Bank", "Mankato West HS", "100532520", "6631", 1, "35:08.4", "35:08.4", "finished" ],
  [ 78, "Fritz", "Frey", "Rosemount HS", "100528778", "6740", 0, "", "", "dnf" ],
  [ 79, "Marcus", "Fiedler", "BBBikers", "100530795", "6520", 0, "", "", "dnf" ],
  [ 80, "Bryce", "Schaaf", "Lakeville South HS", "100525474", "6627", 0, "", "", "dnf" ]
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

puts "\n🎉 RACE 2 - Lake Rebecca seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
