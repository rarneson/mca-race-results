require_relative '../../lib/race_data/race_seed_helpers'

# Include the shared helpers
include RaceData::RaceSeedHelpers

def get_expected_laps(category_name)
  category_data = CATEGORY_DATA.find { |cat| cat[:name] == category_name }
  category_data ? category_data[:laps] : 1
end

# ===============================================================================
# RACE DATA - RACE 4 - THEODORE WIRTH PARK (September 23, 2023)
# ===============================================================================

puts "Creating Race 4S - Theodore Wirth Park results..."

# Create the race
race = Race.find_or_create_by!(
  name: "Race 4S - Theodore Wirth Park",
  race_date: Date.parse("September 23, 2023")
) do |race|
  race.location = "Theodore Wirth Park"
  race.year = 2023
end

puts "✓ Race: #{race.name} (#{race.race_date})"

# ===============================================================================
# RACE RESULTS DATA
# ===============================================================================

# 6th Grade Girls Results
results_6th_grade_girls = [
  [ 1, "Kinsley", "Oberding", "Eagan HS", "100483262", "7026", 1, "00:15:33.494", "00:15:33.494", "finished" ],
  [ 2, "Willow", "Swanson", "St Louis Park HS", "100462803", "7080", 1, "00:16:03.660", "00:16:03.660", "finished" ],
  [ 3, "Jozie", "Olson", "Minneapolis Roosevelt HS", "100466226", "7053", 1, "00:16:06.793", "00:16:06.793", "finished" ],
  [ 4, "Jada", "Hollinbeck", "Armstrong Cycle", "100473324", "7005", 1, "00:16:08.694", "00:16:08.694", "finished" ],
  [ 5, "Abbey", "Milton", "St Louis Park HS", "100462787", "7077", 1, "00:16:14.695", "00:16:14.695", "finished" ],
  [ 6, "Laila", "Lind", "St Louis Park HS", "100464624", "7076", 1, "00:16:33.554", "00:16:33.554", "finished" ],
  [ 7, "Vivian", "Wood", "Minnetonka HS", "100478891", "7047", 1, "00:16:40.716", "00:16:40.716", "finished" ],
  [ 8, "Adi", "Malec", "Minnetonka HS", "100470068", "7045", 1, "00:17:07.191", "00:17:07.191", "finished" ],
  [ 9, "Isabel", "Kalm", "Mankato West HS", "100483933", "7043", 1, "00:17:29.161", "00:17:29.161", "finished" ],
  [ 10, "Josie", "Tripp", "Elk River", "100485259", "7036", 1, "00:17:34.505", "00:17:34.505", "finished" ],
  [ 11, "Mackenna", "Coopman", "Mankato West HS", "100483948", "7042", 1, "00:17:34.813", "00:17:34.813", "finished" ],
  [ 12, "Nia", "Thatcher", "Minneapolis Washburn HS", "100469450", "7058", 1, "00:17:48.782", "00:17:48.782", "finished" ],
  [ 13, "Eliza", "Kielsmeier-Cook", "Minneapolis Roosevelt HS", "100476258", "7052", 1, "00:17:50.644", "00:17:50.644", "finished" ],
  [ 14, "Adria", "Hanson", "Chaska HS", "100485628", "7018", 1, "00:18:43.737", "00:18:43.737", "finished" ],
  [ 15, "Simone", "Harayda", "St Louis Park HS", "100464438", "7074", 1, "00:18:48.787", "00:18:48.787", "finished" ],
  [ 16, "Elena", "Colianni", "Breck", "100473638", "7013", 1, "00:18:55.817", "00:18:55.817", "finished" ],
  [ 17, "Lauren", "Krans", "Hopkins HS", "100473796", "7037", 1, "00:19:08.683", "00:19:08.683", "finished" ],
  [ 18, "Anika", "Jones", "Minneapolis Washburn HS", "100463282", "7055", 1, "00:19:35.472", "00:19:35.472", "finished" ],
  [ 19, "Charlotte", "Perzynski", "Elk River", "100485234", "7035", 1, "00:19:51.477", "00:19:51.477", "finished" ],
  [ 20, "Lily", "Stutzman", "St Louis Park HS", "100474635", "7079", 1, "00:19:51.553", "00:19:51.553", "finished" ],
  [ 21, "Evelyn Rose", "Richmond", "Edina Cycling", "100474137", "7034", 1, "00:19:53.510", "00:19:53.510", "finished" ],
  [ 22, "Penelope", "Daum", "Mound Westonka", "100485817", "7048", 1, "00:20:39.745", "00:20:39.745", "finished" ],
  [ 23, "Payson", "Olson", "Minneapolis Roosevelt HS", "100470984", "7054", 1, "00:20:49.028", "00:20:49.028", "finished" ],
  [ 24, "Lila", "Younge", "Shakopee HS", "100475730", "7072", 1, "00:21:20.268", "00:21:20.268", "finished" ],
  [ 25, "Evelyn", "Scott", "Minneapolis Washburn HS", "100473010", "7057", 1, "00:21:36.023", "00:21:36.023", "finished" ],
  [ 26, "Ani", "Kenning", "Minneapolis Washburn HS", "100465089", "7056", 1, "00:22:09.812", "00:22:09.812", "finished" ],
  [ 27, "Macie", "Reese", "Mound Westonka", "100460146", "7049", 1, "00:22:22.284", "00:22:22.284", "finished" ],
  [ 28, "Cora", "Barringer", "Eagan HS", "100463699", "7024", 1, "00:22:22.289", "00:22:22.289", "finished" ],
  [ 29, "Isabel", "Calhoun-Lopez", "Minnetonka HS", "100482132", "7044", 1, "00:23:08.961", "00:23:08.961", "finished" ],
  [ 30, "Lauren", "McCann", "Hopkins HS", "100476201", "7038", 1, "00:23:33.078", "00:23:33.078", "finished" ],
  [ 31, "Lily", "Morgan", "Edina Cycling", "100472078", "7033", 1, "00:24:19.228", "00:24:19.228", "finished" ],
  [ 32, "Samantha", "Plantz", "Eastview HS", "100472355", "7031", 1, "00:24:41.270", "00:24:41.270", "finished" ],
  [ 33, "Poppy", "Kreykes", "Breck", "100485011", "7014", 0, "", "", "DNF" ],
  [ 34, "Molly", "McGuire", "Shakopee HS", "100483867", "7070", 0, "", "", "DNF" ]
]

