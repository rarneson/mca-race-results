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

#6th Grade Girls Results
results_6th_grade_girls = [
  [1, "ZOIE", "REESE", "Watertown-Mayer", "100537117", "7094", 1, "20:57.2", "20:57.2", "finished"],
  [2, "MARAH", "STRONG", "Eagan HS", "100557441", "7020", 1, "21:07.2", "21:07.2", "finished"],
  [3, "MAEVA", "GARTNER", "Apple Valley HS", "100565750", "7005", 1, "22:23.1", "22:23.1", "finished"],
  [4, "ASPEN", "RACH", "Alexandria Youth Cycling", "100560214", "7002", 1, "22:37.3", "22:37.3", "finished"],
  [5, "CLARA", "BERT", "Mahtomedi HS", "100557251", "7045", 1, "22:56.1", "22:56.1", "finished"],
  [6, "FRANCES", "LANGER", "Cloquet-Esko-Carlton", "100566111", "7013", 1, "23:22.1", "23:22.1", "finished"],
  [7, "ZOE", "ASMUS", "Crosby-Ironton HS", "100557273", "7017", 1, "23:46.0", "23:46.0", "finished"],
  [8, "ILENE", "SHAFFNER", "Roseville", "100558309", "7085", 1, "24:41.2", "24:41.2", "finished"],
  [9, "ELLIE", "GUCINSKI", "St Cloud", "100566233", "7087", 1, "25:04.9", "25:04.9", "finished"],
  [10, "ISABELLE", "SEAQUIST", "Mankato", "100575160", "7051", 1, "25:11.7", "25:11.7", "finished"],
  [11, "ESME", "JORDAN", "Cloquet-Esko-Carlton", "100557596", "7012", 1, "25:24.7", "25:24.7", "finished"],
  [12, "COLETTE", "KUHLMANN", "Minnetonka HS", "100561706", "7066", 1, "25:32.4", "25:32.4", "finished"],
  [13, "MARIT", "WILLEY", "Armstrong Cycle", "100574497", "7007", 1, "25:36.9", "25:36.9", "finished"],
  [14, "ELSA", "CARUSO", "Minnetonka HS", "100564316", "7064", 1, "25:45.6", "25:45.6", "finished"],
  [15, "ELIANA", "MENK", "Mounds View HS", "100557512", "7069", 1, "25:49.1", "25:49.1", "finished"],
  [16, "AILIE", "LORENZ", "Lake Area Composite", "100560484", "7041", 1, "26:49.5", "26:49.5", "finished"],
  [17, "HENLEY", "HARRISON", "Mankato", "100575669", "7050", 1, "27:02.3", "27:02.3", "finished"],
  [18, "KEILANA", "SJOSTROM", "Mounds View HS", "100557244", "7070", 1, "27:23.4", "27:23.4", "finished"],
  [19, "PIPER", "SCHILLER", "Rock Ridge", "100557162", "7084", 1, "27:31.3", "27:31.3", "finished"],
  [20, "CLARA", "GRESS", "Lakeville South HS", "100565088", "7043", 1, "27:40.0", "27:40.0", "finished"],
  [21, "JUNE", "STEFFEL", "Mounds View HS", "100575024", "7071", 1, "28:22.4", "28:22.4", "finished"],
  [22, "ELISE", "GREIBER", "Minnetonka HS", "100565634", "7065", 1, "28:47.6", "28:47.6", "finished"],
  [23, "HANNAH", "DOBBELMANN", "Mahtomedi HS", "100569697", "7047", 1, "29:11.7", "29:11.7", "finished"],
  [24, "MEREDITH", "KATZENBERGER", "Crosby-Ironton HS", "100577922", "7018", 1, "29:17.2", "29:17.2", "finished"],
  [25, "PIPER", "BLOOM", "Mahtomedi HS", "100569051", "7046", 1, "29:19.0", "29:19.0", "finished"],
  [26, "SARA", "SHOPBELL", "Minnetonka HS", "100562879", "7067", 1, "30:51.0", "30:51.0", "finished"],
  [27, "KYLA", "WALTERS", "Maple Grove HS", "100557163", "7052", 1, "31:56.4", "31:56.4", "finished"],
  [28, "LAINEY", "ANKLEY", "Rock Ridge", "100573375", "7082", 1, "32:20.9", "32:20.9", "finished"],
  [29, "TALLEY", "OATES", "Rock Ridge", "100565858", "7083", 1, "32:44.3", "32:44.3", "finished"],
]