# 6th Grade Boys D2 Results
results_6th_grade_boys_d2 = [
  [ 1, "Michael", "Reiner", "Eden Prairie HS", "100487675", "7558", 1, "00:15:51.383", "00:15:51.383", "finished" ],
  [ 2, "Logan", "Grundel", "Austin HS", "100460176", "7509", 1, "00:16:46.427", "00:16:46.427", "finished" ],
  [ 3, "Beckett", "McLaren", "Austin HS", "100481010", "7510", 1, "00:16:47.350", "00:16:47.350", "finished" ],
  [ 4, "Nolan", "McCabe", "St Louis Park HS", "100473357", "7677", 1, "00:16:53.021", "00:16:53.021", "finished" ],
  [ 5, "Sebastian", "Yanz", "Minneapolis Roosevelt HS", "100472100", "7626", 1, "00:17:16.495", "00:17:16.495", "finished" ],
  [ 6, "Brady", "Davis", "Chanhassen HS", "100487451", "7539", 1, "00:17:17.792", "00:17:17.792", "finished" ],
  [ 7, "Ian", "Graham", "Eastview HS", "100488932", "7554", 1, "00:17:18.983", "00:17:18.983", "finished" ],
  [ 8, "Jack", "Smith IV", "Eastview HS", "100468768", "7556", 1, "00:17:29.269", "00:17:29.269", "finished" ],
  [ 9, "Ian", "Murtha", "Minneapolis Roosevelt HS", "100476359", "7623", 1, "00:17:29.370", "00:17:29.370", "finished" ],
  [ 10, "Charlie", "Aanenson", "St Louis Park HS", "100485150", "7674", 1, "00:17:30.220", "00:17:30.220", "finished" ],
  [ 11, "Leo", "Hanson", "Mankato", "100482874", "7609", 1, "00:17:30.368", "00:17:30.368", "finished" ],
  [ 12, "Noah", "Bert", "Mahtomedi HS", "100474167", "7600", 1, "00:17:31.043", "00:17:31.043", "finished" ],
  [ 13, "Everett", "Edstrom", "St Louis Park HS", "100479530", "7675", 1, "00:17:33.036", "00:17:33.036", "finished" ],
  [ 14, "Dylan", "Jenner", "Elk River", "100482706", "7580", 1, "00:17:34.705", "00:17:34.705", "finished" ],
  [ 15, "Rocco", "Schettle", "Eastview HS", "100466294", "7555", 1, "00:17:35.629", "00:17:35.629", "finished" ],
  [ 16, "Kyle", "Grundhofer", "Chanhassen HS", "100487830", "7540", 1, "00:18:11.466", "00:18:11.466", "finished" ],
  [ 17, "Sawyer", "Janis", "St Louis Park HS", "100468465", "7676", 1, "00:18:29.919", "00:18:29.919", "finished" ],
  [ 18, "Caleb", "Scheff", "Elk River", "100476767", "7581", 1, "00:18:38.462", "00:18:38.462", "finished" ],
  [ 19, "Mason", "Miller", "Mahtomedi HS", "100476741", "7604", 1, "00:18:52.518", "00:18:52.518", "finished" ],
  [ 20, "Justin", "Berg", "Breck", "100479662", "7531", 1, "00:18:54.657", "00:18:54.657", "finished" ],
  [ 21, "Elliot", "Engeholm", "Minneapolis Roosevelt HS", "100423641", "7622", 1, "00:18:56.812", "00:18:56.812", "finished" ],
  [ 22, "Sasha", "Kohler", "Minneapolis South HS", "100470734", "7627", 1, "00:19:20.755", "00:19:20.755", "finished" ],
  [ 23, "Finnegan", "Triebenbach", "Minneapolis Roosevelt HS", "100473080", "7624", 1, "00:19:37.291", "00:19:37.291", "finished" ],
  [ 24, "Nathan", "Sinclair", "Hastings", "100480815", "7584", 1, "00:19:44.455", "00:19:44.455", "finished" ],
  [ 25, "Silas", "Bloom", "Mahtomedi HS", "100474505", "7601", 1, "00:20:15.775", "00:20:15.775", "finished" ],
  [ 26, "Bennett", "Warzecha", "Elk River", "100484984", "7582", 1, "00:20:45.976", "00:20:45.976", "finished" ],
  [ 27, "Michael", "Sand", "Austin HS", "100479202", "7511", 1, "00:21:48.714", "00:21:48.714", "finished" ],
  [ 28, "Franklin", "Fernandez", "Mahtomedi HS", "100486862", "7603", 1, "00:22:00.879", "00:22:00.879", "finished" ],
  [ 29, "Matthew", "Storkamp", "Hastings", "100482885", "7585", 1, "00:22:35.853", "00:22:35.853", "finished" ],
  [ 30, "Dexter", "Thao", "Mahtomedi HS", "100462539", "7606", 1, "00:24:16.443", "00:24:16.443", "finished" ],
  [ 31, "Foster", "Vosooney", "Mahtomedi HS", "100483257", "7607", 1, "00:26:33.631", "00:26:33.631", "finished" ]
]

# 6th Grade Boys D1 Results
results_6th_grade_boys_d1 = [
  [ 1, "Elliot", "Gruhn", "Hopkins HS", "100461645", "7586", 1, "00:15:49.755", "00:15:49.755", "finished" ],
  [ 2, "Heath", "Hentges", "Shakopee HS", "100475806", "7667", 1, "00:16:00.040", "00:16:00.040", "finished" ],
  [ 3, "Benjamin", "Kessen", "Minnetonka HS", "100470394", "7612", 1, "00:16:06.283", "00:16:06.283", "finished" ],
  [ 4, "Connor", "Simurdiak", "Minneapolis Southwest HS", "100462488", "7631", 1, "00:17:02.551", "00:17:02.551", "finished" ],
  [ 5, "Eil", "Northrop", "Minneapolis Washburn HS", "100464151", "7632", 1, "00:17:40.254", "00:17:40.254", "finished" ],
  [ 6, "Asher", "Prevost", "Hopkins HS", "100461654", "7588", 1, "00:17:41.057", "00:17:41.057", "finished" ],
  [ 7, "Asher", "Plante", "Hopkins HS", "100480802", "7587", 1, "00:18:09.425", "00:18:09.425", "finished" ],
  [ 8, "Francis", "Knobel", "Minneapolis Southwest HS", "100466559", "7629", 1, "00:18:15.558", "00:18:15.558", "finished" ],
  [ 9, "Will", "Vargo", "Minnetonka HS", "100470441", "7615", 1, "00:18:59.977", "00:18:59.977", "finished" ],
  [ 10, "Bennett", "Havlicek", "Shakopee HS", "100482346", "7666", 1, "00:19:00.003", "00:19:00.003", "finished" ],
  [ 11, "Trent", "Van Sloun", "Edina Cycling", "100473951", "7578", 1, "00:19:06.360", "00:19:06.360", "finished" ],
  [ 12, "Elijah", "Vega", "Minnetonka HS", "100470419", "7616", 1, "00:19:22.565", "00:19:22.565", "finished" ],
  [ 13, "Luke", "Johnson", "Armstrong Cycle", "100482608", "7507", 1, "00:19:35.580", "00:19:35.580", "finished" ],
  [ 14, "Linus", "Danielson", "Edina Cycling", "100473894", "7560", 1, "00:20:06.145", "00:20:06.145", "finished" ],
  [ 15, "Oliver", "Ambrose", "Edina Cycling", "100468474", "7559", 1, "00:20:06.257", "00:20:06.257", "finished" ],
  [ 16, "Benji", "Stoebner", "Edina Cycling", "100479947", "7575", 1, "00:20:43.814", "00:20:43.814", "finished" ],
  [ 17, "Charles", "Griffiths", "Edina Cycling", "100470407", "7563", 1, "00:20:46.242", "00:20:46.242", "finished" ],
  [ 18, "Nolan", "Simpson", "Edina Cycling", "100474277", "7572", 1, "00:21:12.485", "00:21:12.485", "finished" ],
  [ 19, "Rhys", "Schaefer", "Edina Cycling", "100473853", "7571", 1, "00:21:31.918", "00:21:31.918", "finished" ],
  [ 20, "Jack", "Zabel", "Edina Cycling", "100473326", "7579", 1, "00:21:42.863", "00:21:42.863", "finished" ],
  [ 21, "Leo", "Lennartson", "Minnetonka HS", "100483464", "7613", 1, "00:21:46.908", "00:21:46.908", "finished" ],
  [ 22, "Beckham", "Trigger", "Edina Cycling", "100467497", "7577", 1, "00:22:20.821", "00:22:20.821", "finished" ],
  [ 23, "Tommy", "Raine", "Edina Cycling", "100473330", "7570", 1, "00:22:27.502", "00:22:27.502", "finished" ],
  [ 24, "Maxim", "Komarenko", "Edina Cycling", "100478776", "7567", 1, "00:22:44.696", "00:22:44.696", "finished" ],
  [ 25, "Gael", "Fox", "Edina Cycling", "100471144", "7561", 1, "00:22:58.981", "00:22:58.981", "finished" ],
  [ 26, "Karl", "Knudson", "Edina Cycling", "100476719", "7566", 1, "00:23:12.373", "00:23:12.373", "finished" ],
  [ 27, "Robert", "Stinchcombe III", "Edina Cycling", "100471075", "7574", 1, "00:24:57.962", "00:24:57.962", "finished" ],
  [ 28, "Mackinley", "Northenscold", "Edina Cycling", "100474040", "7569", 1, "00:25:19.649", "00:25:19.649", "finished" ],
  [ 29, "Benjamin", "Skanse", "Edina Cycling", "100473812", "7573", 1, "00:25:43.696", "00:25:43.696", "finished" ]
]

# 7th Grade Girls Results
results_7th_grade_girls = [
  [ 1, "Reese", "Cutts", "Shakopee HS", "100406936", "6092", 1, "00:15:54.802", "00:15:54.802", "finished" ],
  [ 2, "Nara", "Black", "Minneapolis Southwest HS", "100408926", "6066", 1, "00:16:08.343", "00:16:08.343", "finished" ],
  [ 3, "Evelyn", "Hoppe", "Edina Cycling", "100411928", "6036", 1, "00:16:38.115", "00:16:38.115", "finished" ],
  [ 4, "Quinn", "Miller", "Minnetonka HS", "100427613", "6054", 1, "00:16:41.645", "00:16:41.645", "finished" ],
  [ 5, "Grace", "Makosky", "Minneapolis Southwest HS", "100408191", "6068", 1, "00:16:54.336", "00:16:54.336", "finished" ],
  [ 6, "Gemma", "Banks", "Elk River", "100428934", "6039", 1, "00:17:02.849", "00:17:02.849", "finished" ],
  [ 7, "Claire", "Straub", "Minnetonka HS", "100482260", "6055", 1, "00:17:14.528", "00:17:14.528", "finished" ],
  [ 8, "Sylvia", "Fehr", "Minneapolis Roosevelt HS", "100422029", "6062", 1, "00:17:51.531", "00:17:51.531", "finished" ],
  [ 9, "Grace", "Berseth", "Minneapolis Roosevelt HS", "100420622", "6060", 1, "00:17:52.034", "00:17:52.034", "finished" ],
  [ 10, "Regan", "Peterson", "Mound Westonka", "100419083", "6057", 1, "00:18:10.970", "00:18:10.970", "finished" ],
  [ 11, "Lucia", "Arneson", "Minneapolis Washburn HS", "100418807", "6070", 1, "00:18:11.279", "00:18:11.279", "finished" ],
  [ 12, "Lily", "Makosky", "Minneapolis Southwest HS", "100408211", "6069", 1, "00:18:16.303", "00:18:16.303", "finished" ],
  [ 13, "Lucy", "Grissman", "Hopkins HS", "100429919", "6042", 1, "00:18:16.647", "00:18:16.647", "finished" ],
  [ 14, "Violet", "Wood", "Edina Cycling", "100471607", "6038", 1, "00:18:31.683", "00:18:31.683", "finished" ],
  [ 15, "Camille", "Nesburg", "Chanhassen HS", "100406833", "6025", 1, "00:18:59.778", "00:18:59.778", "finished" ],
  [ 16, "Eliis", "Dwyer", "Rosemount HS", "100484001", "6088", 1, "00:19:00.186", "00:19:00.186", "finished" ],
  [ 17, "Aurora", "Heffelfinger", "Minneapolis Southwest HS", "100471056", "6067", 1, "00:19:43.270", "00:19:43.270", "finished" ],
  [ 18, "Quinn", "Bosman", "Minnetonka HS", "100471961", "6052", 1, "00:19:44.454", "00:19:44.454", "finished" ],
  [ 19, "Kaia", "Mayes", "Minnetonka HS", "100472580", "6053", 1, "00:19:45.359", "00:19:45.359", "finished" ],
  [ 20, "Meribelle", "Parks", "Austin HS", "100427563", "6006", 1, "00:20:12.577", "00:20:12.577", "finished" ],
  [ 21, "Aubrie", "Burrell", "Shakopee HS", "100417861", "6089", 1, "00:20:12.759", "00:20:12.759", "finished" ],
  [ 22, "Lucia", "Cedarleaf Dahl", "Minneapolis Roosevelt HS", "100422071", "6061", 1, "00:20:13.268", "00:20:13.268", "finished" ],
  [ 23, "Enza", "Murray Pezzella", "Minneapolis Roosevelt HS", "100423793", "6063", 1, "00:20:15.398", "00:20:15.398", "finished" ],
  [ 24, "Noelle", "Palmer", "Chanhassen HS", "100431533", "6026", 1, "00:20:38.481", "00:20:38.481", "finished" ],
  [ 25, "Zoe", "Ballenthin", "White Bear Lake HS", "100488851", "6105", 1, "00:21:04.353", "00:21:04.353", "finished" ],
  [ 26, "Sara", "Rosenthal", "Minneapolis Roosevelt HS", "100478575", "6064", 1, "00:21:15.788", "00:21:15.788", "finished" ],
  [ 27, "Natalie", "McCormack", "Elk River", "100422932", "6040", 1, "00:22:35.754", "00:22:35.754", "finished" ],
  [ 28, "Nina", "London", "BBBikers", "100471243", "6011", 1, "00:22:42.796", "00:22:42.796", "finished" ],
  [ 29, "Dae", "Olson", "Edina Cycling", "100462914", "6037", 1, "00:22:54.062", "00:22:54.062", "finished" ],
  [ 30, "Katelyn", "Burtyk", "Shakopee HS", "100483514", "6090", 1, "00:23:04.157", "00:23:04.157", "finished" ],
  [ 31, "Linnea", "Carlson", "Shakopee HS", "100484236", "6091", 1, "00:23:22.630", "00:23:22.630", "finished" ],
  [ 32, "Reese", "Jeremiason", "Orono HS", "100405929", "6073", 1, "00:23:26.950", "00:23:26.950", "finished" ],
  [ 33, "Scarlet", "Eder", "Mound Westonka", "100469619", "6056", 1, "00:23:30.477", "00:23:30.477", "finished" ]
]