#6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [1, "WYATT", "DIRKSEN", "Rosemount HS", "100565157", "7706", 1, "20:51.2", "20:51.2", "finished"],
  [2, "WILLIAM", "RAABE", "Bloomington", "100557477", "7524", 1, "21:00.6", "21:00.6", "finished"],
  [3, "THOMAS", "HAIRRELL", "Champlin Park HS", "100557454", "7543", 1, "21:24.8", "21:24.8", "finished"],
  [4, "JOEY", "WORMWOOD", "Mahtomedi HS", "100560074", "7606", 1, "21:47.6", "21:47.6", "finished"],
  [5, "ARI", "LUND", "Northwest", "100561967", "7667", 1, "21:48.3", "21:48.3", "finished"],
  [6, "MILO", "RATHE", "St Louis Park HS", "100565782", "7720", 1, "22:11.8", "22:11.8", "finished"],
  [7, "KNOX", "CONNELLY", "Tioga Trailblazers", "100535807", "7738", 1, "22:18.0", "22:18.0", "finished"],
  [8, "QUINTIN", "SORENSEN", "Chaska HS", "100575005", "7550", 1, "22:25.8", "22:25.8", "finished"],
  [9, "GRAHAM", "STUTSMAN", "Watertown-Mayer", "100565697", "7740", 1, "22:26.5", "22:26.5", "finished"],
  [10, "THEODOR", "BOULTON", "Roseville", "100571176", "7707", 1, "22:36.3", "22:36.3", "finished"],
  [11, "SEBASTIAN", "TOVSEN", "Apple Valley HS", "100573915", "7514", 1, "22:48.5", "22:48.5", "finished"],
  [12, "EVERETT", "DOEPKE", "Apple Valley HS", "100564766", "7512", 1, "22:52.3", "22:52.3", "finished"],
  [13, "GARRETT", "MILLER", "Osseo Composite", "100571749", "7672", 1, "22:56.6", "22:56.6", "finished"],
  [14, "COEN", "RATHE", "St Louis Park HS", "100565784", "7719", 1, "23:03.0", "23:03.0", "finished"],
  [15, "IAN", "GOLDEN", "Hermantown-Proctor", "100557133", "7579", 1, "23:08.4", "23:08.4", "finished"],
  [16, "KALE", "BOOKER", "St Cloud", "100570556", "7713", 1, "23:08.6", "23:08.6", "finished"],
  [17, "DYLAN", "MAIER", "Apple Valley HS", "100565303", "7513", 1, "23:08.7", "23:08.7", "finished"],
  [18, "TEDDY", "OSLER", "Bloomington Jefferson", "100575384", "7529", 1, "23:15.5", "23:15.5", "finished"],
  [19, "WILLIAM", "GEYERMAN", "Lakeville South HS", "100575670", "7602", 1, "23:17.4", "23:17.4", "finished"],
  [20, "PEYTON", "WELCH", "St Cloud", "100559724", "7715", 1, "23:27.9", "23:27.9", "finished"],
  [21, "PARKER", "LABEAU", "Lakeville South HS", "100573590", "7603", 1, "23:31.8", "23:31.8", "finished"],
  [22, "PASCAL", "SCHMIDT", "Breck", "100565768", "7540", 1, "23:32.2", "23:32.2", "finished"],
  [23, "CARSON", "BJERGAARD", "Totino Grace-Irondale", "100558868", "7739", 1, "23:52.1", "23:52.1", "finished"],
  [24, "FISHER", "SWANSON", "St Louis Park HS", "100558724", "7723", 1, "23:52.2", "23:52.2", "finished"],
  [25, "BLAKE", "NUTZ", "St Louis Park HS", "100578742", "7718", 1, "24:07.6", "24:07.6", "finished"],
  [26, "TRUMAN", "WINCHESTER", "St Cloud", "100559639", "7716", 1, "24:16.2", "24:16.2", "finished"],
  [27, "XANDER", "ALCIVAR", "Bloomington Jefferson", "100557242", "7525", 1, "24:17.9", "24:17.9", "finished"],
  [28, "TRAXTON", "REDDINGER", "Eagan HS", "100562792", "7559", 1, "24:26.8", "24:26.8", "finished"],
  [29, "BROOKS", "CREIGHTON", "Roseville", "100578499", "7708", 1, "24:46.3", "24:46.3", "finished"],
  [30, "ASHER", "LANDIN", "Woodbury HS", "100561905", "7749", 1, "24:46.7", "24:46.7", "finished"],
  [31, "DOMINIC", "VALLEEN", "Champlin Park HS", "100563279", "7545", 1, "24:54.0", "24:54.0", "finished"],
  [32, "GIDEON", "YODER", "Osseo Composite", "100578480", "7673", 1, "25:28.5", "25:28.5", "finished"],
  [33, "KALEB", "GRUNDHOFER", "Chanhassen HS", "100561054", "7547", 1, "25:49.0", "25:49.0", "finished"],
  [34, "BILLY", "SWENSON", "Orono HS", "100557553", "7671", 1, "26:10.4", "26:10.4", "finished"],
  [35, "SAM", "JOHNSON", "Lake Area Composite", "100559305", "7600", 1, "26:30.0", "26:30.0", "finished"],
  [36, "PEDER", "NELSON", "Chanhassen HS", "100577947", "7548", 1, "26:33.6", "26:33.6", "finished"],
  [37, "LEVI", "BAHNEMANN", "Lake Area Composite", "100557173", "7597", 1, "26:44.4", "26:44.4", "finished"],
  [38, "GREGORY", "JAKOBLICH", "Lake Area Composite", "100564953", "7599", 1, "26:45.3", "26:45.3", "finished"],
  [39, "DOM", "KNORP", "Orono HS", "100562269", "7670", 1, "26:53.4", "26:53.4", "finished"],
  [40, "TREGG", "JONES", "Orono HS", "100565270", "7669", 1, "27:00.5", "27:00.5", "finished"],
  [41, "AIDEN", "CLARIN", "Lake Area Composite", "100574961", "7598", 1, "28:41.7", "28:41.7", "finished"],
  [42, "RICHIE", "BEUTZ", "Eden Prairie HS", "100574948", "7564", 1, "28:44.7", "28:44.7", "finished"],
  [43, "WALKER", "WENDLANDT", "Hutchinson Tigers", "100578206", "7594", 1, "29:46.0", "29:46.0", "finished"],
  [44, "RUCKER", "HITCHCOCK", "Osseo HS", "100575049", "7674", 1, "30:09.2", "30:09.2", "finished"],
  [45, "LYRA", "MIEL", "St Cloud", "100561729", "7714", 1, "30:26.5", "30:26.5", "finished"],
  [46, "BECKHAM", "BUESING", "Maple Grove HS", "100577280", "7610", 1, "30:34.7", "30:34.7", "finished"],
  [47, "COOPER", "HESTICK", "Maple Grove HS", "100579832", "7612", 1, "31:14.3", "31:14.3", "finished"],
  [48, "HENRY", "BAHLER", "Cannon Valley", "100563206", "7542", 1, "31:38.7", "31:38.7", "finished"],
]