# 7th Grade Boys D2 Results
results_7th_grade_boys_d2 = [
  [ 1, "Simon", "Brand", "Austin HS", "100412347", "6516", 1, "00:13:58.734", "00:13:58.734", "finished" ],
  [ 2, "Landon", "Maul", "BBBikers", "100421670", "6521", 1, "00:14:12.894", "00:14:12.894", "finished" ],
  [ 3, "Tyler", "Jennen", "Chisago Lakes", "100428873", "6551", 1, "00:14:19.841", "00:14:19.841", "finished" ],
  [ 4, "Tucker", "Houle", "Chisago Lakes", "100485327", "6550", 1, "00:14:38.818", "00:14:38.818", "finished" ],
  [ 5, "Jack", "Tate", "St Louis Park HS", "100482268", "6742", 1, "00:14:58.652", "00:14:58.652", "finished" ],
  [ 6, "Benny", "Ruzek", "St Louis Park HS", "100425959", "6741", 1, "00:15:11.524", "00:15:11.524", "finished" ],
  [ 7, "Nikita", "Grinberg", "Eagan HS", "100409203", "6560", 1, "00:15:27.872", "00:15:27.872", "finished" ],
  [ 8, "Luke", "Stutsman", "Mound Westonka", "100468490", "6633", 1, "00:15:32.148", "00:15:32.148", "finished" ],
  [ 9, "Ben", "Van De Ven", "Orono HS", "100466789", "6676", 1, "00:15:35.620", "00:15:35.620", "finished" ],
  [ 10, "Nico", "Mendez", "Minneapolis Roosevelt HS", "100408482", "6651", 1, "00:15:38.590", "00:15:38.590", "finished" ],
  [ 11, "Ethan", "Keller", "Rosemount HS", "100469600", "6720", 1, "00:15:39.819", "00:15:39.819", "finished" ],
  [ 12, "Liam", "Strong", "Eagan HS", "100422803", "6561", 1, "00:16:02.084", "00:16:02.084", "finished" ],
  [ 13, "Jack", "McKeand", "Orono HS", "100414551", "6675", 1, "00:16:02.290", "00:16:02.290", "finished" ],
  [ 14, "Noah", "Goodman", "Minneapolis Northside", "100489018", "6645", 1, "00:16:03.421", "00:16:03.421", "finished" ],
  [ 15, "Maxim", "Nagel", "Mahtomedi HS", "100478191", "6609", 1, "00:16:18.461", "00:16:18.461", "finished" ],
  [ 16, "Edwin", "Dill", "Minneapolis Roosevelt HS", "100464325", "6647", 1, "00:16:20.595", "00:16:20.595", "finished" ],
  [ 17, "Philip", "Gerlach", "St Louis Park HS", "100427328", "6738", 1, "00:16:21.501", "00:16:21.501", "finished" ],
  [ 18, "Jesse", "Landry", "Minneapolis Roosevelt HS", "100465376", "6649", 1, "00:16:27.412", "00:16:27.412", "finished" ],
  [ 19, "August", "Mayer", "Chaska HS", "100432243", "6546", 1, "00:16:31.900", "00:16:31.900", "finished" ],
  [ 20, "Josh", "Heitman", "Hutchinson Tigers", "100428853", "6599", 1, "00:16:55.861", "00:16:55.861", "finished" ],
  [ 21, "Wesley", "Stinson", "Minneapolis South HS", "100416728", "6654", 1, "00:17:01.325", "00:17:01.325", "finished" ],
  [ 22, "Isaac", "Marciniak", "Minneapolis Roosevelt HS", "100464027", "6650", 1, "00:17:20.811", "00:17:20.811", "finished" ],
  [ 23, "Callen", "Olson", "Mahtomedi HS", "100483636", "6610", 1, "00:17:23.997", "00:17:23.997", "finished" ],
  [ 24, "William", "Shea", "Minneapolis Roosevelt HS", "100466403", "6652", 1, "00:17:46.238", "00:17:46.238", "finished" ],
  [ 25, "Edward", "Nielsen", "Chisago Lakes", "100432439", "6552", 1, "00:17:46.426", "00:17:46.426", "finished" ],
  [ 26, "Byron", "Becker", "Minneapolis South HS", "100474173", "6653", 1, "00:17:46.724", "00:17:46.724", "finished" ],
  [ 27, "Shaner", "Fitzpatrick", "St Louis Park HS", "100426687", "6737", 1, "00:17:51.153", "00:17:51.153", "finished" ],
  [ 28, "Luke", "Wikstrom", "Apple Valley HS", "100466960", "6506", 1, "00:17:56.338", "00:17:56.338", "finished" ],
  [ 29, "Corbin", "Kipfer", "Minneapolis Southside", "100463469", "6656", 1, "00:17:56.564", "00:17:56.564", "finished" ],
  [ 30, "Bentley", "Full", "Elk River", "100487804", "6584", 1, "00:18:07.625", "00:18:07.625", "finished" ],
  [ 31, "Erik", "Oen", "St Michael / Albertville", "100426351", "6743", 1, "00:18:13.071", "00:18:13.071", "finished" ],
  [ 32, "James", "Bicek", "Minneapolis Roosevelt HS", "100479608", "6646", 1, "00:18:22.459", "00:18:22.459", "finished" ],
  [ 33, "Henry", "Swanson", "Chaska HS", "100464367", "6547", 1, "00:18:37.971", "00:18:37.971", "finished" ],
  [ 34, "Oz", "Honmyhr", "Mahtomedi HS", "100390913", "6607", 1, "00:18:45.631", "00:18:45.631", "finished" ],
  [ 35, "Pacey", "Angier", "St Louis Park HS", "100427285", "6736", 1, "00:18:51.065", "00:18:51.065", "finished" ],
  [ 36, "Myles", "Kelly", "St Louis Park HS", "100417652", "6740", 1, "00:19:08.757", "00:19:08.757", "finished" ],
  [ 37, "Nicholas", "Elizabeth", "Minneapolis Roosevelt HS", "100467001", "6648", 1, "00:19:41.174", "00:19:41.174", "finished" ],
  [ 38, "Brady", "Huss", "Rosemount HS", "100472880", "6719", 1, "00:19:45.170", "00:19:45.170", "finished" ],
  [ 39, "Carson", "Bretz", "Elk River", "100484771", "6583", 1, "00:19:59.526", "00:19:59.526", "finished" ],
  [ 40, "Sam", "Wright", "Chaska HS", "100431758", "6548", 1, "00:20:46.006", "00:20:46.006", "finished" ],
  [ 41, "Ronin", "Hammack", "St Louis Park HS", "100427546", "6739", 1, "00:21:04.786", "00:21:04.786", "finished" ],
  [ 42, "Tristan", "Thomas", "Rosemount HS", "100478245", "6723", 1, "00:25:24.894", "00:25:24.894", "finished" ],
  [ 43, "Odin", "Thompson", "Mound Westonka", "100482193", "6634", 1, "00:25:32.400", "00:25:32.400", "finished" ],
  [ 44, "Lucius", "Robb", "Rosemount HS", "100430313", "6722", 0, "", "", "DNF" ],
  [ 45, "Avery", "Barbeau", "Mankato West HS", "100428695", "6611", 0, "", "", "DNF" ]
]