#6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [1, "AXEL", "WOOD", "Minnetonka HS", "100561861", "7654", 1, "19:26.5", "19:26.5", "finished"],
  [2, "PHILLIP", "MAJKA", "Brainerd HS", "100568035", "7539", 1, "20:41.3", "20:41.3", "finished"],
  [3, "CALLUM", "MCARTHUR", "Minnetonka HS", "100565633", "7647", 1, "21:09.5", "21:09.5", "finished"],
  [4, "WINSTON", "TOFTNESS", "Crosby-Ironton HS", "100566190", "7557", 1, "21:10.7", "21:10.7", "finished"],
  [5, "FINNIAN", "ROARK", "Rock Ridge", "100561104", "7702", 1, "21:46.4", "21:46.4", "finished"],
  [6, "JAXON", "HEISER", "Alexandria Youth Cycling", "100575231", "7505", 1, "22:01.7", "22:01.7", "finished"],
  [7, "JADEN", "CENTANNI", "Mounds View HS", "100557139", "7656", 1, "22:03.2", "22:03.2", "finished"],
  [8, "KIERAN", "SCHIMNICH", "St Paul Central", "100557274", "7724", 1, "22:06.7", "22:06.7", "finished"],
  [9, "JACK", "REITHEL", "Minnetonka HS", "100561535", "7649", 1, "22:06.7", "22:06.7", "finished"],
  [10, "LEVI", "ANDERSON", "Minnetonka HS", "100563356", "7642", 1, "22:43.7", "22:43.7", "finished"],
  [11, "ABRAHAM", "FRANKE", "Brainerd HS", "100578571", "7538", 1, "22:46.8", "22:46.8", "finished"],
  [12, "SULLY", "RIESS", "Mounds View HS", "100564422", "7659", 1, "22:47.9", "22:47.9", "finished"],
  [13, "JACK", "JORGENSEN", "Cloquet-Esko-Carlton", "100558614", "7552", 1, "22:48.3", "22:48.3", "finished"],
  [14, "ROBERT", "MARK", "Minnetonka HS", "100562133", "7646", 1, "22:50.4", "22:50.4", "finished"],
  [15, "RYDER", "MILLER", "Minnetonka HS", "100563349", "7648", 1, "23:05.8", "23:05.8", "finished"],
  [16, "JACK", "FICEK", "Minnetonka HS", "100565756", "7643", 1, "23:19.0", "23:19.0", "finished"],
  [17, "THOR", "TOFTOY", "Minnetonka HS", "100565104", "7652", 1, "24:23.0", "24:23.0", "finished"],
  [18, "GEORGE", "BARTHEL", "Alexandria Youth Cycling", "100579561", "7501", 1, "24:41.1", "24:41.1", "finished"],
  [19, "MARTIN", "CAMPBELL", "Mounds View HS", "100564595", "7655", 1, "24:57.8", "24:57.8", "finished"],
  [20, "MICAH", "KLAETSCH", "Alexandria Youth Cycling", "100557147", "7506", 1, "24:57.9", "24:57.9", "finished"],
  [21, "BRECKEN", "MEDWAY", "Alexandria Youth Cycling", "100574562", "7507", 1, "25:03.2", "25:03.2", "finished"],
  [22, "EASTON", "SPILSETH", "Minnetonka HS", "100561712", "7650", 1, "25:03.3", "25:03.3", "finished"],
  [23, "WILLIAM", "CASS", "Alexandria Youth Cycling", "100576343", "7502", 1, "25:10.6", "25:10.6", "finished"],
  [24, "ALEX", "MUNYON", "Mounds View HS", "100565048", "7657", 1, "25:20.1", "25:20.1", "finished"],
  [25, "OWEN", "CORBETT", "Crosby-Ironton HS", "100557136", "7556", 1, "25:28.6", "25:28.6", "finished"],
  [26, "JAMES", "BABLER", "Crosby-Ironton HS", "100571175", "7555", 1, "25:34.5", "25:34.5", "finished"],
  [27, "GRIFFIN", "PETERSON", "Alexandria Youth Cycling", "100560455", "7508", 1, "25:43.8", "25:43.8", "finished"],
  [28, "JACKSON", "ROEHM", "Mounds View HS", "100557496", "7660", 1, "26:07.7", "26:07.7", "finished"],
  [29, "JAMESON", "DILLON", "Alexandria Youth Cycling", "100572708", "7503", 1, "26:15.2", "26:15.2", "finished"],
  [30, "SAMUEL", "RANKL", "Alexandria Youth Cycling", "100571677", "7510", 1, "26:25.0", "26:25.0", "finished"],
  [31, "DAVID", "LASHKOWITZ", "Minnetonka HS", "100565996", "7645", 1, "27:36.8", "27:36.8", "finished"],
  [32, "BODI", "CERISE", "Brainerd HS", "100571320", "7536", 1, "28:21.3", "28:21.3", "finished"],
  [33, "JOEL", "PRESTON", "Alexandria Youth Cycling", "100559044", "7509", 1, "28:39.8", "28:39.8", "finished"],
  [34, "EMMITT", "GOOD", "Alexandria Youth Cycling", "100577866", "7504", 1, "31:22.2", "31:22.2", "finished"],
  [35, "DOMINIC", "ALTRICHTER", "Minnetonka HS", "100565846", "7641", 1, "36:45.2", "36:45.2", "finished"],
  [36, "ANDERSON", "STEINER", "Minnetonka HS", "100561899", "7651", 1, "36:56.9", "36:56.9", "finished"],
  [37, "LUKE", "TUNGSETH", "Alexandria Youth Cycling", "100576962", "7511", 0, "", "", "dnf"],
]