# 7th Grade Boys D1 Results
results_7th_grade_boys_d1 = [
  [ 1, "Charlie", "Knutson", "Armstrong Cycle", "100428818", "6511", 1, "00:14:30.091", "00:14:30.091", "finished" ],
  [ 2, "Jackson", "Runck", "Minnetonka HS", "100405356", "6625", 1, "00:14:43.381", "00:14:43.381", "finished" ],
  [ 3, "DJ", "Severson", "Edina Cycling", "100420516", "6578", 1, "00:14:45.824", "00:14:45.824", "finished" ],
  [ 4, "Owen", "Riley", "Shakopee HS", "100411688", "6728", 1, "00:14:45.929", "00:14:45.929", "finished" ],
  [ 5, "Bennett", "Schmidt", "Minnetonka HS", "100406494", "6626", 1, "00:15:23.037", "00:15:23.037", "finished" ],
  [ 6, "Dain", "Peters", "Armstrong Cycle", "100476674", "6514", 1, "00:15:27.544", "00:15:27.544", "finished" ],
  [ 7, "Michael", "Payne", "Armstrong Cycle", "100487162", "6513", 1, "00:15:31.525", "00:15:31.525", "finished" ],
  [ 8, "Theodore", "Juffer", "Minneapolis Southwest HS", "100418066", "6658", 1, "00:15:50.274", "00:15:50.274", "finished" ],
  [ 9, "Geoffrey", "Ehlert", "Minneapolis Washburn HS", "100418984", "6663", 1, "00:15:58.796", "00:15:58.796", "finished" ],
  [ 10, "Ethan", "Thull", "Minnetonka HS", "100471549", "6630", 1, "00:15:59.233", "00:15:59.233", "finished" ],
  [ 11, "Makai", "Lund", "Shakopee HS", "100421262", "6727", 1, "00:16:08.179", "00:16:08.179", "finished" ],
  [ 12, "Bentley", "Stocksdale", "Minnetonka HS", "100428132", "6628", 1, "00:16:20.945", "00:16:20.945", "finished" ],
  [ 13, "Dexter", "Veneman", "Minneapolis Washburn HS", "100420383", "6669", 1, "00:16:21.678", "00:16:21.678", "finished" ],
  [ 14, "Arnav", "Singh", "Minneapolis Southwest HS", "100419609", "6660", 1, "00:16:21.779", "00:16:21.779", "finished" ],
  [ 15, "Tyler", "Hassis", "Armstrong Cycle", "100428895", "6509", 1, "00:16:29.301", "00:16:29.301", "finished" ],
  [ 16, "Oliver", "Schoeneck", "Minneapolis Washburn HS", "100421956", "6668", 1, "00:16:33.623", "00:16:33.623", "finished" ],
  [ 17, "Nolan", "Schroeder", "Shakopee HS", "100392531", "6731", 1, "00:16:35.590", "00:16:35.590", "finished" ],
  [ 18, "Finn", "Kohlmyer", "Minnetonka HS", "100405255", "6620", 1, "00:16:40.642", "00:16:40.642", "finished" ],
  [ 19, "Ezra", "Lowenthal Walsh", "Minneapolis Washburn HS", "100423727", "6665", 1, "00:16:42.665", "00:16:42.665", "finished" ],
  [ 20, "Simon", "Lennartson", "Minnetonka HS", "100483459", "6622", 1, "00:16:50.935", "00:16:50.935", "finished" ],
  [ 21, "Vincent", "Schanen", "Minneapolis Washburn HS", "100392473", "6667", 1, "00:17:18.982", "00:17:18.982", "finished" ],
  [ 22, "Alex", "Klukken", "Minnetonka HS", "100416195", "6619", 1, "00:17:25.943", "00:17:25.943", "finished" ],
  [ 23, "Maddox", "Bentley", "Edina Cycling", "100476861", "6570", 1, "00:17:26.170", "00:17:26.170", "finished" ],
  [ 24, "Brennan", "Eaton", "Minnetonka HS", "100472352", "6617", 1, "00:17:26.399", "00:17:26.399", "finished" ],
  [ 25, "Ethan", "Sachs", "Hopkins HS", "100469785", "6593", 1, "00:17:30.179", "00:17:30.179", "finished" ],
  [ 26, "Henry", "Christiaansen", "Edina Cycling", "100431599", "6571", 1, "00:17:32.120", "00:17:32.120", "finished" ],
  [ 27, "Vinny", "Caruso", "Minnetonka HS", "100407226", "6616", 1, "00:17:39.409", "00:17:39.409", "finished" ],
  [ 28, "Walker", "Barmann", "Edina Cycling", "100417518", "6569", 1, "00:17:56.272", "00:17:56.272", "finished" ],
  [ 29, "Everett", "Niemasz", "Minneapolis Southwest HS", "100462724", "6659", 1, "00:18:05.684", "00:18:05.684", "finished" ],
  [ 30, "Benjamin", "Kennedy", "Armstrong Cycle", "100485924", "6510", 1, "00:18:06.121", "00:18:06.121", "finished" ],
  [ 31, "Grant", "Schweitzer", "Edina Cycling", "100427334", "6577", 1, "00:18:38.506", "00:18:38.506", "finished", nil, "Warning - not following instructions" ],
  [ 32, "Finneas", "Orr", "Edina Cycling", "100478396", "6575", 1, "00:18:42.896", "00:18:42.896", "finished" ],
  [ 33, "Jacob", "Schnorr", "Shakopee HS", "100407448", "6730", 1, "00:18:50.665", "00:18:50.665", "finished" ],
  [ 34, "Cohen", "Juergens", "White Bear Lake HS", "100480763", "6780", 1, "00:18:53.495", "00:18:53.495", "finished" ],
  [ 35, "Max", "Erickson", "White Bear Lake HS", "100478629", "6779", 1, "00:19:08.120", "00:19:08.120", "finished" ],
  [ 36, "Quentin", "Maddy", "Minnetonka HS", "100471394", "6623", 1, "00:19:08.216", "00:19:08.216", "finished" ],
  [ 37, "Jackson", "Dery", "White Bear Lake HS", "100471447", "6778", 1, "00:19:30.204", "00:19:30.204", "finished" ],
  [ 38, "Gus", "Kraker", "Minnetonka HS", "100475062", "6621", 1, "00:19:50.623", "00:19:50.623", "finished" ],
  [ 39, "Connor", "Strickland", "Minnetonka HS", "100405277", "6629", 1, "00:20:33.089", "00:20:33.089", "finished" ],
  [ 40, "Anders", "Thielen", "Minneapolis Southwest HS", "100462816", "6661", 1, "00:21:11.859", "00:21:11.859", "finished", nil, "Warning - Reckless riding" ],
  [ 41, "Luke", "Hassell", "Minneapolis Washburn HS", "100472171", "6664", 1, "00:21:16.061", "00:21:16.061", "finished" ],
  [ 42, "Carter", "Havlicek", "Shakopee HS", "100486028", "6726", 1, "00:21:27.550", "00:21:27.550", "finished" ],
  [ 43, "Carson", "Shopbell", "Minnetonka HS", "100417188", "6627", 1, "00:22:57.985", "00:22:57.985", "finished" ],
  [ 44, "David", "Healy", "Minnetonka HS", "100484612", "6618", 1, "00:23:38.683", "00:23:38.683", "finished" ]
]