#7th Grade Girls Results
results_7th_grade_girls = [
  [1, "MARIELLA", "ANDESON", "Eastview HS", "100532236", "6036", 1, "18:17.1", "18:17.1", "finished"],
  [2, "LUCIA", "DREVLOW", "Eastview HS", "100512776", "6033", 1, "18:23.2", "18:23.2", "finished"],
  [3, "SUMMIT", "BEUKEMA", "Rock Ridge", "100511314", "6079", 1, "19:07.9", "19:07.9", "finished"],
  [4, "CLARA", "WALZ", "Roseville", "100530811", "6085", 1, "19:34.3", "19:34.3", "finished"],
  [5, "MEGAN", "PIERSON", "Armstrong Cycle", "100521906", "6005", 1, "19:36.6", "19:36.6", "finished"],
  [6, "COURTNEY", "HOLLINBECK", "Armstrong Cycle", "100511875", "6003", 1, "19:40.3", "19:40.3", "finished"],
  [7, "OLIVE", "WILCOX", "Maple Grove HS", "100519538", "6054", 1, "20:08.4", "20:08.4", "finished"],
  [8, "MEGAN", "RYAN", "Brainerd HS", "100534426", "6017", 1, "20:36.7", "20:36.7", "finished"],
  [9, "GEMMA", "OBERDING", "Eastview HS", "100521787", "6037", 1, "21:26.3", "21:26.3", "finished"],
  [10, "NETTA", "WHEELER", "St Paul Central", "100514278", "6101", 1, "21:31.0", "21:31.0", "finished"],
  [11, "HARTLEY", "BIORN", "Maple Grove HS", "100530790", "6052", 1, "21:42.3", "21:42.3", "finished"],
  [12, "EMMA", "METSA", "Rock Ridge", "100567332", "6080", 1, "21:52.4", "21:52.4", "finished"],
  [13, "KINLEY", "KUHLMANN", "Minnetonka HS", "100520839", "6067", 1, "22:00.1", "22:00.1", "finished"],
  [14, "OLIVE", "THIESSEN", "St Cloud", "100534823", "6092", 1, "22:01.2", "22:01.2", "finished"],
  [15, "ADDY", "SCHILLING", "Bloomington Jefferson", "100511093", "6014", 1, "22:02.1", "22:02.1", "finished"],
  [16, "NATALIE", "SCHMIDT", "Minnetonka HS", "100522933", "6068", 1, "22:11.1", "22:11.1", "finished"],
  [17, "OLIVIA", "HOYORD", "Minnetonka HS", "100527853", "6066", 1, "22:12.9", "22:12.9", "finished"],
  [18, "BROOKE", "MIGLIORI", "Lakeville South HS", "100513290", "6050", 1, "22:18.6", "22:18.6", "finished"],
  [19, "TALIA", "TOUCHET", "Armstrong Cycle", "100521607", "6006", 1, "22:27.8", "22:27.8", "finished"],
  [20, "FREYA", "MOLLET", "St Louis Park HS", "100531804", "6095", 1, "22:49.5", "22:49.5", "finished"],
  [21, "ANNALEE", "KNOLLMAIER", "Bloomington Jefferson", "100510560", "6012", 1, "22:53.3", "22:53.3", "finished"],
  [22, "ELENA", "HENDRICKSON", "Cloquet-Esko-Carlton", "100516593", "6024", 1, "23:26.7", "23:26.7", "finished"],
  [23, "KATE", "EVANS", "Breck", "100566721", "6019", 1, "23:27.3", "23:27.3", "finished"],
  [24, "JULIANA", "SPAULDING", "Breck", "100566990", "6020", 1, "23:30.8", "23:30.8", "finished"],
  [25, "KATRINA", "BJERGAARD", "Totino Grace-Irondale", "100558884", "6110", 1, "23:31.0", "23:31.0", "finished"],
  [26, "EMELYN", "HENDRICKSON", "Cloquet-Esko-Carlton", "100516595", "6025", 1, "23:33.6", "23:33.6", "finished"],
  [27, "EDITH", "SCHULZ", "St Paul Central", "100577184", "6100", 1, "23:33.7", "23:33.7", "finished"],
  [28, "EVELYN", "EIGEN", "Alexandria Youth Cycling", "100532348", "6002", 1, "23:38.2", "23:38.2", "finished"],
  [29, "BRITTA", "DROOGSMA", "Rockford", "100510939", "6083", 1, "23:44.8", "23:44.8", "finished"],
  [30, "GWENDOLYN", "GUETTLER-JOHNSON", "Woodbury HS", "100516708", "6115", 1, "23:51.5", "23:51.5", "finished"],
  [31, "GWYNN", "MOON", "Brainerd HS", "100577115", "6016", 1, "24:11.9", "24:11.9", "finished"],
  [32, "LILJA", "BERGQUIST", "Bloomington", "100516074", "6010", 1, "24:26.6", "24:26.6", "finished"],
  [33, "GWEN", "MCGREEVY", "Bloomington Jefferson", "100532223", "6013", 1, "24:56.6", "24:56.6", "finished"],
  [34, "KIAH", "DROOGSMA", "Rockford", "100510943", "6084", 1, "25:22.3", "25:22.3", "finished"],
  [35, "AVERY", "BURKHART", "Maple Grove HS", "100577069", "6053", 1, "25:33.2", "25:33.2", "finished"],
  [36, "ADELLIE", "SZCZODROSKI", "Brainerd HS", "100579236", "6018", 1, "25:41.9", "25:41.9", "finished"],
  [37, "QUINN", "FARMER", "Mounds View HS", "100564123", "6069", 1, "25:50.1", "25:50.1", "finished"],
  [38, "ANNA", "MARTENSEN", "Brainerd HS", "100518416", "6015", 1, "26:30.1", "26:30.1", "finished"],
  [39, "IRIE", "KRONSTEDT", "Crosby-Ironton HS", "100577722", "6030", 1, "26:39.5", "26:39.5", "finished"],
  [40, "OLIVIA", "MILLER", "Crosby-Ironton HS", "100578532", "6031", 1, "27:00.4", "27:00.4", "finished"],
  [41, "ALLISON", "HAMILTON", "Crosby-Ironton HS", "100534870", "6029", 1, "27:08.2", "27:08.2", "finished"],
  [42, "MACIE", "STEINKE", "Crosby-Ironton HS", "100579749", "6032", 1, "27:27.6", "27:27.6", "finished"],
  [43, "EVERLEIGH", "CRUZE", "Alexandria Youth Cycling", "100571990", "6001", 1, "27:37.4", "27:37.4", "finished"],
  [44, "NORAH", "LAWSON", "East Ridge HS", "100510479", "6034", 1, "28:03.4", "28:03.4", "finished"],
  [45, "ELLIE", "NURMELA", "Lakeville North HS", "100522316", "6049", 1, "31:10.9", "31:10.9", "finished"],
  [46, "SYLVIANA", "BONCZYK", "Bloomington", "100559859", "6011", 1, "31:46.6", "31:46.6", "finished"],
  [47, "AMELIA", "OLSON", "Cloquet-Esko-Carlton", "100558400", "6027", 0, "", "", "dnf"],
  [48, "AUDII", "ROSANDICH", "Rock Ridge", "100532616", "6082", 0, "", "", "dnf"],
]