# 8th Grade Girls Results
results_8th_grade_girls = [
  [ 1, "Sydney", "Bullard", "Edina Cycling", "100389830", "5023", 1, "00:14:56.902", "00:14:56.902", "finished" ],
  [ 2, "Maeve", "Thatcher", "Minneapolis Washburn HS", "100392834", "5062", 1, "00:15:22.968", "00:15:22.968", "finished" ],
  [ 3, "Elle", "Lynch", "Minneapolis Southwest HS", "100409012", "5056", 1, "00:16:12.385", "00:16:12.385", "finished" ],
  [ 4, "Ava", "Northrop", "Minneapolis Washburn HS", "100391948", "5060", 1, "00:16:12.767", "00:16:12.767", "finished" ],
  [ 5, "Greta", "Nygren", "Hopkins HS", "100391958", "5032", 1, "00:16:37.465", "00:16:37.465", "finished" ],
  [ 6, "Alice", "Saewert", "Minnetonka HS", "100407083", "5043", 1, "00:16:41.218", "00:16:41.218", "finished" ],
  [ 7, "Josie", "Schroeder", "Hopkins HS", "100392529", "5033", 1, "00:16:45.532", "00:16:45.532", "finished" ],
  [ 8, "Bayly", "Wasmer", "Minneapolis Washburn HS", "100393061", "5063", 1, "00:16:49.354", "00:16:49.354", "finished" ],
  [ 9, "Sarah", "Pottenger", "Mankato", "100392207", "5037", 1, "00:17:03.260", "00:17:03.260", "finished" ],
  [ 10, "Avery", "Nolin", "BBBikers", "100391939", "5004", 1, "00:17:08.503", "00:17:08.503", "finished" ],
  [ 11, "Lydia", "Michals", "Hopkins HS", "100422641", "5031", 1, "00:17:08.612", "00:17:08.612", "finished" ],
  [ 12, "Maya", "Schramm", "Minneapolis Southwest HS", "100417451", "5059", 1, "00:17:18.830", "00:17:18.830", "finished" ],
  [ 13, "June", "Leffingwell", "St Michael / Albertville", "100488124", "5081", 1, "00:17:19.169", "00:17:19.169", "finished" ],
  [ 14, "Penelope", "Pernitz", "Minneapolis Roosevelt HS", "100418268", "5053", 1, "00:17:19.329", "00:17:19.329", "finished" ],
  [ 15, "Tessa", "Kalm", "Mankato West HS", "100391132", "5038", 1, "00:17:19.835", "00:17:19.835", "finished" ],
  [ 16, "Isabella", "Bergman", "Minneapolis Southside", "100418895", "5054", 1, "00:17:27.121", "00:17:27.121", "finished" ],
  [ 17, "Monique", "Konotopka", "Chaska HS", "100391250", "5011", 1, "00:17:29.380", "00:17:29.380", "finished" ],
  [ 18, "Lydia", "Vargo", "Minnetonka HS", "100405328", "5044", 1, "00:17:57.997", "00:17:57.997", "finished" ],
  [ 19, "Makenzie", "Reese", "Mound Westonka", "100414842", "5045", 1, "00:18:10.213", "00:18:10.213", "finished" ],
  [ 20, "Elizabeth", "Gabler", "Edina Cycling", "100390478", "5024", 1, "00:18:10.931", "00:18:10.931", "finished" ],
  [ 21, "Ella", "Albu", "Minneapolis Southwest HS", "100466302", "5055", 1, "00:18:16.307", "00:18:16.307", "finished" ],
  [ 22, "Sloane", "Petersen", "Minneapolis Southwest HS", "100476306", "5058", 1, "00:19:01.358", "00:19:01.358", "finished" ],
  [ 23, "Meredith", "McCue", "Edina Cycling", "100435104", "5026", 1, "00:19:15.514", "00:19:15.514", "finished" ],
  [ 24, "Adeline", "Wrecza", "Hopkins HS", "100432688", "5034", 1, "00:19:50.327", "00:19:50.327", "finished" ],
  [ 25, "Mikka", "Schaefer", "Edina Cycling", "100478190", "5028", 1, "00:23:11.184", "00:23:11.184", "finished" ],
  [ 26, "Addison", "Deutsch", "Shakopee HS", "100427539", "5078", 1, "00:24:15.020", "00:24:15.020", "finished" ],
  [ 27, "Sylvia", "Klein", "Shakopee HS", "100391219", "5079", 1, "00:36:11.013", "00:36:11.013", "finished" ]
]

# 8th Grade Boys D2 Results
results_8th_grade_boys_d2 = [
  [ 1, "Ben", "Tesch", "Minneapolis Roosevelt HS", "100419911", "5463", 1, "00:12:58.989", "00:12:58.989", "finished" ],
  [ 2, "Eli", "Meiser", "Minneapolis Roosevelt HS", "100410036", "5461", 1, "00:13:16.413", "00:13:16.413", "finished" ],
  [ 3, "Jack", "Milton", "St Louis Park HS", "100391759", "5570", 1, "00:13:33.716", "00:13:33.716", "finished" ],
  [ 4, "Alex", "Chouanard", "St Michael / Albertville", "100389947", "5573", 1, "00:13:47.120", "00:13:47.120", "finished" ],
  [ 5, "Caleb", "Lyon", "Eagan HS", "100391529", "5374", 1, "00:13:53.966", "00:13:53.966", "finished" ],
  [ 6, "Franklin", "Rech", "Hutchinson Tigers", "100392277", "5407", 1, "00:14:02.542", "00:14:02.542", "finished" ],
  [ 7, "Isaac", "Stewart", "Orono HS", "100467267", "5502", 1, "00:14:03.661", "00:14:03.661", "finished" ],
  [ 8, "Sam", "Allan", "Rosemount HS", "100389410", "5544", 1, "00:14:26.660", "00:14:26.660", "finished" ],
  [ 9, "Liam", "Linnett", "Austin HS", "100408803", "5316", 1, "00:14:26.745", "00:14:26.745", "finished" ],
  [ 10, "Isaac", "Foley", "Eden Prairie HS", "100390397", "5381", 1, "00:14:36.702", "00:14:36.702", "finished" ],
  [ 11, "Mason", "Dealwis", "Chanhassen HS", "100413120", "5343", 1, "00:14:37.320", "00:14:37.320", "finished" ],
  [ 12, "Tyler", "Hanson", "Elk River", "100390709", "5393", 1, "00:14:42.848", "00:14:42.848", "finished" ],
  [ 13, "Jackson", "Schettle", "Eastview HS", "100427123", "5380", 1, "00:14:43.658", "00:14:43.658", "finished" ],
  [ 14, "Henry", "Reinsch", "Chaska HS", "100392299", "5347", 1, "00:14:44.169", "00:14:44.169", "finished" ],
  [ 15, "Noah", "Miller-Fimpel", "Minneapolis Southside", "100468392", "5468", 1, "00:14:45.905", "00:14:45.905", "finished" ],
  [ 16, "Ethan", "McDonald", "Mound Westonka", "100423781", "5444", 1, "00:15:41.817", "00:15:41.817", "finished" ],
  [ 17, "Samuel", "Kimpton", "St Louis Park HS", "100432259", "5569", 1, "00:15:42.122", "00:15:42.122", "finished" ],
  [ 18, "Espen", "Mollet", "St Louis Park HS", "100426882", "5571", 1, "00:15:50.473", "00:15:50.473", "finished" ],
  [ 19, "Devon", "Colliton", "Minneapolis South HS", "100472971", "5464", 1, "00:15:57.160", "00:15:57.160", "finished" ],
  [ 20, "William", "Burns", "Orono HS", "100388092", "5495", 1, "00:16:00.536", "00:16:00.536", "finished" ],
  [ 21, "Mikhail", "Long", "Orono HS", "100413722", "5500", 1, "00:16:00.919", "00:16:00.919", "finished" ],
  [ 22, "Avi", "Herman", "St Louis Park HS", "100473867", "5568", 1, "00:16:08.300", "00:16:08.300", "finished" ],
  [ 23, "Julian", "Engeholm", "Minneapolis Roosevelt HS", "100423642", "5458", 1, "00:16:09.722", "00:16:09.722", "finished" ],
  [ 24, "Sam", "Van Horn", "Breck", "100392981", "5337", 1, "00:16:12.433", "00:16:12.433", "finished" ],
  [ 25, "Ian", "Carolan", "Austin HS", "100389902", "5638", 1, "00:16:16.845", "00:16:16.845", "finished" ],
  [ 26, "Bjorn", "Helgerson", "Apple Valley HS", "100428526", "5312", 1, "00:16:21.107", "00:16:21.107", "finished" ],
  [ 27, "Rocco", "Kreykes", "Breck", "100485903", "5335", 1, "00:16:27.632", "00:16:27.632", "finished" ],
  [ 28, "Owen", "Florey", "Minneapolis Roosevelt HS", "100419996", "5459", 1, "00:16:31.385", "00:16:31.385", "finished" ],
  [ 29, "Caleb", "Fanning", "Minneapolis Southside", "100476762", "5466", 1, "00:16:37.229", "00:16:37.229", "finished" ],
  [ 30, "Jonah", "Holliday", "Minneapolis Roosevelt HS", "100409031", "5460", 1, "00:16:39.565", "00:16:39.565", "finished" ],
  [ 31, "Alexander", "Knorp", "Orono HS", "100424498", "5498", 1, "00:17:00.929", "00:17:00.929", "finished" ],
  [ 32, "Logen", "Mayer", "Mound Westonka", "100432092", "5443", 1, "00:17:01.753", "00:17:01.753", "finished" ],
  [ 33, "Liam", "Weber", "Elk River", "100389305", "5394", 1, "00:17:11.293", "00:17:11.293", "finished" ],
  [ 34, "Brody", "Gullickson", "Mankato West HS", "100483804", "5419", 1, "00:17:18.551", "00:17:18.551", "finished" ],
  [ 35, "Frank", "Cossetta", "Eagan HS", "100477771", "5371", 1, "00:17:26.584", "00:17:26.584", "finished" ],
  [ 36, "Nick", "Castagneri", "Elk River", "100389916", "5392", 1, "00:17:27.501", "00:17:27.501", "finished" ],
  [ 37, "Richard", "Morley", "Rosemount HS", "100478135", "5548", 1, "00:17:38.053", "00:17:38.053", "finished" ],
  [ 38, "Mitchell", "Davies", "Rosemount HS", "100485557", "5546", 1, "00:17:38.835", "00:17:38.835", "finished" ],
  [ 39, "Rowan", "Hagerty", "Eagan HS", "100468200", "5373", 1, "00:17:45.354", "00:17:45.354", "finished" ],
  [ 40, "Rainer", "Seibold", "Minneapolis Roosevelt HS", "100462905", "5462", 1, "00:17:45.399", "00:17:45.399", "finished" ],
  [ 41, "Bergen", "Dankey", "Orono HS", "100482858", "5496", 1, "00:17:46.141", "00:17:46.141", "finished" ],
  [ 42, "Henry", "Barto", "St Louis Park HS", "100482344", "5567", 1, "00:17:53.390", "00:17:53.390", "finished" ],
  [ 43, "Tatum", "Bahnemann", "Chisago Lakes", "100485091", "5350", 1, "00:18:25.008", "00:18:25.008", "finished" ],
  [ 44, "William", "Spaulding", "Breck", "100480502", "5336", 1, "00:18:41.252", "00:18:41.252", "finished" ],
  [ 45, "Nicholas", "Miziorko", "Eagan HS", "100391769", "5375", 1, "00:18:42.991", "00:18:42.991", "finished" ],
  [ 46, "Cameron", "Hanson", "Chaska HS", "100390698", "5345", 1, "00:18:59.007", "00:18:59.007", "finished" ],
  [ 47, "Parker", "Stotko", "Eagan HS", "100428638", "5378", 1, "00:19:40.883", "00:19:40.883", "finished" ],
  [ 48, "Charles", "Smith", "Mound Westonka", "100475853", "5446", 1, "00:19:50.328", "00:19:50.328", "finished" ],
  [ 49, "Noah", "Siekert", "Eagan HS", "100465960", "5377", 1, "00:21:33.958", "00:21:33.958", "finished" ],
  [ 50, "Reid", "Berntsen", "Rosemount HS", "100484473", "5545", 1, "00:21:51.332", "00:21:51.332", "finished" ],
  [ 51, "Erik", "Vanminsel", "Apple Valley HS", "100488748", "5313", 1, "00:22:22.314", "00:22:22.314", "finished" ],
  [ 52, "Noah", "Hillebert", "Mound Westonka", "100419282", "5442", 1, "00:25:36.966", "00:25:36.966", "finished" ]
]