#7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [1, "QUINCY", "GROTENHUIS", "Lakeville South HS", "100521373", "6626", 1, "17:00.0", "17:00.0", "finished"],
  [2, "RYAN", "KOKOTOVICH", "Roseville", "100510797", "6745", 1, "17:09.5", "17:09.5", "finished"],
  [3, "LEVI", "HANSEN", "St Cloud", "100531503", "6755", 1, "17:18.8", "17:18.8", "finished"],
  [4, "TYLER", "TATE", "Orono HS", "100529334", "6703", 1, "17:36.4", "17:36.4", "finished"],
  [5, "EMIN", "ERENLER", "St Louis Park HS", "100517696", "6761", 1, "17:42.6", "17:42.6", "finished"],
  [6, "HENRY", "OSBURN", "Bloomington Jefferson", "100510972", "6532", 1, "18:14.3", "18:14.3", "finished"],
  [7, "HENRY", "BROUWER", "Rockford", "100513879", "6739", 1, "18:41.0", "18:41.0", "finished"],
  [8, "OLIN", "BUJOLD", "Tioga Trailblazers", "100489293", "6783", 1, "18:41.3", "18:41.3", "finished"],
  [9, "KAI", "LANDER", "Eastview HS", "100520776", "6584", 1, "18:48.9", "18:48.9", "finished"],
  [10, "WILL", "BAKKEN", "St Louis Park HS", "100516837", "6759", 1, "18:51.8", "18:51.8", "finished"],
  [11, "RHONE", "URBAN", "Rosemount HS", "100526006", "6741", 1, "18:52.9", "18:52.9", "finished"],
  [12, "NICK", "CAMPBELL", "Orono HS", "100535629", "6701", 1, "19:21.6", "19:21.6", "finished"],
  [13, "GAVIN", "TAYLOR", "Chaska HS", "100535430", "6558", 1, "19:38.9", "19:38.9", "finished"],
  [14, "JACOB", "PSHON", "St Louis Park HS", "100510609", "6766", 1, "19:53.4", "19:53.4", "finished"],
  [15, "CALEB", "MAXWELL", "Northwoods Cycling", "100576196", "6699", 1, "20:07.7", "20:07.7", "finished"],
  [16, "MADDEN", "LORENZ", "Lake Area Composite", "100532574", "6620", 1, "20:17.0", "20:17.0", "finished"],
  [17, "AIDEN", "SUTHERLAND", "Tioga Trailblazers", "100534292", "6786", 1, "20:20.1", "20:20.1", "finished"],
  [18, "TRISTEN", "PETERS", "Armstrong Cycle", "100522931", "6515", 1, "20:21.9", "20:21.9", "finished"],
  [19, "ELLIOT", "FREEMAN", "Roseville", "100530582", "6744", 1, "20:22.7", "20:22.7", "finished"],
  [20, "WILLEM", "SHELDON", "Minneapolis Northside", "100538513", "6635", 1, "20:23.4", "20:23.4", "finished"],
  [21, "JACK", "BOND", "Eden Prairie HS", "100534454", "6587", 1, "20:26.1", "20:26.1", "finished"],
  [22, "NEIL", "IMHOLTE", "Tioga Trailblazers", "100535255", "6784", 1, "20:27.9", "20:27.9", "finished"],
  [23, "LANDON", "MAXWELL", "Northwoods Cycling", "100576214", "6700", 1, "20:30.5", "20:30.5", "finished"],
  [24, "LEO", "LICK", "Tioga Trailblazers", "100569911", "6785", 1, "20:34.1", "20:34.1", "finished"],
  [25, "MERRICK", "HELGERSON", "Apple Valley HS", "100525046", "6511", 1, "20:54.0", "20:54.0", "finished"],
  [26, "GREYLIN", "CLINE", "Breck", "100535312", "6539", 1, "21:01.9", "21:01.9", "finished"],
  [27, "ELLIOT", "CURTIS", "St Louis Park HS", "100515026", "6760", 1, "21:09.0", "21:09.0", "finished"],
  [28, "JAX", "SCHILDGEN", "Lake Area Composite", "100532634", "6621", 1, "21:13.0", "21:13.0", "finished"],
  [29, "GILBERT", "NELSON", "Osseo Composite", "100528205", "6704", 1, "21:15.8", "21:15.8", "finished"],
  [30, "CHARLIE", "DIXON", "Roseville", "100521844", "6742", 1, "21:16.1", "21:16.1", "finished"],
  [31, "MORGAN", "PATTERSON", "Champlin Park HS", "100529670", "6550", 1, "21:18.8", "21:18.8", "finished"],
  [32, "SAM", "HEITMAN", "Hutchinson Tigers", "100521405", "6617", 1, "21:23.1", "21:23.1", "finished"],
  [33, "GEORGE", "MARTIN", "Bloomington", "100514224", "6526", 1, "21:25.5", "21:25.5", "finished"],
  [34, "OLIVER", "LEWIS", "Eastview HS", "100563409", "6585", 1, "21:26.3", "21:26.3", "finished"],
  [35, "VINCENT", "HOWE", "St Louis Park HS", "100534616", "6762", 1, "21:34.8", "21:34.8", "finished"],
  [36, "LEIF", "REED", "Eagan HS", "100517970", "6580", 1, "21:38.6", "21:38.6", "finished"],
  [37, "LUCAS", "PARKER", "Lakeville North HS", "100531562", "6625", 1, "21:49.4", "21:49.4", "finished"],
  [38, "OLIVER", "KOZICKI", "St Louis Park HS", "100526052", "6763", 1, "21:55.1", "21:55.1", "finished"],
  [39, "BENJAMIN", "BIRZNIEKS", "Rockford", "100568192", "6738", 1, "22:09.3", "22:09.3", "finished"],
  [40, "HENRY", "MEDHUS", "North Dakota", "100523070", "6697", 1, "22:14.4", "22:14.4", "finished"],
  [41, "EZEKIEL", "JOSTERUD", "Chaska HS", "100535951", "6557", 1, "22:18.1", "22:18.1", "finished"],
  [42, "EVAN", "HOPPE", "Champlin Park HS", "100576776", "6548", 1, "22:44.1", "22:44.1", "finished"],
  [43, "ANDERS", "DOLMAR", "Bloomington Jefferson", "100516525", "6531", 1, "22:44.8", "22:44.8", "finished"],
  [44, "REX", "NELSON", "Chanhassen HS", "100535767", "6553", 1, "22:47.9", "22:47.9", "finished"],
  [45, "JAMESON", "LA BARBERA", "St Louis Park HS", "100523472", "6764", 1, "22:50.6", "22:50.6", "finished"],
  [46, "CARSON", "HENTON", "Lake Area Composite", "100561347", "6619", 1, "22:53.9", "22:53.9", "finished"],
  [47, "SULLY", "VERDECK", "Bloomington", "100535361", "6527", 1, "22:54.6", "22:54.6", "finished"],
  [48, "ARCHER", "BRAASTAD", "Champlin Park HS", "100569652", "6547", 1, "22:55.3", "22:55.3", "finished"],
  [49, "JUHL", "SAKSTRUP", "Breck", "100563539", "6544", 1, "22:56.1", "22:56.1", "finished"],
  [50, "KAI", "RICHARDSON", "BBBikers", "100562155", "6522", 1, "22:56.5", "22:56.5", "finished"],
  [51, "ELI", "OWENS", "Mankato West HS", "100512534", "6630", 1, "22:57.7", "22:57.7", "finished"],
  [52, "GABRIEL", "CESARI", "Bloomington", "100531095", "6524", 1, "22:58.3", "22:58.3", "finished"],
  [53, "SAMUEL", "DYBVIG", "BBBikers", "100530115", "6519", 1, "22:59.9", "22:59.9", "finished"],
  [54, "PARKER", "ELSEN", "Bloomington", "100512134", "6525", 1, "22:59.9", "22:59.9", "finished"],
  [55, "ELI", "HAGLOF", "Totino Grace-Irondale", "100514481", "6787", 1, "23:01.4", "23:01.4", "finished"],
  [56, "JOAQUIN", "VILLALPANDO", "Roseville", "100530160", "6747", 1, "23:03.2", "23:03.2", "finished"],
  [57, "HARRISON", "YOUNG", "St Louis Park HS", "100522519", "6767", 1, "23:06.7", "23:06.7", "finished"],
  [58, "OWEN", "WETTERLUND", "Lake Area Composite", "100563945", "6622", 1, "23:20.1", "23:20.1", "finished"],
  [59, "BENJAMIN", "ZACHMANN", "St Michael / Albertville", "100577763", "6768", 1, "23:28.2", "23:28.2", "finished"],
  [60, "ODIN", "ARENDT", "Westonka", "100579657", "6796", 1, "23:49.8", "23:49.8", "finished"],
  [61, "CARTER", "CRANE", "Chanhassen HS", "100535579", "6551", 1, "23:54.5", "23:54.5", "finished"],
  [62, "LUKE", "DRUCKMAN", "Armstrong Cycle", "100530251", "6514", 1, "24:03.0", "24:03.0", "finished"],
  [63, "EERO", "DECOUX", "Cannon Valley", "100510780", "6546", 1, "24:08.1", "24:08.1", "finished"],
  [64, "QUINLAN", "DIETZ", "Maple Grove HS", "100571151", "6633", 1, "24:20.8", "24:20.8", "finished"],
  [65, "DREW", "BLAKELEY", "Maple Grove HS", "100567117", "6632", 1, "24:29.5", "24:29.5", "finished"],
  [66, "TEAGUE", "BENNETT", "Cannon Valley", "100576460", "6545", 1, "24:29.8", "24:29.8", "finished"],
  [67, "DECLAN", "NORDOS", "St Cloud", "100563160", "6756", 1, "24:31.9", "24:31.9", "finished"],
  [68, "CHARLES", "SIEKERT", "Eagan HS", "100562491", "6581", 1, "24:32.7", "24:32.7", "finished"],
  [69, "JENNINGS", "GALL", "St Cloud", "100561065", "6754", 1, "24:36.7", "24:36.7", "finished"],
  [70, "NOAH", "SCHULARICK", "Maple Grove HS", "100575088", "6634", 1, "24:54.2", "24:54.2", "finished"],
  [71, "HENRY", "HAUSCHILD", "Breck", "100518441", "6541", 1, "26:09.9", "26:09.9", "finished"],
  [72, "CHARLIE", "RAUCHMAN", "Park HS", "100561124", "6705", 1, "26:17.3", "26:17.3", "finished"],
  [73, "JOSHUA", "MILLS", "Westonka", "100565775", "6798", 1, "27:17.0", "27:17.0", "finished"],
  [74, "CARTER", "HANSON", "Chaska HS", "100519868", "6556", 1, "29:24.4", "29:24.4", "finished"],
  [75, "MATTHEW", "KRIESEL", "Totino Grace-Irondale", "100564705", "6788", 1, "30:33.5", "30:33.5", "finished"],
  [76, "RIO", "DE PAZ", "Rosemount HS", "100562774", "6578", 1, "32:00.0", "32:00.0", "finished"],
  [77, "MAX", "VON BANK", "Mankato West HS", "100532520", "6631", 1, "35:08.4", "35:08.4", "finished"],
  [78, "FRITZ", "FREY", "Rosemount HS", "100528778", "6740", 0, "", "", "dnf"],
  [79, "MARCUS", "FIEDLER", "BBBikers", "100530795", "6520", 0, "", "", "dnf"],
  [80, "BRYCE", "SCHAAF", "Lakeville South HS", "100525474", "6627", 0, "", "", "dnf"],
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