# 8th Grade Boys D1 Results
results_8th_grade_boys_d1 = [
  [ 1, "Benno", "Sasanfar", "Minnetonka HS", "100392456", "5436", 1, "00:13:01.855", "00:13:01.855", "finished" ],
  [ 2, "Steffan", "Drekonja", "Minneapolis Washburn HS", "100390203", "5479", 1, "00:13:19.917", "00:13:19.917", "finished" ],
  [ 3, "Charlie", "Gruhn", "Hopkins HS", "100390620", "5397", 1, "00:14:28.449", "00:14:28.449", "finished" ],
  [ 4, "Reid", "Thurbush", "Minnetonka HS", "100392860", "5439", 1, "00:14:31.307", "00:14:31.307", "finished" ],
  [ 5, "Benjamin", "Luessi", "Minnetonka HS", "100391518", "5433", 1, "00:14:36.941", "00:14:36.941", "finished" ],
  [ 6, "Isaac", "Trachtenberg", "Minneapolis Southwest HS", "100409323", "5478", 1, "00:14:37.258", "00:14:37.258", "finished" ],
  [ 7, "Hunter", "Hollinbeck", "Armstrong Cycle", "100429319", "5314", 1, "00:14:37.973", "00:14:37.973", "finished" ],
  [ 8, "Bennett", "Turpin", "Minnetonka HS", "100392942", "5440", 1, "00:14:49.431", "00:14:49.431", "finished" ],
  [ 9, "Jasper", "Nelsen", "Minneapolis Southwest HS", "100421584", "5474", 1, "00:14:54.919", "00:14:54.919", "finished" ],
  [ 10, "Andrew", "Johnson", "Shakopee HS", "100391038", "5558", 1, "00:14:56.381", "00:14:56.381", "finished" ],
  [ 11, "Griffin", "Woeste", "Hopkins HS", "100420454", "5401", 1, "00:15:15.272", "00:15:15.272", "finished" ],
  [ 12, "Blake", "Orrben", "Shakopee HS", "100412148", "5560", 1, "00:15:17.835", "00:15:17.835", "finished" ],
  [ 13, "Ted", "Salmen", "Edina Cycling", "100421789", "5390", 1, "00:15:29.224", "00:15:29.224", "finished" ],
  [ 14, "Toby", "Bruhn", "White Bear Lake HS", "100478597", "5622", 1, "00:15:40.293", "00:15:40.293", "finished" ],
  [ 15, "Ian", "Gifford", "Minnetonka HS", "100404805", "5427", 1, "00:15:41.127", "00:15:41.127", "finished" ],
  [ 16, "Riley", "Coleman", "Minnetonka HS", "100471247", "5423", 1, "00:15:41.734", "00:15:41.734", "finished" ],
  [ 17, "Simon", "Foster", "Minnetonka HS", "100406799", "5426", 1, "00:15:42.183", "00:15:42.183", "finished" ],
  [ 18, "Ethan", "Roesner", "Minnetonka HS", "100473072", "5435", 1, "00:15:51.462", "00:15:51.462", "finished" ],
  [ 19, "Miles", "Hilker", "Minnetonka HS", "100421102", "5432", 1, "00:15:58.990", "00:15:58.990", "finished" ],
  [ 20, "Levi", "Leida", "Edina Cycling", "100391419", "5389", 1, "00:16:18.711", "00:16:18.711", "finished" ],
  [ 21, "Sam", "Coughlin", "Minnetonka HS", "100485509", "5424", 1, "00:16:18.816", "00:16:18.816", "finished" ],
  [ 22, "Jesse", "Hansen", "Minnetonka HS", "100476503", "5429", 1, "00:16:21.830", "00:16:21.830", "finished" ],
  [ 23, "Caeden", "Head", "Minnetonka HS", "100473045", "5430", 1, "00:16:29.907", "00:16:29.907", "finished" ],
  [ 24, "Bryce", "Bisson", "Minnetonka HS", "100482501", "5422", 1, "00:16:31.948", "00:16:31.948", "finished" ],
  [ 25, "Levi", "Froyum", "Shakopee HS", "100408841", "5555", 1, "00:16:40.820", "00:16:40.820", "finished" ],
  [ 26, "Evan", "Pauly", "Minnetonka HS", "100418613", "5434", 1, "00:17:02.688", "00:17:02.688", "finished" ],
  [ 27, "Paul", "Tiziou", "Hopkins HS", "100473550", "5399", 1, "00:17:12.381", "00:17:12.381", "finished" ],
  [ 28, "Rowan", "Eaton", "Hopkins HS", "100437781", "5396", 1, "00:17:17.633", "00:17:17.633", "finished" ],
  [ 29, "Nicholas", "Bowers", "Edina Cycling", "100437099", "5386", 1, "00:17:21.791", "00:17:21.791", "finished" ],
  [ 30, "Ethan", "Markes", "Shakopee HS", "100421305", "5559", 1, "00:17:29.788", "00:17:29.788", "finished" ],
  [ 31, "Dominic", "Ramm", "Shakopee HS", "100482326", "5561", 1, "00:17:40.620", "00:17:40.620", "finished" ],
  [ 32, "Seth", "Vlieger", "White Bear Lake HS", "100478884", "5628", 1, "00:17:44.359", "00:17:44.359", "finished" ],
  [ 33, "Aaron", "Berge", "Edina Cycling", "100389632", "5385", 1, "00:17:56.703", "00:17:56.703", "finished" ],
  [ 34, "Keanen", "Enz", "White Bear Lake HS", "100485130", "5625", 1, "00:18:04.160", "00:18:04.160", "finished" ],
  [ 35, "Roman", "Friese", "Minneapolis Southwest HS", "100464713", "5470", 1, "00:18:05.200", "00:18:05.200", "finished" ],
  [ 36, "Jasper", "Carlson", "White Bear Lake HS", "100477803", "5623", 1, "00:18:07.650", "00:18:07.650", "finished" ],
  [ 37, "Lukas", "Dierker", "Hopkins HS", "100432706", "5395", 1, "00:18:08.275", "00:18:08.275", "finished" ],
  [ 38, "Owen", "Higgins", "Minnetonka HS", "100424393", "5431", 1, "00:18:19.194", "00:18:19.194", "finished" ],
  [ 39, "Ryan", "Glick", "White Bear Lake HS", "100418426", "5626", 1, "00:18:21.647", "00:18:21.647", "finished" ],
  [ 40, "Kaelan", "Simurdiak", "Minneapolis Southwest HS", "100392617", "5477", 1, "00:18:42.051", "00:18:42.051", "finished" ],
  [ 41, "Max", "Weier", "Hopkins HS", "100438016", "5400", 1, "00:18:59.349", "00:18:59.349", "finished" ],
  [ 42, "Calvin", "Seim", "Edina Cycling", "100423440", "5391", 1, "00:19:09.588", "00:19:09.588", "finished" ],
  [ 43, "Jacob", "Scherschligt", "Minnetonka HS", "100468224", "5437", 1, "00:19:09.685", "00:19:09.685", "finished" ],
  [ 44, "Mark", "Johnson", "Minneapolis Washburn HS", "100421434", "5481", 1, "00:19:11.992", "00:19:11.992", "finished" ],
  [ 45, "Frank", "Snider", "Minnetonka HS", "100413369", "5438", 1, "00:19:44.038", "00:19:44.038", "finished" ],
  [ 46, "Ike", "Davidson", "Minnetonka HS", "100390101", "5425", 1, "00:20:53.050", "00:20:53.050", "finished" ],
  [ 47, "Rock", "Hummel", "Shakopee HS", "100390950", "5557", 1, "00:20:54.056", "00:20:54.056", "finished" ],
  [ 48, "Jacob", "Ward", "Minneapolis Washburn HS", "100393057", "5485", 1, "00:20:54.368", "00:20:54.368", "finished" ],
  [ 49, "Oleg", "Komarenko", "Edina Cycling", "100473819", "5387", 1, "00:21:22.646", "00:21:22.646", "finished" ],
  [ 50, "Julian", "Swarthout", "Minneapolis Washburn HS", "100479306", "5484", 1, "00:22:21.581", "00:22:21.581", "finished" ]
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

puts "\n🎉 Race 4 - Theodore Wirth Park seed data created successfully!"
puts "Total racers imported: #{RaceResult.where(race: race).count}"
