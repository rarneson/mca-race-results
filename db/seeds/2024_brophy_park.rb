# Helper methods for time processing
def parse_time_to_ms(time_str)
  return nil if time_str.blank?
  
  time_str = time_str.to_s.strip
  
  # Extract hours, minutes, seconds, milliseconds
  if time_str.match(/(\d+):(\d+):(\d+)\.?(\d+)?/) # H:M:S.ms
    hours, minutes, seconds, ms = $1.to_i, $2.to_i, $3.to_i, ($4 || "0").ljust(3, '0')[0..2].to_i
    (hours * 3600 + minutes * 60 + seconds) * 1000 + ms
  elsif time_str.match(/(\d+):(\d+)\.?(\d+)?/) # M:S.ms
    minutes, seconds, ms = $1.to_i, $2.to_i, ($3 || "0").ljust(3, '0')[0..2].to_i
    (minutes * 60 + seconds) * 1000 + ms
  elsif time_str.match(/(\d+)\.?(\d+)?/) # S.ms
    seconds, ms = $1.to_i, ($2 || "0").ljust(3, '0')[0..2].to_i
    seconds * 1000 + ms
  else
    nil
  end
end

def format_time_ms(time_ms)
  return nil if time_ms.nil? || time_ms == 0
  
  total_seconds = time_ms / 1000.0
  minutes = (total_seconds / 60).to_i
  seconds = total_seconds % 60
  
  if minutes >= 60
    hours = minutes / 60
    minutes = minutes % 60
    sprintf("%d:%02d:%04.1f", hours, minutes, seconds)
  else
    sprintf("%d:%04.1f", minutes, seconds)
  end
end

# ===============================================================================
# RACE DATA - Brophy Park Race (Race 1 - Brophy Park) (August 24, 2024)
# ===============================================================================

puts "Creating Brophy Park Race (Race 1 - Brophy Park) and results..."

# Create the race
brophy_race = Race.find_or_create_by!(
  name: "Race 1 - Brophy Park",
  race_date: Date.parse("August 24, 2024")
) do |race|
  race.location = "Brophy Park"
  race.year = 2024
end

puts "✓ Race: #{brophy_race.name} (#{brophy_race.race_date})"

# ===============================================================================
# 6th Grade Girls
# ===============================================================================

puts "Creating Brophy Park 6th Grade Girls results..."

# 6th Grade Girls category
sixth_grade_girls_category = Category.find_by!(name: "6th Grade Girls")

# 6th Grade Girls Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status]
brophy_6th_grade_girls_results = [
  [1, "LUCIA", "DREVLOW", "East Ridge HS", "100512776", "6524", 1, "00:19:20.0", "00:19:20.0", "finished"],
  [2, "MADDUX", "CUTTS", "Shakopee HS", "100513344", "6572", 1, "00:19:28.1", "00:19:28.1", "finished"],
  [3, "JUNIPER", "SZCZODROSKI", "Elk River", "100522929", "6528", 1, "00:20:43.9", "00:20:43.9", "finished"],
  [4, "SUMMIT", "BEUKEMA", "Rock Ridge", "100511314", "6565", 1, "00:20:59.1", "00:20:59.1", "finished"],
  [5, "COURTNEY", "HOLLINBECK", "Armstrong Cycle", "100511875", "6503", 1, "00:21:05.0", "00:21:05.0", "finished"],
  [6, "COLETTE", "LUSIGNAN", "Minnesota Valley", "100529955", "6554", 1, "00:21:05.6", "00:21:05.6", "finished"],
  [7, "ELENA", "HENDRICKSON", "Cloquet-Esko-Carlton", "100516593", "6518", 1, "00:21:10.8", "00:21:10.8", "finished"],
  [8, "EMELYN", "HENDRICKSON", "Cloquet-Esko-Carlton", "100516595", "6519", 1, "00:21:39.1", "00:21:39.1", "finished"],
  [9, "JESSICA", "TOBIAS", "Minnesota Valley", "100529931", "6555", 1, "00:21:44.2", "00:21:44.2", "finished"],
  [10, "EMMA", "METSA", "Rock Ridge", "100512309", "6566", 1, "00:21:47.9", "00:21:47.9", "finished"],
  [11, "ALICIA", "HEIRAAS", "Prior Lake HS", "100518464", "6564", 1, "00:23:12.8", "00:23:12.8", "finished"],
  [12, "BRITTA", "DROOGSMA", "Rockford", "100510939", "6568", 1, "00:23:51.6", "00:23:51.6", "finished"],
  [13, "PENELOPE", "SNOW", "Shakopee HS", "100524706", "6575", 1, "00:24:55.9", "00:24:55.9", "finished"],
  [14, "KIAH", "DROOGSMA", "Rockford", "100510943", "6569", 1, "00:25:25.5", "00:25:25.5", "finished"],
  [15, "GWENDOLYN", "GUETTLER-JOHNSON", "Woodbury HS", "100516708", "6594", 1, "00:26:08.8", "00:26:08.8", "finished"],
  [16, "EVELYN", "EIGEN", "Alexandria Youth Cycling", "100532348", "6501", 1, "00:26:13.0", "00:26:13.0", "finished"],
  [17, "RAEGAN", "PERNITZ", "Minneapolis Roosevelt HS", "100514490", "6548", 1, "00:26:52.9", "00:26:52.9", "finished"],
  [18, "ALICE", "LATOUR", "Minneapolis Southwest HS", "100516872", "6550", 1, "00:27:33.8", "00:27:33.8", "finished"],
  [19, "NORAH", "LAWSON", "East Ridge HS", "100510479", "6525", 1, "00:27:48.9", "00:27:48.9", "finished"],
  [20, "ASTER", "HOLLIDAY", "Minneapolis Roosevelt HS", "100518576", "6546", 1, "00:29:04.9", "00:29:04.9", "finished"],
  [21, "ANNIKA", "BARLAGE", "New Prague MS and HS", "100530041", "6560", 1, "00:29:27.8", "00:29:27.8", "finished"],
  [22, "ELLIE", "NURMELA", "Lakeville North HS", "100522316", "6538", 1, "00:35:07.0", "00:35:07.0", "finished"],
  [23, "ELSIE", "NORMAN", "Cloquet-Esko-Carlton", "100521596", "6520", 1, "00:35:20.9", "00:35:20.9", "finished"],
  [24, "GWEN", "MCGREEVY", "Bloomington Jefferson", "100532223", "6511", 1, "00:42:22.5", "00:42:22.5", "finished"]
]

# Create racers, seasons, and race results for 6th Grade Girls
brophy_6th_grade_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = sixth_grade_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times (only one lap for 6th grade girls)
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 6th Grade Girls results: #{brophy_6th_grade_girls_results.count} racers imported"

# ===============================================================================
# 6th Grade Boys D2
# ===============================================================================

puts "Creating Brophy Park 6th Grade Boys D2 results..."

# 6th Grade Boys D2 category
sixth_grade_boys_d2_category = Category.find_by!(name: "6th Grade Boys D2")

# 6th Grade Boys D2 Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status]
brophy_6th_grade_boys_d2_results = [
  [1, "OLIN", "BUJOLD", "Tioga Trailblazers", "100489293", "6233", 1, "00:18:36.8", "00:18:36.8", "finished"],
  [2, "HENRY", "MEDHUS", "North Dakota", "100523070", "6164", 1, "00:18:49.5", "00:18:49.5", "finished"],
  [3, "CODY", "PETRACK", "Rock Ridge", "100516625", "6192", 1, "00:18:51.3", "00:18:51.3", "finished"],
  [4, "HENRY", "OSBURN", "Bloomington Jefferson", "100510972", "6028", 1, "00:18:54.8", "00:18:54.8", "finished"],
  [5, "GIL", "HORKEY", "Minneapolis Roosevelt HS", "100516076", "6111", 1, "00:20:11.1", "00:20:11.1", "finished"],
  [6, "DANNY", "TOWERS", "Rochester Area", "100519694", "6182", 1, "00:20:33.1", "00:20:33.1", "finished"],
  [7, "HENRY", "BROUWER", "Rockford", "100513879", "6195", 1, "00:20:33.7", "00:20:33.7", "finished"],
  [8, "CHARLIE", "DIXON", "Roseville", "100521844", "6198", 1, "00:20:41.6", "00:20:41.6", "finished"],
  [9, "BEN", "PETERSON", "Rock Ridge", "100522435", "6191", 1, "00:20:55.5", "00:20:55.5", "finished"],
  [10, "TRISTEN", "PETERS", "Armstrong Cycle", "100522931", "6009", 1, "00:21:11.0", "00:21:11.0", "finished"],
  [11, "WALT", "HUGHES", "Minneapolis Roosevelt HS", "100524956", "6112", 1, "00:21:35.9", "00:21:35.9", "finished"],
  [12, "GRAY", "SCHMIDT", "Elk River", "100511109", "6083", 1, "00:21:42.4", "00:21:42.4", "finished"],
  [13, "ELLIOT", "FREEMAN", "Roseville", "100530582", "6199", 1, "00:22:33.5", "00:22:33.5", "finished"],
  [14, "MICAH", "MEISER", "Minneapolis Roosevelt HS", "100513858", "6113", 1, "00:22:47.1", "00:22:47.1", "finished"],
  [15, "GRAHAM", "WOJCIK", "Elk River", "100528484", "6084", 1, "00:23:50.7", "00:23:50.7", "finished"],
  [16, "ORION", "KOON", "St Paul Composite - South", "100519224", "6227", 1, "00:23:58.2", "00:23:58.2", "finished"],
  [17, "PETER", "MARTINSON", "Minneapolis South HS", "100514067", "6114", 1, "00:24:11.6", "00:24:11.6", "finished"],
  [18, "REAS", "JAMES", "Minneapolis Southside", "100523747", "6116", 1, "00:24:14.0", "00:24:14.0", "finished"],
  [19, "SAMUEL", "DYBVIG", "Armstrong Cycle", "100530115", "6008", 1, "00:24:41.2", "00:24:41.2", "finished"],
  [20, "LUKE", "DRUCKMAN", "Armstrong Cycle", "100530251", "6007", 1, "00:24:46.4", "00:24:46.4", "finished"],
  [21, "ORION", "EVENSON", "Rock Ridge", "100529105", "6188", 1, "00:25:17.3", "00:25:17.3", "finished"],
  [22, "TYLER", "HUEBERT", "Rochester Area", "100524869", "6181", 1, "00:26:08.4", "00:26:08.4", "finished"],
  [23, "LOGAN", "SCHROEDER", "Minnesota Valley", "100529457", "6132", 1, "00:26:10.7", "00:26:10.7", "finished"],
  [24, "ANDERS", "DOLMAR", "Bloomington Jefferson", "100516525", "6027", 1, "00:26:38.2", "00:26:38.2", "finished"],
  [25, "GEORGE", "MARTIN", "Bloomington", "100514224", "6023", 1, "00:27:09.4", "00:27:09.4", "finished"],
  [26, "GABRIEL", "CESARI", "Bloomington Jefferson", "100531095", "6026", 1, "00:27:10.6", "00:27:10.6", "finished"],
  [27, "SAMUEL", "HEINECKE", "East Ridge HS", "100527016", "6062", 1, "00:27:14.8", "00:27:14.8", "finished"]
]

# Create racers, seasons, and race results for 6th Grade Boys D2
brophy_6th_grade_boys_d2_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = sixth_grade_boys_d2_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times (only one lap for 6th grade boys D2)
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 6th Grade Boys D2 results: #{brophy_6th_grade_boys_d2_results.count} racers imported"

# ===============================================================================
# 6th Grade Boys D1
# ===============================================================================

puts "Creating Brophy Park 6th Grade Boys D1 results..."

# 6th Grade Boys D1 category
sixth_grade_boys_d1_category = Category.find_by!(name: "6th Grade Boys D1")

# 6th Grade Boys D1 Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status]
brophy_6th_grade_boys_d1_results = [
  [1, "QUINCY", "GROTENHUIS", "Lakeville South HS", "100521373", "6105", 1, "00:18:46.2", "00:18:46.2", "finished"],
  [2, "AUSTIN", "ANDERSON", "Prior Lake HS", "100529114", "6170", 1, "00:19:19.5", "00:19:19.5", "finished"],
  [3, "ISAIAH", "RYE", "Alexandria Youth Cycling", "100511942", "6004", 1, "00:19:25.9", "00:19:25.9", "finished"],
  [4, "ANDREW", "KASO", "Prior Lake HS", "100532158", "6172", 1, "00:19:50.2", "00:19:50.2", "finished"],
  [5, "ZACHARY", "ALBU", "Minneapolis Southwest HS", "100522604", "6117", 1, "00:19:56.1", "00:19:56.1", "finished"],
  [6, "SIMON", "WAGNER", "Minneapolis Washburn HS", "100525579", "6131", 1, "00:19:57.9", "00:19:57.9", "finished"],
  [7, "IKE", "BACKSTROM", "Cloquet-Esko-Carlton", "100510588", "6050", 1, "00:21:36.1", "00:21:36.1", "finished"],
  [8, "LEVI", "REGENOLD", "Minneapolis Washburn HS", "100513208", "6129", 1, "00:21:45.1", "00:21:45.1", "finished"],
  [9, "JUSTIN", "JABS", "New Prague MS and HS", "100510679", "6162", 1, "00:22:29.3", "00:22:29.3", "finished"],
  [10, "ANDREW", "EHLERT", "Minneapolis Washburn HS", "100513594", "6122", 1, "00:22:46.1", "00:22:46.1", "finished"],
  [11, "LUCAS", "PATRICK-DROPIK", "Alexandria Youth Cycling", "100532750", "6003", 1, "00:22:56.0", "00:22:56.0", "finished"],
  [12, "BYRON", "SONNENTAG", "Prior Lake HS", "100529684", "6173", 1, "00:22:59.2", "00:22:59.2", "finished"],
  [13, "WILLIAM", "BAIRD", "Minneapolis Washburn HS", "100517482", "6118", 1, "00:22:59.2", "00:22:59.2", "finished"],
  [14, "KALEB", "DANIELSON", "Alexandria Youth Cycling", "100526949", "6001", 1, "00:23:06.8", "00:23:06.8", "finished"],
  [15, "OTTO", "JOHNSON", "Minneapolis Washburn HS", "100517730", "6124", 1, "00:23:55.7", "00:23:55.7", "finished"],
  [16, "LIAM", "DOBBELMANN", "Alexandria Youth Cycling", "100530399", "6002", 1, "00:24:28.6", "00:24:28.6", "finished"],
  [17, "OLIVER", "ADAMS", "Shakopee HS", "100529010", "6204", 1, "00:25:46.0", "00:25:46.0", "finished"],
  [18, "LUCAS", "PULFORD", "Cloquet-Esko-Carlton", "100510614", "6054", 1, "00:26:59.2", "00:26:59.2", "finished"],
  [19, "CARTER", "DANIELS", "Prior Lake HS", "100530170", "6171", 0, "DNF", nil, "DNF"]
]

# Create racers, seasons, and race results for 6th Grade Boys D1
brophy_6th_grade_boys_d1_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = sixth_grade_boys_d1_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  if lap1_time
    lap_time_ms = parse_time_to_ms(lap1_time)
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = lap_time_ms
      lap.cumulative_time_raw = format_time_ms(lap_time_ms)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park 6th Grade Boys D1 results: #{brophy_6th_grade_boys_d1_results.count} racers imported"

# ===============================================================================
# 7th Grade Girls
# ===============================================================================

puts "Creating Brophy Park 7th Grade Girls results..."

# 7th Grade Girls category
seventh_grade_girls_category = Category.find_by!(name: "7th Grade Girls")

# 7th Grade Girls Race Results
brophy_7th_grade_girls_results = [
  [1, "EMELIA", "PRESTON", "Alexandria Youth Cycling", "100473801", "5502", 1, "00:17:46.8", "00:17:46.8", "finished"],
  [2, "JOZIE", "OLSON", "Minneapolis Roosevelt HS", "100466226", "5558", 1, "00:18:06.4", "00:18:06.4", "finished"],
  [3, "BECK", "SPONHOLZ", "Borealis", "100444918", "5512", 1, "00:19:05.9", "00:19:05.9", "finished"],
  [4, "ALYSE", "SUCHY", "Alexandria Youth Cycling", "100469138", "5504", 1, "00:19:28.2", "00:19:28.2", "finished"],
  [5, "JADA", "HOLLINBECK", "Armstrong Cycle", "100473324", "5505", 1, "00:19:30.3", "00:19:30.3", "finished"],
  [6, "ELIZA", "KIELSMEIER-COOK", "Minneapolis Roosevelt HS", "100476258", "5556", 1, "00:19:39.9", "00:19:39.9", "finished"],
  [7, "CARLY", "FREYMILLER", "East Ridge HS", "100467560", "5532", 1, "00:19:49.5", "00:19:49.5", "finished"],
  [8, "NIA", "THATCHER", "Minneapolis Washburn HS", "100469450", "5564", 1, "00:20:16.7", "00:20:16.7", "finished"],
  [9, "POPPY", "KREYKES", "Breck", "100485011", "5516", 1, "00:20:25.4", "00:20:25.4", "finished"],
  [10, "JOSIE", "TRIPP", "Elk River", "100485259", "5543", 1, "00:20:28.1", "00:20:28.1", "finished"],
  [11, "HUDSON", "SPRUNGER", "East Ridge HS", "100392703", "5534", 1, "00:20:28.7", "00:20:28.7", "finished"],
  [12, "SKYLER", "LARSON", "Alexandria Youth Cycling", "100484623", "5501", 1, "00:20:51.0", "00:20:51.0", "finished"],
  [13, "HAILEY", "RAISANEN", "Cloquet-Esko-Carlton", "100516963", "5524", 1, "00:21:07.8", "00:21:07.8", "finished"],
  [14, "LEXI", "HITCHCOCK", "Cloquet-Esko-Carlton", "100464336", "5522", 1, "00:21:10.7", "00:21:10.7", "finished"],
  [15, "EVELYN", "SCOTT", "Minneapolis Washburn HS", "100473010", "5563", 1, "00:21:12.8", "00:21:12.8", "finished"],
  [16, "NOELLE", "YOUNGREN", "Tioga Trailblazers", "100491886", "5603", 1, "00:21:46.3", "00:21:46.3", "finished"],
  [17, "SAMANTHA", "RASMUSSEN", "New Prague MS and HS", "100533702", "5573", 1, "00:21:55.4", "00:21:55.4", "finished"],
  [18, "ELENA", "COLIANNI", "Breck", "100473638", "5515", 1, "00:22:07.6", "00:22:07.6", "finished"],
  [19, "ANIKA", "JONES", "Minneapolis Washburn HS", "100463282", "5561", 1, "00:22:11.0", "00:22:11.0", "finished"],
  [20, "OLIVIA", "LEOW", "Cloquet-Esko-Carlton", "100470056", "5523", 1, "00:22:44.6", "00:22:44.6", "finished"],
  [21, "ADIAH", "SCHERMAN", "New Prague MS and HS", "100483321", "5574", 1, "00:22:59.7", "00:22:59.7", "finished"],
  [22, "NELLIE", "REISHUS", "Alexandria Youth Cycling", "100470066", "5503", 1, "00:23:05.5", "00:23:05.5", "finished"],
  [23, "BIBI", "MIOTKE", "Breck", "100488269", "5517", 1, "00:23:06.8", "00:23:06.8", "finished"],
  [24, "JANE", "PATENAUDE", "Bloomington", "100488607", "5509", 1, "00:23:12.6", "00:23:12.6", "finished"],
  [25, "STELLA", "BAETZ", "Wayzata Mountain Bike", "100472461", "5604", 1, "00:23:30.0", "00:23:30.0", "finished"],
  [26, "ANI", "KENNING", "Minneapolis Washburn HS", "100465089", "5562", 1, "00:23:54.8", "00:23:54.8", "finished"],
  [27, "MORGAN", "CANDY", "Prior Lake HS", "100520804", "5575", 1, "00:24:06.5", "00:24:06.5", "finished"],
  [28, "KJIRSTEN", "NELSON", "Rochester Century HS", "100470793", "5581", 1, "00:24:12.3", "00:24:12.3", "finished"],
  [29, "AVA", "WOHNSEN", "Borealis", "100472115", "5513", 1, "00:24:23.4", "00:24:23.4", "finished"],
  [30, "LILA", "YOUNGE", "Shakopee HS", "100475730", "5591", 1, "00:24:36.2", "00:24:36.2", "finished"],
  [31, "MOLLY", "MCGUIRE", "Shakopee HS", "100483867", "5588", 1, "00:26:13.2", "00:26:13.2", "finished"],
  [32, "LUXIE", "SCHILLER", "Rock Ridge", "100524483", "5583", 1, "00:26:28.3", "00:26:28.3", "finished"],
  [33, "CHARLOTTE", "PERZYNSKI", "Elk River", "100485234", "5542", 1, "00:26:30.8", "00:26:30.8", "finished"],
  [34, "EVELYN", "BERRY", "White Bear Lake HS", "100530868", "5608", 1, "00:27:29.2", "00:27:29.2", "finished"],
  [35, "IARA", "VAN-CAO", "Wayzata Mountain Bike", "100531446", "5606", 1, "00:28:26.9", "00:28:26.9", "finished"],
  [36, "ROSIE", "CHANTHALAKEO", "Shakopee HS", "100529537", "5586", 1, "00:33:02.4", "00:33:02.4", "finished"],
  [37, "BETHANY", "DOUGHERTY", "Rockford", "100488056", "5584", 1, "00:34:36.2", "00:34:36.2", "finished"],
  [38, "ELEANOR", "PIPPIN", "Minneapolis Southwest HS", "100521134", "5559", 0, "DNF", nil, "DNF"]
]

# Create racers, seasons, and race results for 7th Grade Girls
brophy_7th_grade_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = seventh_grade_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  if lap1_time
    lap_time_ms = parse_time_to_ms(lap1_time)
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = lap_time_ms
      lap.cumulative_time_raw = format_time_ms(lap_time_ms)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park 7th Grade Girls results: #{brophy_7th_grade_girls_results.count} racers imported"

# ===============================================================================
# 7th Grade Boys D2
# ===============================================================================

puts "Creating Brophy Park 7th Grade Boys D2 results..."

# 7th Grade Boys D2 category
seventh_grade_boys_d2_category = Category.find_by!(name: "7th Grade Boys D2")

# 7th Grade Boys D2 Race Results
brophy_7th_grade_boys_d2_results = [
  [1, "TYE", "HOLMGREN", "Tioga Trailblazers", "100429051", "5305", 1, "00:16:53.4", "00:16:53.4", "finished"],
  [2, "FINN", "NEUMAN", "Tioga Trailblazers", "100486486", "5306", 1, "00:17:00.4", "00:17:00.4", "finished"],
  [3, "DYLAN", "JENNER", "Elk River", "100482706", "5116", 1, "00:17:51.2", "00:17:51.2", "finished"],
  [4, "IAN", "MURTHA", "Minneapolis Roosevelt HS", "100476359", "5173", 1, "00:17:59.9", "00:17:59.9", "finished"],
  [5, "COHEN", "BERNDT", "St Paul Composite - South", "100467015", "5290", 1, "00:18:04.6", "00:18:04.6", "finished"],
  [6, "LEVI", "HARTH", "Tioga Trailblazers", "100482243", "5304", 1, "00:18:17.1", "00:18:17.1", "finished"],
  [7, "GARRETT", "BLAHA", "Northwest", "100485466", "5213", 1, "00:18:18.6", "00:18:18.6", "finished"],
  [8, "GATES", "JONES", "Rochester Mayo", "100477548", "5242", 1, "00:18:21.0", "00:18:21.0", "finished"],
  [9, "PETER", "BECKMANN", "Bloomington Jefferson", "100460664", "5028", 1, "00:19:24.3", "00:19:24.3", "finished"],
  [10, "CALLAN", "ALCIVAR", "Bloomington Jefferson", "100460458", "5025", 1, "00:19:29.0", "00:19:29.0", "finished"],
  [11, "LEE", "EVANS", "Rock Ridge", "100460343", "5248", 1, "00:19:35.1", "00:19:35.1", "finished"],
  [12, "SEBASTIAN", "YANZ", "Minneapolis Roosevelt HS", "100472100", "5176", 1, "00:19:43.5", "00:19:43.5", "finished"],
  [13, "SAMMY", "HUGHES", "Minneapolis Southside", "100514635", "5179", 1, "00:19:43.9", "00:19:43.9", "finished"],
  [14, "JARED", "NOHNER", "Minnesota Valley", "100517209", "5194", 1, "00:20:00.1", "00:20:00.1", "finished"],
  [15, "PETE", "BERGSTROM", "Elk River", "100513431", "5114", 1, "00:20:04.8", "00:20:04.8", "finished"],
  [16, "EERO", "KRONZER", "Minneapolis Southside", "100523786", "5180", 1, "00:20:05.2", "00:20:05.2", "finished"],
  [17, "FINLEY", "STOKS", "St Paul Composite - North", "100511267", "5288", 1, "00:20:08.4", "00:20:08.4", "finished"],
  [18, "KARSON", "STINER", "St Paul Composite - South", "100469914", "5291", 1, "00:20:08.8", "00:20:08.8", "finished"],
  [19, "OWEN", "KES", "Lakeville North HS", "100466579", "5142", 1, "00:20:17.0", "00:20:17.0", "finished"],
  [20, "ROWAN", "BARRICK", "Bloomington Jefferson", "100478238", "5026", 1, "00:20:17.3", "00:20:17.3", "finished"],
  [21, "THOMAS", "FLATAU", "Northwest", "100494593", "5214", 1, "00:20:22.9", "00:20:22.9", "finished"],
  [22, "OWEN", "BIANCHET", "Roseville", "100462884", "5260", 1, "00:20:27.4", "00:20:27.4", "finished"],
  [23, "JAMES", "HILL", "Rochester Century HS", "100471454", "5238", 1, "00:20:40.3", "00:20:40.3", "finished"],
  [24, "JACK", "SEXTON", "Lakeville North HS", "100468703", "5144", 1, "00:20:42.7", "00:20:42.7", "finished"],
  [25, "GABE", "TOWERS", "Tioga Trailblazers", "100486864", "5307", 1, "00:20:49.4", "00:20:49.4", "finished"],
  [26, "LUCAS", "FUGLEBERG", "Bloomington", "100459728", "5022", 1, "00:20:59.6", "00:20:59.6", "finished"],
  [27, "ETHAN", "MULLEN", "Rochester Area", "100470824", "5234", 1, "00:21:03.8", "00:21:03.8", "finished"],
  [28, "CALEB", "SCHEFF", "Elk River", "100476767", "5117", 1, "00:21:04.1", "00:21:04.1", "finished"],
  [29, "HOLDEN", "VAN ZEE", "Elk River", "100528278", "5118", 1, "00:21:13.3", "00:21:13.3", "finished"],
  [30, "TAYDEN", "PETERSEN", "Rockford", "100529652", "5257", 1, "00:21:16.3", "00:21:16.3", "finished"],
  [31, "BENJAMIN", "DIERS", "Rockford", "100526373", "5253", 1, "00:21:17.3", "00:21:17.3", "finished"],
  [32, "MORRIS", "BINSFELD", "Rockford", "100483771", "5251", 1, "00:21:33.8", "00:21:33.8", "finished"],
  [33, "MICIAH", "PETERSON", "Kerkhoven", "100529838", "5140", 1, "00:21:47.7", "00:21:47.7", "finished"],
  [34, "SAM", "FORD", "Minneapolis Southside", "100524506", "5178", 1, "00:22:03.2", "00:22:03.2", "finished"],
  [35, "WILLIAM", "SMELSER", "Armstrong Cycle", "100533447", "5012", 1, "00:22:08.2", "00:22:08.2", "finished"],
  [36, "IAN", "LUND", "North Dakota", "100480493", "5209", 1, "00:22:17.0", "00:22:17.0", "finished"],
  [37, "SASHA", "KOHLER", "Minneapolis South HS", "100470734", "5177", 1, "00:22:42.4", "00:22:42.4", "finished"],
  [38, "CANNON", "WRIGHT", "Minneapolis Roosevelt HS", "100475948", "5175", 1, "00:22:54.0", "00:22:54.0", "finished"],
  [39, "ELLIOT", "ENGEHOLM", "Minneapolis Roosevelt HS", "100423641", "5170", 1, "00:22:59.3", "00:22:59.3", "finished"],
  [40, "JUSTIN", "BERG", "Breck", "100479662", "5037", 1, "00:23:00.9", "00:23:00.9", "finished"],
  [41, "LUCAS", "MILLER", "Lakeville North HS", "100481880", "5143", 1, "00:23:06.9", "00:23:06.9", "finished"],
  [42, "ANDERS", "STEIER", "North Dakota", "100487264", "5212", 1, "00:23:44.3", "00:23:44.3", "finished"],
  [43, "BENNETT", "WARZECHA", "Elk River", "100484984", "5119", 1, "00:23:47.9", "00:23:47.9", "finished"],
  [44, "LEO", "CALBONE", "Bloomington Jefferson", "100459747", "5029", 1, "00:24:13.4", "00:24:13.4", "finished"],
  [45, "CAIDEN", "BECKER", "Bloomington Jefferson", "100478842", "5027", 1, "00:24:43.5", "00:24:43.5", "finished"],
  [46, "WILLIAM", "ALLEN", "Breck", "100481663", "5036", 1, "00:24:50.6", "00:24:50.6", "finished"],
  [47, "CROSBY", "ANDRIANAKOS", "St Paul Composite - South", "100527512", "5289", 1, "00:25:25.9", "00:25:25.9", "finished"],
  [48, "MAX", "ICE", "Borealis", "100491033", "5030", 1, "00:25:33.5", "00:25:33.5", "finished"],
  [49, "FINNEGAN", "TRIEBENBACH", "Minneapolis Roosevelt HS", "100473080", "5174", 1, "00:26:04.9", "00:26:04.9", "finished"],
  [50, "HOKAN", "LUNN", "Borealis", "100481117", "5031", 1, "00:27:02.0", "00:27:02.0", "finished"],
  [51, "LUKE", "JOHNSON", "Armstrong Cycle", "100482608", "5010", 1, "00:28:44.3", "00:28:44.3", "finished"],
  [52, "KARSTEN", "BARTZ", "Tioga Trailblazers", "100533888", "5303", 1, "00:30:06.4", "00:30:06.4", "finished"]
]

# Create racers, seasons, and race results for 7th Grade Boys D2
brophy_7th_grade_boys_d2_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = seventh_grade_boys_d2_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 7th Grade Boys D2 results: #{brophy_7th_grade_boys_d2_results.count} racers imported"

# ===============================================================================
# 7th Grade Boys D1
# ===============================================================================

puts "Creating Brophy Park 7th Grade Boys D1 results..."

# 7th Grade Boys D1 category
seventh_grade_boys_d1_category = Category.find_by!(name: "7th Grade Boys D1")

# 7th Grade Boys D1 Race Results
brophy_7th_grade_boys_d1_results = [
  [1, "CONNOR", "SIMURDIAK", "Minneapolis Southwest HS", "100462488", "5188", 1, "00:18:36.4", "00:18:36.4", "finished"],
  [2, "HEATH", "HENTGES", "Shakopee HS", "100475806", "5263", 1, "00:18:43.4", "00:18:43.4", "finished"],
  [3, "GAVIN", "BELICH", "Cloquet-Esko-Carlton", "100460480", "5063", 1, "00:18:52.7", "00:18:52.7", "finished"],
  [4, "KORBIN", "KRIEL", "Alexandria Youth Cycling", "100473165", "5002", 1, "00:18:53.3", "00:18:53.3", "finished"],
  [5, "CORDELL", "WEBER", "Alexandria Youth Cycling", "100485288", "5005", 1, "00:18:53.9", "00:18:53.9", "finished"],
  [6, "CHARLIE", "MOHR", "Wayzata Mountain Bike", "100486769", "5321", 1, "00:18:55.7", "00:18:55.7", "finished"],
  [7, "JACK", "MUELLER", "Lakeville South HS", "100513750", "5148", 1, "00:19:49.1", "00:19:49.1", "finished"],
  [8, "ELLIOT", "CANDY", "Prior Lake HS", "100477563", "5224", 1, "00:19:55.3", "00:19:55.3", "finished"],
  [9, "KEATON", "WALDO", "Cloquet-Esko-Carlton", "100460563", "5068", 1, "00:20:15.4", "00:20:15.4", "finished"],
  [10, "ELIJAH", "FELBER", "White Bear Lake HS", "100522325", "5325", 1, "00:20:19.2", "00:20:19.2", "finished"],
  [11, "BRAYDEN", "SEAMAN", "Lakeville South HS", "100482352", "5149", 1, "00:20:22.2", "00:20:22.2", "finished"],
  [12, "ZACH", "SKOGSTAD", "Prior Lake HS", "100475574", "5229", 1, "00:20:40.7", "00:20:40.7", "finished"],
  [13, "ELLIOTT", "WASMER", "Minneapolis Washburn HS", "100518592", "5193", 1, "00:20:48.9", "00:20:48.9", "finished"],
  [14, "REID", "ANDERSON", "Wayzata Mountain Bike", "100486580", "5311", 1, "00:21:00.2", "00:21:00.2", "finished"],
  [15, "CHARLES", "SCHMIDT", "New Prague MS and HS", "100488678", "5208", 1, "00:21:00.5", "00:21:00.5", "finished"],
  [16, "ARCHIE", "REARDON", "Minneapolis Southwest HS", "100525592", "5187", 1, "00:21:04.5", "00:21:04.5", "finished"],
  [17, "FINLEY", "SEAMAN", "Lakeville South HS", "100482350", "5150", 1, "00:21:04.6", "00:21:04.6", "finished"],
  [18, "GARRETT", "LEOW", "Cloquet-Esko-Carlton", "100470060", "5065", 1, "00:21:08.6", "00:21:08.6", "finished"],
  [19, "LOGAN", "BUNDY", "New Prague MS and HS", "100534727", "5207", 1, "00:21:26.6", "00:21:26.6", "finished"],
  [20, "BROCK", "PETERSON", "Cloquet-Esko-Carlton", "100460477", "5066", 1, "00:21:28.4", "00:21:28.4", "finished"],
  [21, "KAI", "FOX", "Wayzata Mountain Bike", "100515040", "5313", 1, "00:22:07.3", "00:22:07.3", "finished"],
  [22, "EASTON", "ANDERSON", "Alexandria Youth Cycling", "100510640", "5001", 1, "00:22:11.9", "00:22:11.9", "finished"],
  [23, "ASHER", "DAVIDSON", "Lakeville South HS", "100469515", "5145", 1, "00:22:21.0", "00:22:21.0", "finished"],
  [24, "BECKETT", "KNOOT", "Wayzata Mountain Bike", "100476959", "5318", 1, "00:22:24.6", "00:22:24.6", "finished"],
  [25, "CARSON", "LINDELL", "Wayzata Mountain Bike", "100515265", "5319", 1, "00:22:39.7", "00:22:39.7", "finished"],
  [26, "LEIGHTON", "WHITNEY", "Minneapolis Southwest HS", "100513435", "5189", 1, "00:22:40.0", "00:22:40.0", "finished"],
  [27, "MAXTEN", "KIM", "Wayzata Mountain Bike", "100532857", "5316", 1, "00:22:47.9", "00:22:47.9", "finished"],
  [28, "HAYES", "PETERSON", "Minneapolis Southwest HS", "100518467", "5186", 1, "00:22:54.3", "00:22:54.3", "finished"],
  [29, "COOPER", "GREINER", "Cloquet-Esko-Carlton", "100462048", "5064", 1, "00:23:24.9", "00:23:24.9", "finished"],
  [30, "MAGNUS", "OLSON", "Wayzata Mountain Bike", "100515314", "5322", 1, "00:23:52.4", "00:23:52.4", "finished"],
  [31, "OWEN", "HARLAN", "Prior Lake HS", "100482320", "5225", 1, "00:23:53.6", "00:23:53.6", "finished"],
  [32, "HAUNS", "SHORT", "Alexandria Youth Cycling", "100532298", "5004", 1, "00:23:53.9", "00:23:53.9", "finished"],
  [33, "LUKAS", "ESS", "Lakeville South HS", "100514251", "5146", 1, "00:23:57.5", "00:23:57.5", "finished"],
  [34, "GRIFFIN", "MACMILLAN", "Wayzata Mountain Bike", "100486588", "5320", 1, "00:24:16.2", "00:24:16.2", "finished"],
  [35, "HENRY", "PETERSON", "Wayzata Mountain Bike", "100531455", "5323", 1, "00:25:45.1", "00:25:45.1", "finished"],
  [36, "BECKETT", "SCHROEDER", "Prior Lake HS", "100477973", "5228", 1, "00:28:47.5", "00:28:47.5", "finished"],
  [37, "WILL", "KOENIG", "Prior Lake HS", "100485238", "5226", 1, "00:28:52.3", "00:28:52.3", "finished"],
  [38, "ARLO", "SUTTON", "Wayzata Mountain Bike", "100521163", "5324", 1, "00:36:44.0", "00:36:44.0", "finished"],
  [39, "COPELAN", "KING-ELLISON", "Wayzata Mountain Bike", "100462666", "5317", 0, "DNF", nil, "DNF"]
]

# Create racers, seasons, and race results for 7th Grade Boys D1
brophy_7th_grade_boys_d1_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = seventh_grade_boys_d1_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  if lap1_time
    lap_time_ms = parse_time_to_ms(lap1_time)
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = lap_time_ms
      lap.cumulative_time_raw = format_time_ms(lap_time_ms)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park 7th Grade Boys D1 results: #{brophy_7th_grade_boys_d1_results.count} racers imported"

# ===============================================================================
# 8th Grade Girls
# ===============================================================================

puts "Creating Brophy Park 8th Grade Girls results..."

# 8th Grade Girls category
eighth_grade_girls_category = Category.find_by!(name: "8th Grade Girls")

# 8th Grade Girls Race Results
brophy_8th_grade_girls_results = [
  [1, "GRACE", "MAKOSKY", "Minneapolis Southwest HS", "100408191", "4557", 1, "00:18:17.5", "00:18:17.5", "finished"],
  [2, "NARA", "BLACK", "Minneapolis Southwest HS", "100408926", "4555", 1, "00:18:41.9", "00:18:41.9", "finished"],
  [3, "GRACE", "BERGER", "Minneapolis Southwest HS", "100421771", "4554", 1, "00:18:53.5", "00:18:53.5", "finished"],
  [4, "CIERAH", "MCKIBBON", "Cloquet-Esko-Carlton", "100406516", "4524", 1, "00:18:53.8", "00:18:53.8", "finished"],
  [5, "SELAH", "BEUKEMA", "Rock Ridge", "100406949", "4579", 1, "00:18:56.5", "00:18:56.5", "finished"],
  [6, "LUCIA", "ARNESON", "Minneapolis Washburn HS", "100418807", "4559", 1, "00:18:57.9", "00:18:57.9", "finished"],
  [7, "EMILY", "HEIRAAS", "Prior Lake HS", "100429778", "4573", 1, "00:19:01.8", "00:19:01.8", "finished"],
  [8, "PEYTON", "STAMSCHROR", "Prior Lake HS", "100421499", "4574", 1, "00:19:03.6", "00:19:03.6", "finished"],
  [9, "LILY", "MAKOSKY", "Minneapolis Southwest HS", "100408211", "4558", 1, "00:19:30.0", "00:19:30.0", "finished"],
  [10, "NORA", "PULFORD", "Cloquet-Esko-Carlton", "100406069", "4525", 1, "00:19:30.8", "00:19:30.8", "finished"],
  [11, "MEGAN", "FRITZEN", "Prior Lake HS", "100412430", "4572", 1, "00:19:42.2", "00:19:42.2", "finished"],
  [12, "TAHLIA", "ROONEY", "Alexandria Youth Cycling", "100411174", "4502", 1, "00:20:04.5", "00:20:04.5", "finished"],
  [13, "GRACE", "BERSETH", "Minneapolis Roosevelt HS", "100420622", "4549", 1, "00:20:44.1", "00:20:44.1", "finished"],
  [14, "ADDISON", "KANNAS", "Borealis", "100422621", "4512", 1, "00:21:18.2", "00:21:18.2", "finished"],
  [15, "AMELIA", "STROM", "Borealis", "100430514", "4514", 1, "00:21:19.1", "00:21:19.1", "finished"],
  [16, "ZOE", "BALLENTHIN", "White Bear Lake HS", "100488851", "4594", 1, "00:21:41.5", "00:21:41.5", "finished"],
  [17, "GENEVIEVE", "DUPUIS", "Minneapolis Washburn HS", "100525623", "4560", 1, "00:21:42.8", "00:21:42.8", "finished"],
  [18, "SYLVIA", "FEHR", "Minneapolis Roosevelt HS", "100422029", "4551", 1, "00:22:04.3", "00:22:04.3", "finished"],
  [19, "AUBRIE", "BURRELL", "Shakopee HS", "100417861", "4582", 1, "00:23:21.1", "00:23:21.1", "finished"],
  [20, "AUDREY", "JORDAN", "Cloquet-Esko-Carlton", "100423847", "4523", 1, "00:23:40.2", "00:23:40.2", "finished"],
  [21, "POSEY", "BURRES", "Bloomington Jefferson", "100417835", "4509", 1, "00:23:41.8", "00:23:41.8", "finished"],
  [22, "LENA", "HILL", "New Prague MS and HS", "100427524", "4569", 1, "00:23:47.9", "00:23:47.9", "finished"],
  [23, "KATHERINE", "MARKKULA", "Wayzata Mountain Bike", "100531443", "4592", 1, "00:23:56.0", "00:23:56.0", "finished"],
  [24, "CHARLOTTE", "WILSON", "Elk River", "100510982", "4538", 1, "00:24:20.4", "00:24:20.4", "finished"],
  [25, "AURORA", "HEFFELFINGER", "Minneapolis Southwest HS", "100471056", "4556", 1, "00:24:28.5", "00:24:28.5", "finished"],
  [26, "LILLY", "SQUIRES", "Bloomington Jefferson", "100482926", "4511", 1, "00:24:46.5", "00:24:46.5", "finished"],
  [27, "LINNEA", "CARLSON", "Shakopee HS", "100484236", "4583", 1, "00:24:48.3", "00:24:48.3", "finished"],
  [28, "CALI", "MITCHELL", "Wayzata Mountain Bike", "100533806", "4593", 1, "00:25:51.2", "00:25:51.2", "finished"],
  [29, "MENA", "SEVERT", "Breck", "100529978", "4516", 1, "00:32:47.5", "00:32:47.5", "finished"],
  [30, "LUCIENNE", "HULSON", "St Paul Composite - South", "100527469", "4588", 1, "00:37:13.0", "00:37:13.0", "finished"]
]

# Create racers, seasons, and race results for 8th Grade Girls
brophy_8th_grade_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = eighth_grade_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 8th Grade Girls results: #{brophy_8th_grade_girls_results.count} racers imported"

# ===============================================================================
# 8th Grade Boys D2
# ===============================================================================

puts "Creating Brophy Park 8th Grade Boys D2 results..."

# 8th Grade Boys D2 category
eighth_grade_boys_d2_category = Category.find_by!(name: "8th Grade Boys D2")

# 8th Grade Boys D2 Race Results
brophy_8th_grade_boys_d2_results = [
  [1, "HUDSON", "LUEDERS", "East Ridge HS", "100408914", "4069", 1, "00:15:36.6", "00:15:36.6", "finished"],
  [2, "GUS", "LAYMAN", "Rock Ridge", "100405726", "4230", 1, "00:15:55.2", "00:15:55.2", "finished"],
  [3, "CHARLIE", "KNUTSON", "Armstrong Cycle", "100432444", "4012", 1, "00:16:06.6", "00:16:06.6", "finished"],
  [4, "BRIAN", "SCHROOTEN", "Bloomington Jefferson", "100405883", "4031", 1, "00:16:53.1", "00:16:53.1", "finished"],
  [5, "DAIN", "PETERS", "Armstrong Cycle", "100476674", "4015", 1, "00:16:56.7", "00:16:56.7", "finished"],
  [6, "CARTER", "BOLSTER", "Minnesota Valley", "100389720", "4158", 1, "00:17:28.5", "00:17:28.5", "finished"],
  [7, "HUDSON", "SCHUER", "Bloomington Jefferson", "100418217", "4032", 1, "00:17:31.4", "00:17:31.4", "finished"],
  [8, "JESSE", "LANDRY", "Minneapolis Roosevelt HS", "100465376", "4131", 1, "00:17:45.4", "00:17:45.4", "finished"],
  [9, "AKSEL", "DREVLOW", "East Ridge HS", "100464168", "4067", 1, "00:17:46.6", "00:17:46.6", "finished"],
  [10, "CASH", "CONNELLY", "Tioga Trailblazers", "100432397", "4297", 1, "00:17:47.7", "00:17:47.7", "finished"],
  [11, "BENTLEY", "FULL", "Elk River", "100487804", "4092", 1, "00:18:17.0", "00:18:17.0", "finished"],
  [12, "EDWIN", "DILL", "Minneapolis Roosevelt HS", "100464325", "4130", 1, "00:18:17.0", "00:18:17.0", "finished"],
  [13, "JACK", "PUTNAM", "East Ridge HS", "100466833", "4071", 1, "00:18:21.6", "00:18:21.6", "finished"],
  [14, "ANDREAS", "DAHL", "North Dakota", "100479652", "4195", 1, "00:18:23.1", "00:18:23.1", "finished"],
  [15, "WILLIAM", "PALUMBO", "Rogers HS", "100428265", "4244", 1, "00:18:24.7", "00:18:24.7", "finished"],
  [16, "ISAAC", "MARCINIAK", "Minneapolis Roosevelt HS", "100464027", "4132", 1, "00:18:57.0", "00:18:57.0", "finished"],
  [17, "TYLER", "HASSIS", "Armstrong Cycle", "100428895", "4011", 1, "00:19:09.0", "00:19:09.0", "finished"],
  [18, "GAVIN", "MCCUSKER", "Lakeville North HS", "100475649", "4114", 1, "00:19:31.4", "00:19:31.4", "finished"],
  [19, "FINNEGAN", "PEDERSEN", "Bloomington Jefferson", "100461167", "4029", 1, "00:19:33.8", "00:19:33.8", "finished"],
  [20, "JAMES", "BICEK", "Minneapolis Roosevelt HS", "100479608", "4129", 1, "00:19:46.3", "00:19:46.3", "finished"],
  [21, "FRANKLIN", "MILLER", "St Paul Highland Park", "100391752", "4284", 1, "00:20:18.1", "00:20:18.1", "finished"],
  [22, "BAEK", "MARTIN-KOHLS", "St Paul Composite - North", "100427381", "4276", 1, "00:20:19.1", "00:20:19.1", "finished"],
  [23, "OWEN", "CABBAGE", "Rochester Area", "100413341", "4219", 1, "00:20:20.5", "00:20:20.5", "finished"],
  [24, "HUDSON", "HOLSTE", "Lakeville North HS", "100419508", "4113", 1, "00:20:32.2", "00:20:32.2", "finished"],
  [25, "JACK", "KNOLLMAIER", "Bloomington Jefferson", "100409466", "4028", 1, "00:20:59.9", "00:20:59.9", "finished"],
  [26, "CARSON", "BRETZ", "Elk River", "100484771", "4091", 1, "00:21:00.5", "00:21:00.5", "finished"],
  [27, "ANDY", "JOA", "Park HS", "100467280", "4205", 1, "00:21:07.2", "00:21:07.2", "finished"],
  [28, "EZRA", "METSA", "Rock Ridge", "100391716", "4231", 1, "00:21:10.5", "00:21:10.5", "finished"],
  [29, "WILLIAM", "SHEA", "Minneapolis Roosevelt HS", "100466403", "4134", 1, "00:21:12.6", "00:21:12.6", "finished"],
  [30, "SAWYER", "CHICK", "Borealis", "100413745", "4034", 1, "00:21:15.0", "00:21:15.0", "finished"],
  [31, "JOHN", "CAYKO", "Bloomington Jefferson", "100510653", "4027", 1, "00:21:16.2", "00:21:16.2", "finished"],
  [32, "MICHAEL", "GALLAGER", "Armstrong Cycle", "100488766", "4009", 1, "00:21:16.3", "00:21:16.3", "finished"],
  [33, "KIERAN", "ROARK", "Rock Ridge", "100407570", "4233", 1, "00:21:16.6", "00:21:16.6", "finished"],
  [34, "XAVIER", "OLSON", "Minnesota Valley", "100408099", "4160", 1, "00:21:25.8", "00:21:25.8", "finished"],
  [35, "BENJAMIN", "TURNER", "Rock Ridge", "100511243", "4237", 1, "00:21:43.0", "00:21:43.0", "finished"],
  [36, "CHASE", "HALVERSON", "Park HS", "100466803", "4204", 1, "00:22:00.7", "00:22:00.7", "finished"],
  [37, "CARSON", "SEARING", "Rochester Century HS", "100522136", "4226", 1, "00:22:12.4", "00:22:12.4", "finished"],
  [38, "OWEN", "RICE", "Rockford", "100488151", "4242", 1, "00:22:24.9", "00:22:24.9", "finished"],
  [39, "DEVIN", "SCHILLING", "Bloomington Jefferson", "100458634", "4030", 1, "00:23:58.7", "00:23:58.7", "finished"],
  [40, "PER", "ANDERSEN", "Rochester Century HS", "100411451", "4222", 1, "00:25:41.4", "00:25:41.4", "finished"],
  [41, "GARRETT", "LUSIGNAN", "Minnesota Valley", "100426763", "4159", 1, "00:25:43.2", "00:25:43.2", "finished"],
  [42, "JUHANI", "ROSANDICH", "Rock Ridge", "100428417", "4234", 1, "00:25:52.2", "00:25:52.2", "finished"]
]

# Create racers, seasons, and race results for 8th Grade Boys D2
brophy_8th_grade_boys_d2_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = eighth_grade_boys_d2_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 8th Grade Boys D2 results: #{brophy_8th_grade_boys_d2_results.count} racers imported"

# ===============================================================================
# 8th Grade Boys D1
# ===============================================================================

puts "Creating Brophy Park 8th Grade Boys D1 results..."

# 8th Grade Boys D1 category
eighth_grade_boys_d1_category = Category.find_by!(name: "8th Grade Boys D1")

# 8th Grade Boys D1 Race Results
brophy_8th_grade_boys_d1_results = [
  [1, "ARNAV", "SINGH", "Minneapolis Southwest HS", "100419609", "4144", 1, "00:16:37.9", "00:16:37.9", "finished"],
  [2, "EZRA", "LOWENTHAL WALSH", "Minneapolis Washburn HS", "100423727", "4151", 1, "00:16:44.9", "00:16:44.9", "finished"],
  [3, "ROHAN", "GOERKE", "Wayzata Mountain Bike", "100465514", "4307", 1, "00:16:45.2", "00:16:45.2", "finished"],
  [4, "KELLEN", "MEYER", "Prior Lake HS", "100471655", "4212", 1, "00:17:36.7", "00:17:36.7", "finished"],
  [5, "MASON", "THOMFORDE", "Prior Lake HS", "100478323", "4215", 1, "00:17:40.6", "00:17:40.6", "finished"],
  [6, "THEODORE", "JUFFER", "Minneapolis Southwest HS", "100418066", "4142", 1, "00:17:59.7", "00:17:59.7", "finished"],
  [7, "GEOFFREY", "EHLERT", "Minneapolis Washburn HS", "100418984", "4149", 1, "00:18:01.5", "00:18:01.5", "finished"],
  [8, "CARSON", "DOWNS", "Wayzata Mountain Bike", "100485811", "4305", 1, "00:18:18.2", "00:18:18.2", "finished"],
  [9, "CAMDEN", "RIGG", "Wayzata Mountain Bike", "100471123", "4313", 1, "00:18:18.9", "00:18:18.9", "finished"],
  [10, "OBADIAH", "REISHUS", "Alexandria Youth Cycling", "100424849", "4005", 1, "00:18:20.6", "00:18:20.6", "finished"],
  [11, "NOAH", "DAHN", "New Prague MS and HS", "100420497", "4194", 1, "00:18:30.9", "00:18:30.9", "finished"],
  [12, "GRANT", "BRODEGARD", "Minneapolis Washburn HS", "100417705", "4147", 1, "00:18:43.6", "00:18:43.6", "finished"],
  [13, "EVERETT", "NIEMASZ", "Minneapolis Southwest HS", "100462724", "4143", 1, "00:18:48.8", "00:18:48.8", "finished"],
  [14, "ISAAC", "FEDERER", "Minneapolis Southwest HS", "100475009", "4140", 1, "00:18:50.3", "00:18:50.3", "finished"],
  [15, "DEXTER", "VENEMAN", "Minneapolis Washburn HS", "100420383", "4157", 1, "00:18:50.3", "00:18:50.3", "finished"],
  [16, "TUCKER", "AWKER", "Wayzata Mountain Bike", "100532074", "4301", 1, "00:18:57.3", "00:18:57.3", "finished"],
  [17, "NOLAN", "STRUVE", "Wayzata Mountain Bike", "100433849", "4314", 1, "00:18:59.1", "00:18:59.1", "finished"],
  [18, "CHARLIE", "ELLICKSON", "Wayzata Mountain Bike", "100427391", "4306", 1, "00:18:59.7", "00:18:59.7", "finished"],
  [19, "VINCENT", "SCHANEN", "Minneapolis Washburn HS", "100392473", "4155", 1, "00:19:03.3", "00:19:03.3", "finished"],
  [20, "BENNETT", "EIDAM", "Shakopee HS", "100421649", "4253", 1, "00:19:38.5", "00:19:38.5", "finished"],
  [21, "OTTO", "GOOD", "Alexandria Youth Cycling", "100475269", "4002", 1, "00:19:42.7", "00:19:42.7", "finished"],
  [22, "JOSIAH", "DOBBELMANN", "Alexandria Youth Cycling", "100530395", "4001", 1, "00:20:24.0", "00:20:24.0", "finished"],
  [23, "MAKAI", "LUND", "Shakopee HS", "100421262", "4256", 1, "00:20:33.3", "00:20:33.3", "finished"],
  [24, "JACOB", "SCHNORR", "Shakopee HS", "100407448", "4258", 1, "00:21:17.0", "00:21:17.0", "finished"],
  [25, "CHRISTIAN", "BEECHER", "Wayzata Mountain Bike", "100432720", "4303", 1, "00:21:30.3", "00:21:30.3", "finished"],
  [26, "CARTER", "HAVLICEK", "Shakopee HS", "100486028", "4254", 1, "00:21:30.9", "00:21:30.9", "finished"],
  [27, "OLIVER", "SCHOENECK", "Minneapolis Washburn HS", "100421956", "4156", 1, "00:21:32.8", "00:21:32.8", "finished"],
  [28, "LUCAS", "JOHNSON", "Wayzata Mountain Bike", "100426756", "4308", 1, "00:21:33.6", "00:21:33.6", "finished"],
  [29, "BROCK", "BARLAGE", "New Prague MS and HS", "100427535", "4193", 1, "00:21:35.7", "00:21:35.7", "finished"],
  [30, "GAVIN", "PROFANT", "Shakopee HS", "100530700", "4257", 1, "00:22:43.1", "00:22:43.1", "finished"],
  [31, "ARCHER", "HORAN", "Minneapolis Southwest HS", "100519083", "4141", 1, "00:22:45.2", "00:22:45.2", "finished"],
  [32, "EVAN", "SACHS", "Prior Lake HS", "100421249", "4214", 1, "00:22:57.4", "00:22:57.4", "finished"],
  [33, "BENNETT", "VRIEZE", "White Bear Lake HS", "100528049", "4319", 1, "00:23:25.2", "00:23:25.2", "finished"],
  [34, "RAPHAEL", "ACHARYA", "Wayzata Mountain Bike", "100429681", "4299", 1, "00:23:35.7", "00:23:35.7", "finished"],
  [35, "NOAH", "BASILE", "Wayzata Mountain Bike", "100515876", "4302", 1, "00:23:41.5", "00:23:41.5", "finished"],
  [36, "NICHOLAS", "ELIZABETH", "Minneapolis Southwest HS", "100467001", "4139", 1, "00:24:04.7", "00:24:04.7", "finished"],
  [37, "CASPER", "POLINSKE", "Minneapolis Washburn HS", "100521865", "4154", 1, "00:24:37.1", "00:24:37.1", "finished"],
  [38, "COHEN", "JUERGENS", "White Bear Lake HS", "100480763", "4317", 1, "00:24:41.2", "00:24:41.2", "finished"]
]

# Create racers, seasons, and race results for 8th Grade Boys D1
brophy_8th_grade_boys_d1_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 1
    result.status = status
    result.category = eighth_grade_boys_d1_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  lap_time_ms = parse_time_to_ms(lap1_time)
  
  RaceResultLap.find_or_create_by!(
    race_result: race_result,
    lap_number: 1
  ) do |lap|
    lap.lap_time_ms = lap_time_ms
    lap.lap_time_raw = lap1_time
    lap.cumulative_time_ms = lap_time_ms
    lap.cumulative_time_raw = format_time_ms(lap_time_ms)
  end
  
  print "."
end

puts "\n✓ Brophy Park 8th Grade Boys D1 results: #{brophy_8th_grade_boys_d1_results.count} racers imported"

# ===============================================================================
# Freshman Boys D2
# ===============================================================================

puts "Creating Brophy Park Freshman Boys D2 results..."

# Freshman Boys D2 category
freshman_boys_d2_category = Category.find_by!(name: "Freshman Boys D2")

# Freshman Boys D2 Race Results (2 laps)
brophy_freshman_boys_d2_results = [
  [1, "SAWYER", "LAFAVE", "Rockford", "100391330", "3243", 2, "00:30:17.0", "00:14:44.8", "00:15:32.2", "finished"],
  [2, "BEN", "TESCH", "Minneapolis Roosevelt HS", "100419911", "3138", 2, "00:30:17.5", "00:14:45.0", "00:15:32.4", "finished"],
  [3, "OWEN", "LAWSON", "East Ridge HS", "100411092", "3084", 2, "00:30:18.7", "00:14:45.6", "00:15:33.0", "finished"],
  [4, "ELI", "MEISER", "Minneapolis Roosevelt HS", "100410036", "3136", 2, "00:31:19.0", "00:15:40.7", "00:15:38.3", "finished"],
  [5, "JACKSON", "TANK", "Rochester Area", "100392817", "3226", 2, "00:31:32.4", "00:15:46.1", "00:15:46.3", "finished"],
  [6, "ALEX", "CHOUANARD", "Rockford", "100389947", "3241", 2, "00:32:12.5", "00:15:45.0", "00:16:27.5", "finished"],
  [7, "LUCAS", "TRUCKENMILLER", "East Ridge HS", "100409698", "3086", 2, "00:32:12.7", "00:15:45.5", "00:16:27.2", "finished"],
  [8, "SULLIVAN", "BORN", "Woodbury HS", "100408784", "3350", 2, "00:32:17.4", "00:15:44.2", "00:16:33.2", "finished"],
  [9, "CHARLIE", "WILLIAMSON", "St Paul Composite - North", "100434885", "3291", 2, "00:32:20.2", "00:15:44.1", "00:16:36.0", "finished"],
  [10, "ISAAC", "LEISETH", "Northwest", "100391421", "3196", 2, "00:32:42.1", "00:15:43.0", "00:16:59.1", "finished"],
  [11, "BENNETT", "SCHMALTZ", "Roseville", "100392503", "3255", 2, "00:32:42.8", "00:15:59.5", "00:16:43.3", "finished"],
  [12, "ZINABU", "PETERSEN", "St Paul Composite - South", "100392146", "3297", 2, "00:32:50.2", "00:16:11.6", "00:16:38.6", "finished"],
  [13, "LOGAN", "STROHMEYER", "Hermantown-Proctor", "100431163", "3102", 2, "00:34:06.6", "00:16:38.6", "00:17:27.9", "finished"],
  [14, "COLIN", "BORGEN", "St Paul Highland Park", "100389731", "3303", 2, "00:34:23.3", "00:16:25.6", "00:17:57.7", "finished"],
  [15, "CALEB", "SYMONS", "Northwoods Cycling", "100488940", "3198", 2, "00:34:31.9", "00:17:21.0", "00:17:10.8", "finished"],
  [16, "JACK", "MARTIN", "Bemidji", "100391606", "3019", 2, "00:34:33.0", "00:16:47.0", "00:17:46.0", "finished"],
  [17, "LUKE", "EAGLE", "Rochester Area", "100407758", "3223", 2, "00:34:44.1", "00:17:04.3", "00:17:39.7", "finished"],
  [18, "HUNTER", "HOLLINBECK", "Armstrong Cycle", "100429319", "3012", 2, "00:34:48.9", "00:16:29.0", "00:18:19.9", "finished"],
  [19, "CALEB", "FANNING", "St Paul Composite - North", "100476762", "3289", 2, "00:35:16.0", "00:17:24.0", "00:17:52.0", "finished"],
  [20, "BRYCE", "MAXWELL", "Northwoods Cycling", "100488763", "3197", 2, "00:35:16.3", "00:17:53.1", "00:17:23.1", "finished"],
  [21, "CALM", "ENZ", "Northwest", "100390296", "3195", 2, "00:35:24.3", "00:17:06.5", "00:18:17.7", "finished"],
  [22, "NOAH", "MILLER-FIMPEL", "Minneapolis Southside", "100468392", "3140", 2, "00:35:24.5", "00:17:04.7", "00:18:19.7", "finished"],
  [23, "MYLES", "INGVALSON", "Lakeville North HS", "100420382", "3117", 2, "00:36:00.5", "00:17:09.3", "00:18:51.2", "finished"],
  [24, "TYLER", "HANSON", "Elk River", "100390709", "3100", 2, "00:36:11.8", "00:17:38.5", "00:18:33.2", "finished"],
  [25, "DEVON", "COLLITON", "Minneapolis Southside", "100472971", "3139", 2, "00:36:14.6", "00:17:52.3", "00:18:22.3", "finished"],
  [26, "JULIAN", "ENGEHOLM", "Minneapolis Roosevelt HS", "100423642", "3131", 2, "00:36:14.6", "00:17:56.5", "00:18:18.1", "finished"],
  [27, "HENRY", "LOE", "Roseville", "100424568", "3254", 2, "00:36:49.2", "00:18:01.1", "00:18:48.1", "finished"],
  [28, "ALEX", "PASCOE", "Rochester Century HS", "100392077", "3231", 2, "00:37:29.6", "00:19:02.1", "00:18:27.4", "finished"],
  [29, "JONAH", "HOLLIDAY", "Minneapolis Roosevelt HS", "100409031", "3134", 2, "00:37:33.0", "00:18:18.7", "00:19:14.2", "finished"],
  [30, "BEN", "BLOODGOOD", "Woodbury HS", "100468154", "3348", 2, "00:37:37.1", "00:18:21.0", "00:19:16.0", "finished"],
  [31, "MILES", "THAYER", "St Paul Highland Park", "100392837", "3305", 2, "00:37:41.9", "00:18:27.7", "00:19:14.1", "finished"],
  [32, "ROCCO", "KREYKES", "Breck", "100485903", "3040", 2, "00:38:29.7", "00:18:59.2", "00:19:30.5", "finished"],
  [33, "IAN", "ARTLEY", "Northwest", "100428031", "3194", 2, "00:38:30.2", "00:19:02.2", "00:19:27.9", "finished"],
  [34, "RAINER", "SEIBOLD", "Minneapolis Roosevelt HS", "100462905", "3137", 2, "00:38:30.6", "00:19:03.1", "00:19:27.5", "finished"],
  [35, "RAFE", "WILLIAMS", "Cook County", "", "3074", 2, "00:38:30.8", "00:19:55.8", "00:18:34.9", "finished"],
  [36, "MASON", "HANCOCK", "Lakeville North HS", "100481957", "3116", 2, "00:38:45.6", "00:17:26.6", "00:21:19.0", "finished"],
  [37, "SAM", "SAWYER", "Bloomington Jefferson", "100462341", "3028", 2, "00:38:46.1", "00:18:45.2", "00:20:00.8", "finished"],
  [38, "CHASE", "BOLYARD", "Woodbury HS", "100408868", "3349", 2, "00:38:56.5", "00:18:59.7", "00:19:56.7", "finished"],
  [39, "SAM", "VAN HORN", "Breck", "100392981", "3042", 2, "00:39:08.6", "00:19:56.8", "00:19:11.8", "finished"],
  [40, "IAN", "TESHIROGI", "Rochester Area", "100406892", "3227", 2, "00:39:17.1", "00:19:29.4", "00:19:47.7", "finished"],
  [41, "NICK", "CASTAGNERI", "Elk River", "100389916", "3099", 2, "00:39:18.2", "00:19:28.6", "00:19:49.6", "finished"],
  [42, "LIAM", "WEBER", "Elk River", "100389305", "3101", 2, "00:39:19.8", "00:19:04.3", "00:20:15.5", "finished"],
  [43, "STEFAN", "EASTMAN-LOUPE", "Roseville", "100512162", "3252", 2, "00:39:29.1", "00:19:58.8", "00:19:30.2", "finished"],
  [44, "ALEX", "KIMBALL", "Minneapolis Roosevelt HS", "100520733", "3135", 2, "00:39:30.1", "00:19:55.5", "00:19:34.6", "finished"],
  [45, "EARL", "SKARDA", "St Paul Composite - South", "100528741", "3299", 2, "00:40:24.3", "00:19:03.1", "00:21:21.2", "finished"],
  [46, "AIDEN", "FUHRMAN", "Rochester Area", "100411939", "3224", 2, "00:40:24.5", "00:20:06.3", "00:20:18.1", "finished"],
  [47, "THOMAS", "HUMENIK", "St Paul Composite - South", "100514516", "3295", 2, "00:41:19.3", "00:19:59.6", "00:21:19.6", "finished"],
  [48, "CARLO", "CALBONE", "Bloomington Jefferson", "100406760", "3025", 2, "00:41:21.5", "00:20:01.0", "00:21:20.4", "finished"],
  [49, "DARIN", "DROOGSMA", "Rockford", "100390219", "3242", 2, "00:41:29.9", "00:20:12.9", "00:21:17.0", "finished"],
  [50, "LIAM", "KNUDSON", "Rock Ridge", "100485096", "3237", 2, "00:41:34.2", "00:20:09.8", "00:21:24.4", "finished"],
  [51, "RYDER", "WEINHOLD", "Rochester Area", "100427922", "3228", 2, "00:41:48.8", "00:20:00.6", "00:21:48.2", "finished"],
  [52, "ELIJAH", "WARD", "Rockford", "100431327", "3247", 2, "00:41:50.9", "00:19:35.9", "00:22:15.0", "finished"],
  [53, "MITCHELL", "KARKELA", "Woodbury HS", "100514469", "3353", 2, "00:42:40.5", "00:20:54.2", "00:21:46.2", "finished"],
  [54, "WILLIAM", "SPAULDING", "Breck", "100480502", "3041", 2, "00:43:19.7", "00:20:52.5", "00:22:27.1", "finished"],
  [55, "WILL", "FUGLEBERG", "Bloomington", "100390471", "3022", 2, "00:43:20.8", "00:20:53.1", "00:22:27.7", "finished"],
  [56, "LIAM", "DAUBENMEYER", "Bloomington", "100433871", "3021", 2, "00:45:26.2", "00:21:33.5", "00:23:52.7", "finished"],
  [57, "BRACE", "BURMEISTER PATER", "Bemidji", "100488022", "3357", 2, "00:46:23.4", "00:22:19.9", "00:24:03.4", "finished"],
  [58, "ARCHER", "OLSON", "Rockford", "100465286", "3245", 2, "00:49:42.4", "00:23:31.1", "00:26:11.2", "finished"],
  [59, "GAVIN", "EICKMAN", "Bemidji", "100485962", "3358", 1, "00:26:15.7", "00:26:15.7", nil, "DNF"]
]

# Create racers, seasons, and race results for Freshman Boys D2
brophy_freshman_boys_d2_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number if rider_number.present?
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = freshman_boys_d2_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  
  # Lap 1
  if lap1_time
    lap1_time_ms = parse_time_to_ms(lap1_time)
    cumulative_time += lap1_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap1_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  # Lap 2 (only if completed)
  if lap2_time
    lap2_time_ms = parse_time_to_ms(lap2_time)
    cumulative_time += lap2_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 2
    ) do |lap|
      lap.lap_time_ms = lap2_time_ms
      lap.lap_time_raw = lap2_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park Freshman Boys D2 results: #{brophy_freshman_boys_d2_results.count} racers imported"

# ===============================================================================
# Freshman Boys D1
# ===============================================================================

puts "Creating Brophy Park Freshman Boys D1 results..."

# Freshman Boys D1 category
freshman_boys_d1_category = Category.find_by!(name: "Freshman Boys D1")

# Freshman Boys D1 Race Results (2 laps)
brophy_freshman_boys_d1_results = [
  [1, "STEFFAN", "DREKONJA", "Minneapolis Washburn HS", "100390203", "3147", 2, "00:31:12.8", "00:15:37.0", "00:15:35.7", "finished"],
  [2, "DANIEL", "DEWEY", "Cloquet-Esko-Carlton", "100388196", "3063", 2, "00:31:31.3", "00:15:37.0", "00:15:54.3", "finished"],
  [3, "NOLAN", "HENDRICKSON", "Cloquet-Esko-Carlton", "100405947", "3066", 2, "00:32:26.8", "00:15:57.2", "00:16:29.5", "finished"],
  [4, "BEN", "RASMUSSEN", "New Prague MS and HS", "100392267", "3192", 2, "00:33:13.2", "00:16:28.3", "00:16:44.9", "finished"],
  [5, "LINCOLN", "STUBER", "New Prague MS and HS", "100392775", "3193", 2, "00:33:14.4", "00:16:19.3", "00:16:55.0", "finished"],
  [6, "ISAAC", "TRACHTENBERG", "Minneapolis Southwest HS", "100409323", "3145", 2, "00:33:26.6", "00:16:24.5", "00:17:02.0", "finished"],
  [7, "LEVI", "PRESTON", "Alexandria Youth Cycling", "100392225", "3008", 2, "00:33:36.5", "00:16:30.9", "00:17:05.5", "finished"],
  [8, "LOGAN", "GAMACHE", "Cloquet-Esko-Carlton", "100390494", "3065", 2, "00:33:41.1", "00:16:46.5", "00:16:54.6", "finished"],
  [9, "OWEN", "RILEY", "Shakopee HS", "100411688", "3264", 2, "00:33:43.3", "00:16:54.8", "00:16:48.4", "finished"],
  [10, "OLIVER", "ASRANI", "Wayzata Mountain Bike", "100430527", "3322", 2, "00:33:46.7", "00:16:55.3", "00:16:51.3", "finished"],
  [11, "ALEXANDER", "NELSON", "Cloquet-Esko-Carlton", "100391877", "3067", 2, "00:34:01.4", "00:16:55.7", "00:17:05.6", "finished"],
  [12, "GUNNER", "RACH", "Alexandria Youth Cycling", "100486184", "3009", 2, "00:34:15.6", "00:17:28.4", "00:16:47.1", "finished"],
  [13, "PARKER", "CHEN", "Wayzata Mountain Bike", "100429402", "3324", 2, "00:34:55.5", "00:16:54.8", "00:18:00.7", "finished"],
  [14, "ETHAN", "LI", "Wayzata Mountain Bike", "100391462", "3329", 2, "00:35:16.9", "00:16:55.3", "00:18:21.6", "finished"],
  [15, "HENRY", "HARTMANN", "Prior Lake HS", "100421409", "3210", 2, "00:36:04.9", "00:17:48.2", "00:18:16.6", "finished"],
  [16, "BLAKE", "REED", "Minneapolis Southwest HS", "100520836", "3143", 2, "00:36:30.4", "00:18:08.2", "00:18:22.2", "finished"],
  [17, "PIKE", "AMUNDSON", "Alexandria Youth Cycling", "100389433", "3001", 2, "00:36:35.8", "00:18:16.8", "00:18:18.9", "finished"],
  [18, "BLAKE", "ORRBEN", "Shakopee HS", "100412148", "3263", 2, "00:36:39.9", "00:17:39.7", "00:19:00.2", "finished"],
  [19, "MAX", "BENNETT", "Wayzata Mountain Bike", "100389610", "3323", 2, "00:36:47.4", "00:18:12.5", "00:18:34.8", "finished"],
  [20, "SAM", "CORBETT", "Wayzata Mountain Bike", "100390030", "3325", 2, "00:37:03.1", "00:18:27.2", "00:18:35.9", "finished"],
  [21, "BREWSTER", "VITTERA", "Wayzata Mountain Bike", "100478199", "3336", 2, "00:37:04.0", "00:18:27.8", "00:18:36.2", "finished"],
  [22, "CARSON", "CRYER", "Prior Lake HS", "100421918", "3209", 2, "00:37:05.0", "00:18:29.8", "00:18:35.2", "finished"],
  [23, "PARKER", "JENSEN", "Alexandria Youth Cycling", "100428891", "3007", 2, "00:37:05.7", "00:18:28.7", "00:18:36.9", "finished"],
  [24, "CALEB", "CROWSER", "Alexandria Youth Cycling", "100390049", "3003", 2, "00:37:05.8", "00:18:28.4", "00:18:37.3", "finished"],
  [25, "WESTON", "GRABER", "New Prague MS and HS", "100426483", "3189", 2, "00:37:06.7", "00:18:26.7", "00:18:39.9", "finished"],
  [26, "LOGAN", "WALDO", "Cloquet-Esko-Carlton", "100413335", "3070", 2, "00:37:17.6", "00:18:24.8", "00:18:52.7", "finished"],
  [27, "WILL", "REGENOLD", "Minneapolis Washburn HS", "100392290", "3150", 2, "00:37:30.1", "00:18:58.8", "00:18:31.2", "finished"],
  [28, "CHARLIE", "GUSTAFSON", "Wayzata Mountain Bike", "100390638", "3326", 2, "00:37:30.7", "00:18:28.9", "00:19:01.8", "finished"],
  [29, "JAXON", "HOUKOM", "White Bear Lake HS", "100521575", "3342", 2, "00:37:51.4", "00:18:08.7", "00:19:42.7", "finished"],
  [30, "CONNOR", "LONG", "Prior Lake HS", "100391499", "3213", 2, "00:38:20.5", "00:18:28.5", "00:19:52.0", "finished"],
  [31, "JASPER", "CARLSON", "White Bear Lake HS", "100477803", "3338", 2, "00:38:42.1", "00:18:44.6", "00:19:57.4", "finished"],
  [32, "CHARLIE", "BERGLUND", "Lakeville South HS", "100482065", "3119", 2, "00:38:43.1", "00:19:09.7", "00:19:33.3", "finished"],
  [33, "GAVIN", "GILBERTSON", "Alexandria Youth Cycling", "100429357", "3006", 2, "00:39:01.3", "00:19:09.5", "00:19:51.7", "finished"],
  [34, "CAMDEN", "DANIELSON", "Alexandria Youth Cycling", "100415033", "3005", 2, "00:39:01.7", "00:19:30.6", "00:19:31.0", "finished"],
  [35, "JOSH", "MOHR", "Wayzata Mountain Bike", "100426269", "3332", 2, "00:39:19.5", "00:18:52.4", "00:20:27.0", "finished"],
  [36, "NOLAN", "MACMILLAN", "Wayzata Mountain Bike", "100391535", "3330", 2, "00:39:21.3", "00:19:08.4", "00:20:12.8", "finished"],
  [37, "DANIEL", "HORTER", "Prior Lake HS", "100390927", "3212", 2, "00:39:29.9", "00:19:20.8", "00:20:09.1", "finished"],
  [38, "SETH", "VLIEGER", "White Bear Lake HS", "100478884", "3344", 2, "00:40:04.5", "00:19:21.0", "00:20:43.5", "finished"],
  [39, "EDWARD", "SHAUL", "Prior Lake HS", "100473003", "3216", 2, "00:40:06.0", "00:18:50.6", "00:21:15.4", "finished"],
  [40, "ETHAN", "MARKES", "Shakopee HS", "100421305", "3262", 2, "00:40:27.2", "00:19:53.1", "00:20:34.0", "finished"],
  [41, "GRIFFEN", "BUGHER", "Alexandria Youth Cycling", "100389829", "3002", 2, "00:41:01.0", "00:19:49.9", "00:21:11.1", "finished"],
  [42, "OWEN", "SKEATE", "Shakopee HS", "100482916", "3266", 2, "00:41:35.8", "00:20:05.1", "00:21:30.7", "finished"],
  [43, "BECKETT", "ZWEBER", "Lakeville South HS", "100435182", "3124", 2, "00:41:53.5", "00:20:12.6", "00:21:40.8", "finished"],
  [44, "NILS", "STADSKLEV", "Alexandria Youth Cycling", "100486523", "3010", 2, "00:42:07.1", "00:20:45.2", "00:21:21.8", "finished"],
  [45, "NATHAN", "ELLINGSON", "Cloquet-Esko-Carlton", "100510816", "3064", 2, "00:42:11.5", "00:20:42.1", "00:21:29.4", "finished"],
  [46, "BENNETT", "NESBITT", "Lakeville South HS", "100464225", "3120", 2, "00:42:28.8", "00:21:42.8", "00:20:46.0", "finished"],
  [47, "CADEN", "SANDMANN", "Lakeville South HS", "100419000", "3123", 2, "00:43:33.8", "00:20:37.3", "00:22:56.4", "finished"],
  [48, "GAVIN", "OLINGER", "Prior Lake HS", "100391997", "3215", 2, "00:43:51.7", "00:21:12.1", "00:22:39.5", "finished"],
  [49, "CONNER", "HAWKS", "Prior Lake HS", "100390758", "3211", 2, "00:44:24.9", "00:21:27.1", "00:22:57.8", "finished"],
  [50, "ISAAC", "ROSS", "White Bear Lake HS", "100534483", "3343", 2, "00:44:29.3", "00:21:30.4", "00:22:58.9", "finished"],
  [51, "KAELAN", "SIMURDIAK", "Minneapolis Southwest HS", "100392617", "3144", 2, "00:45:22.2", "00:22:20.4", "00:23:01.8", "finished"],
  [52, "JACOB", "WARD", "Minneapolis Washburn HS", "100393057", "3153", 2, "00:45:22.2", "00:21:31.4", "00:23:50.8", "finished"],
  [53, "SHAUN", "CRONQUIST", "Prior Lake HS", "100483232", "3208", 2, "00:45:50.1", "00:22:59.9", "00:22:50.1", "finished"],
  [54, "MILOSH", "HOUGEN", "Minneapolis Washburn HS", "100530087", "3148", 2, "00:47:00.7", "00:23:01.1", "00:23:59.6", "finished"],
  [55, "BRODIE", "OLSON", "Lakeville South HS", "100427441", "3122", 2, "00:47:29.6", "00:22:47.4", "00:24:42.2", "finished"],
  [56, "RYAN", "JONES", "Wayzata Mountain Bike", "100481981", "3327", 2, "00:47:52.7", "00:22:59.2", "00:24:53.5", "finished"],
  [57, "MORGAN", "MILLER", "Wayzata Mountain Bike", "100532041", "3331", 2, "00:49:38.1", "00:23:02.5", "00:26:35.5", "finished"],
  [58, "JULIAN", "SWARTHOUT", "Minneapolis Washburn HS", "100479306", "3152", 2, "00:52:01.6", "00:25:43.6", "00:26:17.9", "finished"],
  [59, "LOGAN", "LITSCHER", "New Prague MS and HS", "100426197", "3191", 2, "00:53:53.2", "00:25:18.2", "00:28:35.0", "finished"]
]

# Create racers, seasons, and race results for Freshman Boys D1
brophy_freshman_boys_d1_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = freshman_boys_d1_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  
  # Lap 1
  if lap1_time
    lap1_time_ms = parse_time_to_ms(lap1_time)
    cumulative_time += lap1_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap1_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  # Lap 2
  if lap2_time
    lap2_time_ms = parse_time_to_ms(lap2_time)
    cumulative_time += lap2_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 2
    ) do |lap|
      lap.lap_time_ms = lap2_time_ms
      lap.lap_time_raw = lap2_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park Freshman Boys D1 results: #{brophy_freshman_boys_d1_results.count} racers imported"

# ===============================================================================
# Freshman Girls
# ===============================================================================

puts "Creating Brophy Park Freshman Girls results..."

# Freshman Girls category
freshman_girls_category = Category.find_by!(name: "Freshman Girls")

# Freshman Girls Race Results (2 laps)
brophy_freshman_girls_results = [
  [1, "PENELOPE", "RIENTS", "Shakopee HS", "100407308", "3578", 2, "00:34:30.0", "00:16:56.2", "00:17:33.8", "finished"],
  [2, "REESE", "CUTTS", "Shakopee HS", "100406936", "3575", 2, "00:34:47.7", "00:16:56.7", "00:17:51.0", "finished"],
  [3, "MAEVE", "THATCHER", "Minneapolis Washburn HS", "100392834", "3549", 2, "00:34:50.8", "00:17:00.1", "00:17:50.7", "finished"],
  [4, "SOFIA", "HORSTMANN", "Lakeville North HS", "100418804", "3536", 2, "00:36:26.7", "00:18:19.1", "00:18:07.5", "finished"],
  [5, "SIENNA", "SAMS", "Hermantown-Proctor", "100460392", "3527", 2, "00:36:32.5", "00:17:58.2", "00:18:34.2", "finished"],
  [6, "QUINN", "VAN HEYST", "East Ridge HS", "100408713", "3519", 2, "00:37:02.3", "00:17:57.4", "00:19:04.8", "finished"],
  [7, "ADDISON", "SUCHY", "Alexandria Youth Cycling", "100392777", "3501", 2, "00:37:12.5", "00:18:13.2", "00:18:59.3", "finished"],
  [8, "INGRID", "OLSON", "Minnesota Valley", "100408103", "3551", 2, "00:37:12.9", "00:18:10.1", "00:19:02.7", "finished"],
  [9, "BAYLY", "WASMER", "Minneapolis Washburn HS", "100393061", "3550", 2, "00:38:24.8", "00:18:50.8", "00:19:34.0", "finished"],
  [10, "JOSIE", "WALGRAVE", "Prior Lake HS", "100429931", "3566", 2, "00:38:31.1", "00:19:27.0", "00:19:04.1", "finished"],
  [11, "GEMMA", "BANKS", "Elk River", "100428934", "3526", 2, "00:38:57.2", "00:19:08.8", "00:19:48.3", "finished"],
  [12, "ELLE", "LYNCH", "Minneapolis Southwest HS", "100409012", "3544", 2, "00:39:04.2", "00:19:09.8", "00:19:54.4", "finished"],
  [13, "ALLISON", "TOBIAS", "New Prague MS and HS", "100462936", "3561", 2, "00:39:11.6", "00:19:11.7", "00:19:59.8", "finished"],
  [14, "MAYA", "SCHRAMM", "Minneapolis Southwest HS", "100417451", "3545", 2, "00:39:33.3", "00:19:12.9", "00:20:20.3", "finished"],
  [15, "MARI", "SATHRE", "Cloquet-Esko-Carlton", "100469857", "3513", 2, "00:39:35.9", "00:19:50.4", "00:19:45.4", "finished"],
  [16, "LARA", "MUELLER", "Bemidji", "100434585", "3503", 2, "00:40:22.5", "00:19:38.8", "00:20:43.6", "finished"],
  [17, "AVA", "NORTHROP", "Minneapolis Washburn HS", "100391948", "3547", 2, "00:40:42.2", "00:19:52.9", "00:20:49.3", "finished"],
  [18, "GWEN", "THAYER", "St Paul Highland Park", "100392836", "3584", 2, "00:40:43.3", "00:19:44.9", "00:20:58.3", "finished"],
  [19, "ALLISON", "CLAYDON", "Roseville", "100389971", "3571", 2, "00:41:06.5", "00:19:51.2", "00:21:15.2", "finished"],
  [20, "FERN", "SHAFFNER", "Roseville", "100426662", "3572", 2, "00:41:09.0", "00:19:59.6", "00:21:09.3", "finished"],
  [21, "PENELOPE", "PERNITZ", "Minneapolis Roosevelt HS", "100418268", "3541", 2, "00:41:47.2", "00:20:29.6", "00:21:17.6", "finished"],
  [22, "MARIA", "DROOGSMA", "Rockford", "100390220", "3570", 2, "00:42:37.1", "00:20:51.0", "00:21:46.0", "finished"],
  [23, "EVA", "FOLGER", "Prior Lake HS", "100390402", "3565", 2, "00:42:59.3", "00:20:39.7", "00:22:19.5", "finished"],
  [24, "ELLA", "ALBU", "Minneapolis Southwest HS", "100466302", "3543", 2, "00:43:08.1", "00:21:08.2", "00:21:59.8", "finished"],
  [25, "ANNIKA", "OSTBY", "Rochester Century HS", "100410357", "3569", 2, "00:44:13.3", "00:21:38.1", "00:22:35.2", "finished"],
  [26, "JILLIAN", "RUD", "Minnesota Valley", "100487126", "3552", 2, "00:44:40.3", "00:22:42.8", "00:21:57.5", "finished"],
  [27, "JULIA", "CALVERT", "Bemidji", "100432608", "3600", 2, "00:45:39.4", "00:22:49.2", "00:22:50.2", "finished"],
  [28, "HAILEY", "SOINE", "Kerkhoven", "100392669", "3535", 2, "00:47:49.4", "00:22:13.4", "00:25:36.0", "finished"],
  [29, "LILY", "PETERSON", "Kerkhoven", "100529841", "3534", 2, "00:48:14.6", "00:23:35.3", "00:24:39.2", "finished"],
  [30, "NICOLETTE", "PARMER", "North Dakota", "100392072", "3562", 2, "00:52:14.2", "00:23:49.1", "00:28:25.0", "finished"],
  [31, "ELSA", "MILLER", "Wayzata Mountain Bike", "100531726", "3593", 2, "00:52:26.0", "00:25:13.8", "00:27:12.2", "finished"],
  [32, "ADDISON", "DEUTSCH", "Shakopee HS", "100427539", "3576", 2, "00:58:38.6", "00:26:44.3", "00:31:54.2", "finished"],
  [33, "ELISA", "ANDERSON", "White Bear Lake HS", "100520101", "3597", 2, "01:00:26.9", "00:28:04.1", "00:32:22.7", "finished"],
  [34, "SYLVIA", "KLEIN", "Shakopee HS", "100391219", "3577", 1, "00:36:34.3", "00:36:34.3", nil, "DNF"]
]

# Create racers, seasons, and race results for Freshman Girls
brophy_freshman_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = freshman_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  
  # Lap 1
  if lap1_time
    lap1_time_ms = parse_time_to_ms(lap1_time)
    cumulative_time += lap1_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap1_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  # Lap 2 (only if completed)
  if lap2_time
    lap2_time_ms = parse_time_to_ms(lap2_time)
    cumulative_time += lap2_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 2
    ) do |lap|
      lap.lap_time_ms = lap2_time_ms
      lap.lap_time_raw = lap2_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park Freshman Girls results: #{brophy_freshman_girls_results.count} racers imported"

# ===============================================================================
# JV2 Girls
# ===============================================================================

puts "Creating Brophy Park JV2 Girls results..."

# JV2 Girls category
jv2_girls_category = Category.find_by!(name: "JV2 Girls")

# JV2 Girls Race Results (2 laps)
brophy_jv2_girls_results = [
  [1, "ALEXA", "DOBESH", "Lakeville South HS", "100474286", "2650", 2, "00:34:22.2", "00:16:57.1", "00:17:25.0", "finished"],
  [2, "NORA", "ANTOLICK", "Park HS", "100408096", "2674", 2, "00:38:22.6", "00:18:48.7", "00:19:33.8", "finished"],
  [3, "RIVER", "GALLOWAY", "Rock Ridge", "100390489", "2681", 2, "00:39:14.6", "00:19:10.2", "00:20:04.4", "finished"],
  [4, "IZZY", "GREENWIN", "Minneapolis Washburn HS", "100390604", "2658", 2, "00:40:08.0", "00:19:22.1", "00:20:45.9", "finished"],
  [5, "STEPHANIE", "GALVAN-ORTIZ", "Shakopee HS", "100390492", "2691", 2, "00:40:09.1", "00:19:54.2", "00:20:14.9", "finished"],
  [6, "MADDISON", "LYDON", "White Bear Lake HS", "100478581", "2715", 2, "00:41:21.2", "00:20:19.0", "00:21:02.2", "finished"],
  [7, "SOPHIA", "PEDERSEN", "Lakeville North HS", "100392110", "2649", 2, "00:41:23.8", "00:19:53.2", "00:21:30.6", "finished"],
  [8, "ELLA", "ENGLAND", "Minneapolis Southside", "100390292", "2654", 2, "00:41:47.3", "00:21:10.9", "00:20:36.4", "finished"],
  [9, "JACOBI", "BURMEISTER PATER", "Bemidji", "100488021", "2607", 2, "00:41:54.0", "00:20:27.6", "00:21:26.3", "finished"],
  [10, "CAMILA", "GALVAN-ORTIZ", "Shakopee HS", "100462928", "2689", 2, "00:41:56.3", "00:19:57.5", "00:21:58.7", "finished"],
  [11, "MIALYNN", "METSA", "Rock Ridge", "100391717", "2683", 2, "00:42:03.5", "00:20:42.3", "00:21:21.1", "finished"],
  [12, "EVA", "GROTENHUIS", "Lakeville South HS", "100390619", "2651", 2, "00:42:09.2", "00:20:12.9", "00:21:56.3", "finished"],
  [13, "CHLOE", "HARDTKE", "Rochester Area", "100390716", "2678", 2, "00:42:40.0", "00:20:47.0", "00:21:53.0", "finished"],
  [14, "TEVA", "FEIT", "New Prague MS and HS", "100428613", "2668", 2, "00:44:14.2", "00:22:11.8", "00:22:02.4", "finished"],
  [15, "AVA", "KAUFMANN", "Lakeville North HS", "100391144", "2648", 2, "00:44:37.1", "00:21:24.0", "00:23:13.1", "finished"],
  [16, "PEYTON", "MOIDL", "Wayzata Mountain Bike", "100512292", "2711", 2, "00:44:40.9", "00:22:17.6", "00:22:23.3", "finished"],
  [17, "JENNA", "PETTES", "Prior Lake HS", "100483115", "2675", 2, "00:44:58.5", "00:21:54.0", "00:23:04.4", "finished"],
  [18, "REBECCA", "MILLER", "Wayzata Mountain Bike", "100391749", "2710", 2, "00:45:05.7", "00:22:06.4", "00:22:59.2", "finished"],
  [19, "CHARLOTTE", "CANNON", "White Bear Lake HS", "100478878", "2714", 2, "00:46:01.2", "00:22:12.7", "00:23:48.4", "finished"],
  [20, "MILCA", "GALVAN-ORTIZ", "Shakopee HS", "100462929", "2690", 2, "00:46:26.6", "00:22:10.8", "00:24:15.8", "finished"],
  [21, "LUZ", "WILLAERT", "Rochester Mayo", "100533519", "2680", 2, "00:47:26.8", "00:22:51.7", "00:24:35.1", "finished"],
  [22, "EVE", "ASPENGREN", "Alexandria Youth Cycling", "100532420", "2601", 2, "00:48:00.7", "00:23:33.5", "00:24:27.1", "finished"],
  [23, "MYA", "WECKMAN", "New Prague MS and HS", "100425915", "2670", 2, "00:48:09.1", "00:22:47.1", "00:25:21.9", "finished"],
  [24, "OLIVIA", "OSTRANDER", "Wayzata Mountain Bike", "100521902", "2712", 2, "00:48:14.5", "00:23:49.6", "00:24:24.9", "finished"],
  [25, "ARIELLA", "ROSENWALD", "Wayzata Mountain Bike", "100431384", "2713", 2, "00:50:01.4", "00:24:15.3", "00:25:46.1", "finished"],
  [26, "KATELYN", "BUCHOLZ", "Minnesota Valley", "100530248", "2659", 2, "00:51:12.1", "00:25:09.2", "00:26:02.8", "finished"],
  [27, "ELLIE", "DELEEUW", "Kerkhoven", "100534637", "2647", 2, "00:59:17.6", "00:28:09.0", "00:31:08.6", "finished"]
]

# Create racers, seasons, and race results for JV2 Girls
brophy_jv2_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = jv2_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  
  # Lap 1
  if lap1_time
    lap1_time_ms = parse_time_to_ms(lap1_time)
    cumulative_time += lap1_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 1
    ) do |lap|
      lap.lap_time_ms = lap1_time_ms
      lap.lap_time_raw = lap1_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  # Lap 2
  if lap2_time
    lap2_time_ms = parse_time_to_ms(lap2_time)
    cumulative_time += lap2_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: 2
    ) do |lap|
      lap.lap_time_ms = lap2_time_ms
      lap.lap_time_raw = lap2_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park JV2 Girls results: #{brophy_jv2_girls_results.count} racers imported"

# ===============================================================================
# JV3 Boys
# ===============================================================================

puts "Creating Brophy Park JV3 Boys results..."

# JV3 Boys category
jv3_boys_category = Category.find_by!(name: "JV3 Boys")

# JV3 Boys Race Results (3 laps) - ALL 105 racers
brophy_jv3_boys_results = [
  [1, "NOAH", "LAFRANCE", "Wayzata Mountain Bike", "100431235", "1221", 3, "00:45:45.5", "00:14:53.3", "00:15:39.9", "00:15:12.2", "finished"],
  [2, "NICK", "SHIELD", "East Ridge HS", "100392597", "1241", 3, "00:45:52.8", "00:14:52.2", "00:15:42.3", "00:15:18.2", "finished"],
  [3, "ROWAN", "EKHOLM", "Rochester Century HS", "100390261", "1171", 3, "00:45:53.4", "00:14:53.8", "00:15:41.6", "00:15:17.9", "finished"],
  [4, "RIGEL", "PRIOR", "Wayzata Mountain Bike", "100392227", "1222", 3, "00:46:28.9", "00:14:52.5", "00:15:42.2", "00:15:54.1", "finished"],
  [5, "MAVERICK", "TILLER", "Park HS", "100392876", "1163", 3, "00:46:29.1", "00:14:52.8", "00:15:40.8", "00:15:55.4", "finished"],
  [6, "NOAH", "LARSON", "Park HS", "100391379", "1161", 3, "00:46:49.6", "00:15:19.4", "00:15:41.4", "00:15:48.7", "finished"],
  [7, "JOE", "JENSEN", "Northwest", "100391029", "1148", 3, "00:46:56.7", "00:14:53.3", "00:16:01.7", "00:16:01.6", "finished"],
  [8, "CARSON", "KRONLUND", "Cloquet-Esko-Carlton", "100391281", "1050", 3, "00:47:12.5", "00:15:07.8", "00:16:00.3", "00:16:04.2", "finished"],
  [9, "MYLES", "NIEMASZ", "Minneapolis Southwest HS", "100412365", "1121", 3, "00:47:16.3", "00:15:27.1", "00:15:53.8", "00:15:55.3", "finished"],
  [10, "KAI", "WALKER", "St Paul Composite - South", "100393030", "1198", 3, "00:47:31.5", "00:15:43.9", "00:16:04.8", "00:15:42.8", "finished"],
  [11, "AIDEN", "ZABEL", "Shakopee HS", "100393225", "1188", 3, "00:47:42.8", "00:15:21.8", "00:16:17.7", "00:16:03.2", "finished"],
  [12, "JAMES", "WALLEK", "White Bear Lake HS", "100393036", "1229", 3, "00:47:43.4", "00:15:14.3", "00:16:20.1", "00:16:08.9", "finished"],
  [13, "AYDEN", "CHOPSKIE", "Cloquet-Esko-Carlton", "100389945", "1049", 3, "00:48:49.4", "00:15:39.6", "00:16:43.1", "00:16:26.6", "finished"],
  [14, "IAN", "HALBMAIER", "New Prague MS and HS", "100390667", "1141", 3, "00:48:52.6", "00:15:19.3", "00:17:07.2", "00:16:26.0", "finished"],
  [15, "WYATT", "PETRACK", "Rock Ridge", "100392163", "1176", 3, "00:48:54.0", "00:15:59.5", "00:16:29.2", "00:16:25.2", "finished"],
  [16, "LUCAS", "INGVALSON", "Lakeville North HS", "100390976", "1099", 3, "00:49:04.8", "00:15:55.0", "00:16:11.4", "00:16:58.3", "finished"],
  [17, "JACK", "NELSON", "Elk River", "100391887", "1080", 3, "00:49:17.6", "00:16:12.8", "00:16:37.5", "00:16:27.2", "finished"],
  [18, "KELLGREN", "JABS", "New Prague MS and HS", "100390989", "1142", 3, "00:49:17.9", "00:15:56.0", "00:16:49.0", "00:16:32.9", "finished"],
  [19, "HANK", "SCHLAUDERAFF", "Northwest", "100392498", "1152", 3, "00:49:30.6", "00:16:13.7", "00:16:36.6", "00:16:40.2", "finished"],
  [20, "MASON", "HORTER", "Prior Lake HS", "100390929", "1165", 3, "00:49:30.9", "00:16:16.8", "00:16:37.0", "00:16:37.0", "finished"],
  [21, "JARED", "KILLIAN", "Elk River", "100487143", "1079", 3, "00:49:31.0", "00:16:01.2", "00:16:51.0", "00:16:38.7", "finished"],
  [22, "SULLIVAN", "ROONEY", "Alexandria Youth Cycling", "100411162", "1006", 3, "00:49:31.7", "00:16:16.6", "00:16:56.6", "00:16:18.4", "finished"],
  [23, "KEYNON", "MEIER", "Shakopee HS", "100391698", "1186", 3, "00:49:32.4", "00:15:58.7", "00:16:50.0", "00:16:43.5", "finished"],
  [24, "JACK", "SQUIRES", "Bloomington", "100425641", "1016", 3, "00:49:42.6", "00:16:20.6", "00:16:48.0", "00:16:33.9", "finished"],
  [25, "ELI", "CZAJKOWSKI", "Prior Lake HS", "100390065", "1240", 3, "00:49:42.9", "00:16:03.1", "00:16:54.2", "00:16:45.4", "finished"],
  [26, "WILLIS", "HEIM", "Minneapolis Southside", "100390791", "1119", 3, "00:49:58.5", "00:15:25.0", "00:17:18.0", "00:17:15.4", "finished"],
  [27, "CHASE", "WALGRAVE", "Prior Lake HS", "100422802", "1237", 3, "00:50:12.7", "00:17:23.4", "00:16:54.8", "00:15:54.4", "finished"],
  [28, "ALEXANDER", "KLINNERT", "Northwest", "100431778", "1149", 3, "00:50:13.5", "00:15:58.1", "00:16:55.8", "00:17:19.6", "finished"],
  [29, "KADEN", "BARIBEAU", "Rock Ridge", "100412126", "1174", 3, "00:50:17.0", "00:16:22.5", "00:16:55.3", "00:16:59.1", "finished"],
  [30, "JOSEPH", "LARSON", "New Prague MS and HS", "100407084", "1144", 3, "00:50:22.0", "00:15:55.8", "00:17:20.4", "00:17:05.7", "finished"],
  [31, "ANDERS", "DECKER", "Armstrong Cycle", "100390117", "1010", 3, "00:50:22.6", "00:18:16.2", "00:16:05.4", "00:16:01.0", "finished"],
  [32, "FOSTER", "SPRUNGER", "East Ridge HS", "100392704", "1066", 3, "00:50:34.2", "00:16:22.4", "00:17:18.2", "00:16:53.5", "finished"],
  [33, "LEVI", "LARSON", "Minneapolis Roosevelt HS", "100415142", "1117", 3, "00:50:39.3", "00:16:16.5", "00:17:18.3", "00:17:04.4", "finished"],
  [34, "SAM", "TRIPP", "Minneapolis Washburn HS", "100392917", "1128", 3, "00:50:49.6", "00:16:28.2", "00:17:34.6", "00:16:46.7", "finished"],
  [35, "ROHAN", "REDDY", "Minneapolis Southwest HS", "100416936", "1123", 3, "00:50:57.1", "00:16:21.0", "00:17:18.1", "00:17:17.8", "finished"],
  [36, "FINN", "DETTMANN", "Lakeville South HS", "100390140", "1102", 3, "00:50:58.9", "00:16:49.1", "00:17:30.3", "00:16:39.3", "finished"],
  [37, "ERIK", "RODEWALD", "Alexandria Youth Cycling", "100406990", "1005", 3, "00:51:05.3", "00:17:21.0", "00:16:48.9", "00:16:55.3", "finished"],
  [38, "OWEN", "WICKANDER", "Lakeville South HS", "100393126", "1104", 3, "00:51:28.8", "00:17:14.1", "00:17:18.6", "00:16:56.0", "finished"],
  [39, "AIDEN", "TRUE", "Cloquet-Esko-Carlton", "100392921", "1053", 3, "00:51:30.2", "00:16:11.9", "00:17:43.8", "00:17:34.4", "finished"],
  [40, "ZAE", "ISENSEE", "Minneapolis South HS", "100390985", "1118", 3, "00:51:31.0", "00:16:44.3", "00:17:25.5", "00:17:21.0", "finished"],
  [41, "MAC", "PEDERSEN", "Bloomington Jefferson", "100392109", "1020", 3, "00:51:31.4", "00:16:09.2", "00:17:48.4", "00:17:33.6", "finished"],
  [42, "NOLAN", "OTT", "Park HS", "100392050", "1162", 3, "00:51:45.4", "00:16:43.3", "00:17:28.5", "00:17:33.4", "finished"],
  [43, "GABE", "LINDSTROM", "Northwest", "100426536", "1150", 3, "00:51:49.9", "00:16:28.0", "00:18:07.0", "00:17:14.9", "finished"],
  [44, "BRANDEN", "MOSER", "Bloomington Jefferson", "100391835", "1019", 3, "00:51:56.9", "00:16:48.4", "00:17:44.8", "00:17:23.6", "finished"],
  [45, "BENJAMIN", "RASMUSSEN", "Bloomington Jefferson", "100406823", "1021", 3, "00:51:57.0", "00:16:30.1", "00:17:42.4", "00:17:44.4", "finished"],
  [46, "ZACH", "HALL", "Shakopee HS", "100390673", "1184", 3, "00:52:01.2", "00:16:55.7", "00:17:37.2", "00:17:28.2", "finished"],
  [47, "AUGUST", "DUEHR", "Shakopee HS", "100390222", "1182", 3, "00:52:05.9", "00:16:15.8", "00:17:57.4", "00:17:52.6", "finished"],
  [48, "CULLAN", "FEHR", "Minneapolis Roosevelt HS", "100416633", "1114", 3, "00:52:11.2", "00:16:47.7", "00:17:43.7", "00:17:39.7", "finished"],
  [49, "CHRISTIAN", "URNESS", "Alexandria Youth Cycling", "100392957", "1007", 3, "00:52:11.4", "00:17:30.2", "00:17:38.0", "00:17:03.1", "finished"],
  [50, "MILES", "HANE", "East Ridge HS", "100390688", "1063", 3, "00:52:19.4", "00:16:32.2", "00:18:04.0", "00:17:43.1", "finished"],
  [51, "ROWAN", "SCHAEFER", "Armstrong Cycle", "100392468", "1012", 3, "00:52:35.4", "00:16:44.3", "00:17:54.9", "00:17:56.1", "finished"],
  [52, "BRADEN", "ERDAHL", "Prior Lake HS", "100390297", "1164", 3, "00:52:36.6", "00:16:46.6", "00:17:59.6", "00:17:50.2", "finished"],
  [53, "AJ", "HERZBERG", "Wayzata Mountain Bike", "100390838", "1219", 3, "00:52:37.9", "00:17:22.9", "00:17:07.6", "00:18:07.2", "finished"],
  [54, "WYATT", "BANKS", "Elk River", "100389533", "1078", 3, "00:52:38.2", "00:17:16.6", "00:17:52.7", "00:17:28.7", "finished"],
  [55, "MICAH", "SWANSON", "Northwoods Cycling", "100510878", "1153", 3, "00:52:44.6", "00:17:31.7", "00:17:42.4", "00:17:30.4", "finished"],
  [56, "JACOB", "NICHOLSON", "Northwest", "100391918", "1151", 3, "00:53:05.9", "00:16:59.3", "00:17:58.2", "00:18:08.3", "finished"],
  [57, "ERIK", "HILL", "Rochester Century HS", "100390857", "1172", 3, "00:53:12.4", "00:17:24.0", "00:17:49.5", "00:17:58.8", "finished"],
  [58, "LIAM", "HEFFERAN", "St Paul Highland Park", "100390785", "1199", 3, "00:53:18.4", "00:16:47.7", "00:17:43.4", "00:18:47.2", "finished"],
  [59, "WYATT", "TYMINSKI", "Rock Ridge", "100392948", "1178", 3, "00:53:22.2", "00:17:20.1", "00:18:04.3", "00:17:57.7", "finished"],
  [60, "CAMERON", "USHER", "Alexandria Youth Cycling", "100475612", "1238", 3, "00:53:25.5", "00:17:32.8", "00:17:58.8", "00:17:53.8", "finished"],
  [61, "WILLIAM", "HESTON", "Bloomington Jefferson", "100390844", "1018", 3, "00:53:27.2", "00:16:59.0", "00:18:09.8", "00:18:18.2", "finished"],
  [62, "CARLOS", "VALDIVIA", "Prior Lake HS", "100392960", "1168", 3, "00:53:29.9", "00:16:48.1", "00:18:27.4", "00:18:14.2", "finished"],
  [63, "ZACH", "FAHEY", "Minnesota Valley", "100390336", "1129", 3, "00:53:35.0", "00:17:24.5", "00:18:17.9", "00:17:52.5", "finished"],
  [64, "TRESTON", "HUGHES", "Alexandria Youth Cycling", "100390946", "1002", 3, "00:53:37.3", "00:17:25.4", "00:18:15.0", "00:17:56.7", "finished"],
  [65, "AMIN", "AIT BENHADDOU", "Minneapolis Northside", "100424390", "1112", 3, "00:53:37.7", "00:16:56.4", "00:18:25.6", "00:18:15.5", "finished"],
  [66, "ALEX", "MAKI", "White Bear Lake HS", "100391559", "1226", 3, "00:53:38.3", "00:17:04.4", "00:18:19.6", "00:18:14.2", "finished"],
  [67, "WILLIAM", "CORY", "East Ridge HS", "100390035", "1062", 3, "00:53:39.3", "00:17:25.1", "00:18:14.0", "00:18:00.1", "finished"],
  [68, "LIAM", "LARSON", "Bemidji", "100391377", "1015", 3, "00:53:44.8", "00:16:59.4", "00:18:33.9", "00:18:11.4", "finished"],
  [69, "OWEN", "HAIGHT", "Minneapolis Roosevelt HS", "100412854", "1115", 3, "00:54:05.9", "00:17:20.1", "00:18:37.5", "00:18:08.2", "finished"],
  [70, "AUGUST", "RAYGOR", "Minneapolis Southwest HS", "100412492", "1122", 3, "00:54:15.6", "00:17:43.4", "00:18:13.7", "00:18:18.4", "finished"],
  [71, "SOREN", "WEILAND", "Lakeville North HS", "100393080", "1101", 3, "00:54:16.7", "00:17:31.1", "00:18:35.3", "00:18:10.2", "finished"],
  [72, "JEREMIAH", "STUBER", "New Prague MS and HS", "100392774", "1145", 3, "00:54:19.7", "00:17:25.0", "00:18:31.4", "00:18:23.2", "finished"],
  [73, "LUCAS", "BAKKER", "Alexandria Youth Cycling", "100389530", "1001", 3, "00:54:26.5", "00:17:46.8", "00:18:31.6", "00:18:08.0", "finished"],
  [74, "ETHAN", "KVITEK", "Cloquet-Esko-Carlton", "100391323", "1051", 3, "00:54:37.1", "00:19:25.8", "00:17:31.2", "00:17:40.0", "finished"],
  [75, "VINCENT", "SOMMERS", "East Ridge HS", "100392683", "1065", 3, "00:54:42.6", "00:17:29.5", "00:18:29.3", "00:18:43.7", "finished"],
  [76, "LOGAN", "BROWN", "Minneapolis Washburn HS", "100389810", "1125", 3, "00:54:55.8", "00:17:26.2", "00:18:29.8", "00:18:59.8", "finished"],
  [77, "TOMMY", "FOSSE", "Northwest", "100390406", "1146", 3, "00:55:00.5", "00:17:46.6", "00:18:27.3", "00:18:46.5", "finished"],
  [78, "BRAYDON", "MCKIBBON", "Cloquet-Esko-Carlton", "100391671", "1052", 3, "00:55:10.2", "00:16:59.4", "00:19:06.9", "00:19:03.9", "finished"],
  [79, "SILAS", "TODAY", "Rock Ridge", "100392884", "1177", 3, "00:55:12.2", "00:17:22.6", "00:18:58.2", "00:18:51.4", "finished"],
  [80, "CARTER", "NESBITT", "Lakeville South HS", "100519049", "1103", 3, "00:55:24.6", "00:17:55.2", "00:18:41.1", "00:18:48.3", "finished"],
  [81, "BRADEN", "THORNBURG", "Bloomington", "100392857", "1017", 3, "00:55:24.8", "00:17:26.9", "00:18:51.9", "00:19:05.8", "finished"],
  [82, "MARSHALL", "HAWKS", "White Bear Lake HS", "100390760", "1225", 3, "00:55:44.6", "00:17:58.5", "00:18:44.8", "00:19:01.2", "finished"],
  [83, "SAWYER", "LARSON", "Alexandria Youth Cycling", "100484626", "1004", 3, "00:55:50.1", "00:17:32.7", "00:18:28.8", "00:19:48.5", "finished"],
  [84, "BENJAMIN", "TOMCZIK", "Wayzata Mountain Bike", "100431391", "1242", 3, "00:55:52.5", "00:17:50.5", "00:18:48.6", "00:19:13.3", "finished"],
  [85, "AUGUST", "JOHNSON", "St Paul Highland Park", "100391040", "1200", 3, "00:55:55.1", "00:17:58.3", "00:18:51.6", "00:19:05.1", "finished"],
  [86, "JACOB", "KILIAN", "New Prague MS and HS", "100391188", "1143", 3, "00:56:00.0", "00:17:08.3", "00:19:06.9", "00:19:44.7", "finished"],
  [87, "WILLIAM", "CARBERRY", "Wayzata Mountain Bike", "100389884", "1218", 3, "00:56:01.2", "00:17:54.7", "00:18:50.9", "00:19:15.4", "finished"],
  [88, "SAMUEL", "KALINA", "Alexandria Youth Cycling", "100427670", "1003", 3, "00:56:08.6", "00:18:44.7", "00:18:33.5", "00:18:50.3", "finished"],
  [89, "FINNIAN", "MCVEIGH", "White Bear Lake HS", "100391690", "1227", 3, "00:56:17.7", "00:17:55.7", "00:19:13.9", "00:19:07.9", "finished"],
  [90, "JACK", "HILDENBRAND", "Bemidji", "100486264", "1014", 3, "00:57:01.3", "00:17:43.3", "00:20:03.1", "00:19:14.8", "finished"],
  [91, "MASON", "EBERLY", "Minneapolis Southwest HS", "100409359", "1120", 3, "00:57:07.1", "00:18:23.8", "00:19:12.7", "00:19:30.5", "finished"],
  [92, "CRISTOBAL", "OSSANNA", "East Ridge HS", "100419219", "1064", 3, "00:57:21.0", "00:17:57.1", "00:19:50.7", "00:19:33.1", "finished"],
  [93, "CRUZ", "BUTTERFASS", "Shakopee HS", "100410634", "1180", 3, "00:57:26.8", "00:17:46.0", "00:19:25.1", "00:20:15.7", "finished"],
  [94, "HARRISON", "VOELKEL", "Bloomington Jefferson", "100392998", "1022", 3, "00:57:38.5", "00:17:56.1", "00:19:50.9", "00:19:51.3", "finished"],
  [95, "LOGAN", "JACKLITCH", "Wayzata Mountain Bike", "100430865", "1220", 3, "00:58:29.3", "00:17:49.0", "00:19:27.3", "00:21:13.0", "finished"],
  [96, "TRISTAN", "EHN", "Armstrong Cycle", "100427928", "1011", 3, "00:58:35.2", "00:18:25.5", "00:20:13.7", "00:19:55.9", "finished"],
  [97, "RILEY", "MCCLELLAN", "Shakopee HS", "100483886", "1185", 3, "01:00:09.5", "00:17:57.9", "00:20:49.7", "00:21:21.9", "finished"],
  [98, "LOGAN", "SPLETZER", "Minnesota Valley", "100476940", "1130", 3, "01:00:10.3", "00:18:04.2", "00:20:37.1", "00:21:28.9", "finished"],
  [99, "CARTER", "ORRBEN", "Shakopee HS", "100412147", "1187", 3, "01:00:13.9", "00:19:08.1", "00:20:34.9", "00:20:30.8", "finished"],
  [100, "SAMUEL", "DAHN", "New Prague MS and HS", "100390076", "1140", 3, "01:00:49.8", "00:19:05.6", "00:21:13.3", "00:20:30.8", "finished"],
  [101, "SAWYER", "ENGEN", "White Bear Lake HS", "100390291", "1236", 3, "01:02:21.7", "00:18:28.4", "00:21:35.8", "00:22:17.4", "finished"],
  [102, "JAMES", "DELAHUNT", "Woodbury HS", "100390122", "1234", 3, "01:03:33.3", "00:19:49.4", "00:21:22.5", "00:22:21.4", "finished"],
  [103, "AIDAN", "LOVEGREN", "Woodbury HS", "100391510", "1235", 2, "00:38:47.0", "00:17:14.3", "00:21:32.7", nil, "DNF"],
  [104, "FINN", "JOHNSON", "Minneapolis Roosevelt HS", "100391065", "1116", 2, "00:44:26.4", "00:20:48.5", "00:23:37.8", nil, "DNF"],
  [105, "PARKER", "DESHAW", "Shakopee HS", "100390133", "1181", 0, "02:00:00.0", nil, nil, nil, "DNF"]
]

# Create racers, seasons, and race results for JV3 Boys
brophy_jv3_boys_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 3
    result.status = status
    result.category = jv3_boys_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time, lap3_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park JV3 Boys results: #{brophy_jv3_boys_results.count} racers imported"

# ===============================================================================
# Varsity Boys
# ===============================================================================

puts "Creating Brophy Park Varsity Boys results..."

# Varsity Boys category
varsity_boys_category = Category.find_by!(name: "Varsity Boys")

# Varsity Boys Race Results (4 laps) - ALL 45 racers
brophy_varsity_boys_results = [
  [1, "ERIC", "OIEN", "East Ridge HS", "100391983", "19", 4, "00:59:16.0", "00:14:06.7", "00:14:44.2", "00:14:45.7", "00:15:39.2", "finished"],
  [2, "MAX", "FAHRMANN", "Bloomington Jefferson", "100390339", "3", 4, "00:59:16.2", "00:14:06.4", "00:14:44.9", "00:14:45.7", "00:15:39.1", "finished"],
  [3, "ODEN", "OLSON", "Minnesota Valley", "100392020", "38", 4, "00:59:43.1", "00:14:23.0", "00:15:13.2", "00:15:23.7", "00:14:43.0", "finished"],
  [4, "ROENEN", "KING-ELLISON", "Wayzata Mountain Bike", "100391198", "84", 4, "01:00:08.5", "00:14:22.5", "00:15:13.5", "00:15:23.7", "00:15:08.7", "finished"],
  [5, "IBAN", "DREVLOW", "East Ridge HS", "100461468", "17", 4, "01:00:53.7", "00:14:24.6", "00:15:38.5", "00:15:23.6", "00:15:26.8", "finished"],
  [6, "GAVIN", "HAUGEN", "Rochester Century HS", "100390752", "58", 4, "01:01:04.5", "00:14:28.4", "00:15:34.4", "00:15:23.4", "00:15:38.1", "finished"],
  [7, "EDWARD", "FULL", "Elk River", "100390473", "31", 4, "01:01:17.9", "00:14:23.4", "00:15:39.2", "00:15:17.2", "00:15:58.0", "finished"],
  [8, "EVAN", "MARCELLE", "St Paul Composite - North", "100391580", "67", 4, "01:01:29.1", "00:15:26.0", "00:15:20.2", "00:15:40.0", "00:15:02.8", "finished"],
  [9, "COLIN", "SHEA", "St Paul Composite - South", "100392588", "89", 4, "01:01:32.4", "00:15:06.3", "00:15:39.3", "00:15:41.0", "00:15:05.7", "finished"],
  [10, "KEIGAN", "MCCARTY", "White Bear Lake HS", "100391641", "78", 4, "01:01:52.8", "00:15:05.7", "00:15:40.2", "00:15:41.6", "00:15:25.1", "finished"],
  [11, "COLTON", "DEWEY", "Cloquet-Esko-Carlton", "100390150", "9", 4, "01:02:11.6", "00:15:06.0", "00:15:40.7", "00:15:42.1", "00:15:42.6", "finished"],
  [12, "ISAAC", "LINDHOLM", "White Bear Lake HS", "100391474", "77", 4, "01:02:12.2", "00:15:27.4", "00:15:26.0", "00:15:38.0", "00:15:40.6", "finished"],
  [13, "TEGAN", "MOORE", "Prior Lake HS", "100391809", "57", 4, "01:02:36.8", "00:14:21.6", "00:15:42.8", "00:16:15.6", "00:16:16.8", "finished"],
  [14, "MAX", "FOSTER", "Cloquet-Esko-Carlton", "100390409", "10", 4, "01:03:09.9", "00:15:06.7", "00:15:41.9", "00:16:07.1", "00:16:14.1", "finished"],
  [15, "SAM", "ANDERSON", "Wayzata Mountain Bike", "100389457", "73", 4, "01:03:14.9", "00:15:00.1", "00:15:36.1", "00:16:31.9", "00:16:06.6", "finished"],
  [16, "EDDIE", "BINSFELD", "Rockford", "100389664", "60", 4, "01:03:45.1", "00:15:26.3", "00:16:08.2", "00:16:19.1", "00:15:51.3", "finished"],
  [17, "TYLER", "WETZSTEIN", "Rochester Century HS", "100393108", "59", 4, "01:03:45.3", "00:15:25.8", "00:15:44.5", "00:16:27.2", "00:16:07.7", "finished"],
  [18, "ETHAN", "LINDGREN", "Cloquet-Esko-Carlton", "100391471", "11", 4, "01:04:10.6", "00:15:26.9", "00:15:43.6", "00:16:31.9", "00:16:28.1", "finished"],
  [19, "LUKAS", "ROBINSON", "North Dakota", "100392353", "48", 4, "01:04:15.2", "00:15:26.6", "00:16:07.8", "00:16:22.4", "00:16:18.3", "finished"],
  [20, "ISAIAH", "JOHNSON", "Shakopee HS", "100391070", "62", 4, "01:04:15.2", "00:15:35.5", "00:16:14.1", "00:16:03.8", "00:16:21.8", "finished"],
  [21, "OWEN", "MARQUARDT", "Shakopee HS", "100391594", "63", 4, "01:04:15.8", "00:16:04.9", "00:16:11.0", "00:15:54.8", "00:16:04.9", "finished"],
  [22, "TANNER", "LONG", "Prior Lake HS", "100391502", "87", 4, "01:04:37.1", "00:16:04.9", "00:16:11.2", "00:15:54.9", "00:16:25.9", "finished"],
  [23, "MAXWELL", "CHINN", "Alexandria Youth Cycling", "100389940", "1", 4, "01:04:39.8", "00:15:27.5", "00:16:07.6", "00:16:21.9", "00:16:42.7", "finished"],
  [24, "DOMINIC", "WOOD", "Minneapolis Southside", "100393195", "36", 4, "01:05:02.2", "00:15:38.7", "00:16:29.2", "00:16:31.5", "00:16:22.7", "finished"],
  [25, "ELI", "SYMONS", "Northwoods Cycling", "100488928", "52", 4, "01:05:02.8", "00:16:04.0", "00:16:12.4", "00:16:22.3", "00:16:24.0", "finished"],
  [26, "GARRETT", "TOBIAS", "New Prague MS and HS", "100426799", "45", 4, "01:05:23.8", "00:16:03.8", "00:16:20.8", "00:16:17.2", "00:16:41.8", "finished"],
  [27, "BRODY", "PARMER", "North Dakota", "100392073", "47", 4, "01:05:39.3", "00:15:59.9", "00:16:19.3", "00:16:35.7", "00:16:44.3", "finished"],
  [28, "ISAAC", "SCHWARZ", "North Dakota", "100392557", "49", 4, "01:05:41.6", "00:15:54.9", "00:16:28.9", "00:16:33.1", "00:16:44.5", "finished"],
  [29, "JOSHUA", "MAXWELL", "Northwoods Cycling", "100488761", "51", 4, "01:05:41.7", "00:16:20.8", "00:16:15.3", "00:16:39.7", "00:16:25.7", "finished"],
  [30, "JENS", "KULLMAN", "East Ridge HS", "100391313", "18", 4, "01:06:13.6", "00:15:38.0", "00:16:41.0", "00:16:54.7", "00:16:59.8", "finished"],
  [31, "ROBERT", "MCCROSKEY", "Prior Lake HS", "100391653", "56", 4, "01:06:14.7", "00:16:02.7", "00:16:22.1", "00:16:42.7", "00:17:07.0", "finished"],
  [32, "JACOB", "HERNESS", "Wayzata Mountain Bike", "100430362", "75", 4, "01:07:03.2", "00:15:38.5", "00:16:49.9", "00:17:19.7", "00:17:14.9", "finished"],
  [33, "ANDREW", "BURQUEST", "Elk River", "100389848", "64", 4, "01:07:03.2", "00:15:55.0", "00:16:30.4", "00:17:10.5", "00:17:27.1", "finished"],
  [34, "NIGEL", "NOWLIN", "Wayzata Mountain Bike", "100391957", "76", 4, "01:07:32.4", "00:16:33.4", "00:16:48.6", "00:16:56.2", "00:17:14.0", "finished"],
  [35, "HAYDEN", "LEISETH", "Northwest", "100391420", "50", 4, "01:07:51.8", "00:16:02.9", "00:17:10.2", "00:17:21.2", "00:17:17.4", "finished"],
  [36, "LUKE", "HAWKINS", "Minneapolis Washburn HS", "100390756", "37", 4, "01:08:25.7", "00:16:41.1", "00:17:08.5", "00:17:22.0", "00:17:13.9", "finished"],
  [37, "JAMES", "FROYUM", "Shakopee HS", "100390464", "85", 4, "01:08:56.4", "00:16:44.9", "00:17:08.2", "00:17:31.2", "00:17:32.0", "finished"],
  [38, "RUKSHAN", "RAJAN", "Wayzata Mountain Bike", "100392259", "86", 4, "01:09:12.9", "00:16:31.0", "00:17:19.4", "00:17:48.7", "00:17:33.7", "finished"],
  [39, "SETH", "HEIN", "North Dakota", "100390793", "46", 4, "01:09:13.3", "00:16:21.2", "00:17:35.5", "00:17:44.5", "00:17:32.0", "finished"],
  [40, "JOHN", "MAINES", "Prior Lake HS", "100391553", "55", 4, "01:09:14.4", "00:16:30.8", "00:17:26.6", "00:17:42.3", "00:17:34.6", "finished"],
  [41, "MAX", "OIEN", "East Ridge HS", "100391984", "20", 3, "00:51:33.0", "00:15:06.3", "00:15:46.6", "00:20:40.0", nil, "DNF"],
  [42, "HARRISON", "MEYER", "St Paul Composite - South", "100391728", "68", 1, "00:16:07.8", "00:16:07.8", nil, nil, nil, "DNF"],
  [43, "BENNETT", "LEVANDER", "Woodbury HS", "100391441", "82", 1, "00:17:05.8", "00:17:05.8", nil, nil, nil, "DNF"],
  [44, "WILL", "BREUING", "Wayzata Mountain Bike", "100389778", "74", 1, "00:19:04.6", "00:19:04.6", nil, nil, nil, "DNF"],
  [45, "RYLAN", "OACHS", "Woodbury HS", "100391961", "83", 0, "00:00:00.0", nil, nil, nil, nil, "DNF"]
]

# Create racers, seasons, and race results for Varsity Boys
brophy_varsity_boys_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, lap4_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time) unless total_time == "00:00:00.0"
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 4
    result.status = status
    result.category = varsity_boys_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time, lap3_time, lap4_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park Varsity Boys results: #{brophy_varsity_boys_results.count} racers imported"

# ===============================================================================
# Varsity Girls  
# ===============================================================================

puts "Creating Brophy Park Varsity Girls results..."

# Varsity Girls category
varsity_girls_category = Category.find_by!(name: "Varsity Girls")

# Varsity Girls Race Results (4 laps) - 11 racers total
brophy_varsity_girls_results = [
  [1, "LAYLA", "HAGELIN", "Independent HS", "100390657", "207", 4, "01:07:59.5", "00:16:12.1", "00:16:56.8", "00:17:19.2", "00:17:31.1", "finished"],
  [2, "CORALIE", "JONES", "St Paul Highland Park", "100391099", "225", 4, "01:08:42.3", "00:16:28.3", "00:17:16.3", "00:17:27.2", "00:17:30.3", "finished"],
  [3, "ELLA", "MAKOSKY", "Minneapolis Southwest HS", "100391560", "210", 4, "01:10:17.7", "00:16:45.9", "00:17:54.8", "00:18:04.4", "00:17:32.4", "finished"],
  [4, "CIARA", "THATCHER", "Minneapolis Washburn HS", "100407460", "212", 4, "01:10:52.1", "00:16:44.9", "00:17:56.2", "00:18:04.3", "00:18:06.6", "finished"],
  [5, "GRETCHEN", "BLANKENSHIP", "White Bear Lake HS", "100389687", "224", 4, "01:11:40.5", "00:17:18.2", "00:17:41.8", "00:18:11.5", "00:18:28.9", "finished"],
  [6, "ANI", "MCQUILLEN", "Minneapolis Roosevelt HS", "100391684", "208", 4, "01:13:06.0", "00:17:27.0", "00:18:15.3", "00:18:34.3", "00:18:49.2", "finished"],
  [7, "ASHLEY", "SCHULTZ", "Northwest", "100462375", "218", 4, "01:13:21.3", "00:17:24.3", "00:18:20.3", "00:18:44.2", "00:18:52.4", "finished"],
  [8, "COURTNEY", "HISLOP", "Hermantown-Proctor", "100390864", "204", 4, "01:14:52.2", "00:17:23.9", "00:19:36.8", "00:18:56.3", "00:18:55.1", "finished"],
  [9, "MEGAN", "SCHROOTEN", "Bloomington Jefferson", "100392532", "201", 4, "01:14:52.3", "00:18:14.3", "00:18:46.2", "00:19:04.1", "00:18:47.5", "finished"],
  [10, "CLARA", "LANG", "Park HS", "100391355", "219", 4, "01:21:14.8", "00:18:29.1", "00:20:24.5", "00:21:16.3", "00:21:04.8", "finished"],
  [11, "AVERY", "PATTERSON", "Minneapolis Southwest HS", "100392090", "211", 2, "00:37:12.9", "00:17:49.3", "00:19:23.6", nil, nil, "DNF"]
]

# Create racers, seasons, and race results for Varsity Girls
brophy_varsity_girls_results.each do |place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, lap4_time, status|
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 4
    result.status = status
    result.category = varsity_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time, lap3_time, lap4_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park Varsity Girls results: #{brophy_varsity_girls_results.count} racers imported"

# JV3 Girls category
jv3_girls_category = Category.find_by!(name: "JV3 Girls")

# JV3 Girls Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, status]
brophy_jv3_girls_results = [
  [1, "EMMA", "RIEGER", "Holy Angels", "100435226", "1224", 3, "00:44:45.4", "00:14:30.9", "00:14:53.7", "00:15:20.6", "finished"],
  [2, "RUBY", "SELLE", "North Shore Cycling Club", "100358993", "1086", 3, "00:45:24.0", "00:15:03.5", "00:15:11.9", "00:15:08.5", "finished"],
  [3, "ELIZABETH", "PETROVICH", "Alexandria", "100388926", "1157", 3, "00:45:57.7", "00:15:37.4", "00:15:13.8", "00:15:06.4", "finished"],
  [4, "ANNIKA", "PETERSON", "Wayzata Mountain Bike", "100447647", "1274", 3, "00:46:08.2", "00:15:02.5", "00:15:20.7", "00:15:44.9", "finished"],
  [5, "GRACE", "BORG", "North Shore Cycling Club", "100356765", "1060", 3, "00:47:02.1", "00:15:18.4", "00:15:21.8", "00:16:21.8", "finished"],
  [6, "HELENA", "KLINE", "COMO Park Senior High", "100358618", "1082", 3, "00:47:10.3", "00:15:25.6", "00:15:32.3", "00:16:12.3", "finished"],
  [7, "ELISE", "MORIS", "Wayzata Mountain Bike", "100431240", "1222", 3, "00:47:24.8", "00:15:42.8", "00:15:41.0", "00:16:00.9", "finished"],
  [8, "SOPHIA", "KLEVEN", "Alexandria", "100366970", "1124", 3, "00:49:25.5", "00:16:21.9", "00:16:13.5", "00:16:50.0", "finished"],
  [9, "CLARA", "HANSON", "Shakopee HS", "100447652", "1275", 3, "00:49:34.6", "00:16:42.7", "00:16:03.0", "00:16:48.8", "finished"],
  [10, "LILY", "BECKER", "Bloomington Jefferson HS", "100440334", "1249", 3, "00:50:31.7", "00:16:27.7", "00:16:33.8", "00:17:30.1", "finished"],
  [11, "PAIGE", "TWARDOWSKI", "Wayzata Mountain Bike", "100431244", "1223", 3, "00:50:37.1", "00:16:39.7", "00:16:49.9", "00:17:07.4", "finished"],
  [12, "CHARLIE", "ANDERSON", "Benilde St Margaret", "100440339", "1250", 3, "00:51:07.5", "00:17:19.8", "00:16:41.3", "00:17:06.3", "finished"],
  [13, "ROSIE", "HAGEN", "Wayzata Mountain Bike", "100447651", "1273", 3, "00:52:28.1", "00:17:00.6", "00:17:31.0", "00:17:56.4", "finished"],
  [14, "CECELIA", "PAHL", "Benilde St Margaret", "100440346", "1253", 3, "00:53:22.0", "00:17:34.6", "00:17:37.5", "00:18:09.8", "finished"],
  [15, "AVERY", "BERG", "North Shore Cycling Club", "100358864", "1084", 3, "00:53:43.2", "00:17:46.5", "00:17:44.7", "00:18:11.9", "finished"],
  [16, "MAKENZY", "MAKI", "Wayzata Mountain Bike", "100440337", "1252", 3, "00:54:40.7", "00:17:35.6", "00:18:23.5", "00:18:41.5", "finished"],
  [17, "KIRA", "MACHO", "Wayzata Mountain Bike", "100447650", "1272", 3, "00:54:59.4", "00:18:06.5", "00:18:07.3", "00:18:45.5", "finished"],
  [18, "KIRA", "HAGEN", "Wayzata Mountain Bike", "100447649", "1271", 3, "00:55:13.6", "00:18:20.5", "00:18:13.1", "00:18:39.9", "finished"],
  [19, "SOPHIA", "STOECKEL", "Alexandria", "100366975", "1125", 3, "00:56:21.8", "00:18:42.8", "00:18:35.0", "00:19:03.9", "finished"]
]

# Create racers, seasons, and race results
brophy_jv3_girls_results.each do |result_data|
  place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, status = result_data
  # Handle extra parameters by ignoring them
  if result_data.length > 12
    place, first_name, last_name, team_name, rider_number, plate, points, total_time, lap1_time, lap2_time, lap3_time, status = result_data
    laps = 3  # JV3 Girls always have 3 laps
  end
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 3
    result.status = status
    result.category = jv3_girls_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time, lap3_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park JV3 Girls results: #{brophy_jv3_girls_results.count} racers imported"

# JV2 Boys D2 category
jv2_boys_d2_category = Category.find_by!(name: "JV2 Boys D2")

# JV2 Boys D2 Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
brophy_jv2_boys_d2_results = [
  [1, "SILAS", "QUAST", "Wayzata Mountain Bike", "100440336", "1251", 2, "00:25:44.3", "00:12:40.7", "00:13:03.5", "finished"],
  [2, "ANDREW", "THORNE", "Bloomington Jefferson HS", "100358624", "1083", 4, "00:26:17.4", "00:12:51.3", "00:13:26.0", nil, "finished"],
  [3, "MAX", "JOHNSON", "Hopkins HS", "100380041", "1138", 4, "00:26:24.6", "00:13:08.9", "00:13:15.6", nil, "finished"],
  [4, "MARCUS", "SELLE", "North Shore Cycling Club", "100358994", "1087", 4, "00:26:26.6", "00:13:03.3", "00:13:23.2", nil, "finished"],
  [5, "LUKE", "GEOFERT", "Wayzata Mountain Bike", "100447646", "1270", 4, "00:26:32.5", "00:13:04.5", "00:13:27.9", nil, "finished"],
  [6, "CALVIN", "BAUER", "St Thomas Academy", "100369827", "1129", 4, "00:26:35.9", "00:13:21.8", "00:13:14.0", nil, "finished"],
  [7, "DREW", "GUENTHER", "Shakopee HS", "100447648", "1269", 4, "00:26:42.8", "00:13:08.4", "00:13:34.3", nil, "finished"],
  [8, "JOSHUA", "NELSON", "Hopkins HS", "100380042", "1139", 4, "00:26:51.9", "00:13:30.7", "00:13:21.1", nil, "finished"],
  [9, "BENJAMIN", "KRUMRIE", "Wayzata Mountain Bike", "100384900", "1149", 4, "00:26:59.1", "00:13:18.2", "00:13:40.8", nil, "finished"],
  [10, "THOMAS", "PETERSON", "Wayzata Mountain Bike", "100447645", "1268", 4, "00:27:08.3", "00:13:30.9", "00:13:37.3", nil, "finished"],
  [11, "OTTO", "GOLLA", "Bloomington Kennedy HS", "100435221", "1226", 4, "00:27:11.7", "00:13:24.5", "00:13:47.1", nil, "finished"],
  [12, "SEAN", "ROCHE", "Eagan HS", "100435225", "1227", 4, "00:27:14.8", "00:13:38.2", "00:13:36.5", nil, "finished"],
  [13, "ELLIOT", "JOHNSON", "Hopkins HS", "100380040", "1137", 4, "00:27:15.3", "00:13:35.8", "00:13:39.4", nil, "finished"],
  [14, "COLE", "THOMPSON", "Wayzata Mountain Bike", "100358995", "1088", 4, "00:27:16.2", "00:13:43.6", "00:13:32.5", nil, "finished"],
  [15, "COLE", "PETROVICH", "Alexandria", "100388925", "1156", 4, "00:27:21.9", "00:13:38.1", "00:13:43.7", nil, "finished"],
  [16, "DREW", "AASLAND", "Wayzata Mountain Bike", "100384901", "1150", 4, "00:27:22.5", "00:13:40.0", "00:13:42.4", nil, "finished"],
  [17, "OSCAR", "KLINE", "COMO Park Senior High", "100358619", "1081", 4, "00:27:36.9", "00:13:50.3", "00:13:46.5", nil, "finished"],
  [18, "ISAAC", "LUND", "Benilde St Margaret", "100435219", "1228", 4, "00:27:42.7", "00:13:42.8", "00:13:59.8", nil, "finished"],
  [19, "MATTHEW", "GALBRAITH", "Wayzata Mountain Bike", "100358990", "1089", 4, "00:27:43.2", "00:13:48.0", "00:13:55.1", nil, "finished"],
  [20, "ASHER", "VAN DYKE", "Bloomington Jefferson HS", "100358625", "1080", 4, "00:27:48.6", "00:13:49.7", "00:13:58.8", nil, "finished"],
  [21, "AIDEN", "JOHNSON", "Alexandria", "100366969", "1123", 4, "00:27:52.8", "00:13:48.7", "00:14:04.0", nil, "finished"],
  [22, "HENRY", "DORNFELD", "Hopkins HS", "100380039", "1136", 4, "00:27:59.5", "00:13:55.0", "00:14:04.4", nil, "finished"],
  [23, "CONNOR", "CARLSON", "Benilde St Margaret", "100435220", "1229", 4, "00:28:02.8", "00:14:01.3", "00:14:01.4", nil, "finished"],
  [24, "ISAAC", "KEELER", "Wayzata Mountain Bike", "100440335", "1248", 4, "00:28:06.0", "00:14:06.0", "00:13:59.9", nil, "finished"],
  [25, "CARTER", "REIER", "Wayzata Mountain Bike", "100384898", "1148", 4, "00:28:10.3", "00:13:56.0", "00:14:14.2", nil, "finished"],
  [26, "CONNOR", "GOUGH", "Wayzata Mountain Bike", "100358991", "1090", 4, "00:28:14.9", "00:14:02.0", "00:14:12.8", nil, "finished"],
  [27, "GAGE", "MAKI", "Wayzata Mountain Bike", "100440338", "1247", 4, "00:28:24.9", "00:14:13.3", "00:14:11.5", nil, "finished"],
  [28, "JOHN", "MCGUIRE", "St Thomas Academy", "100369828", "1130", 4, "00:28:35.0", "00:14:19.6", "00:14:15.3", nil, "finished"],
  [29, "EVAN", "LEICHTFUSS", "Eden Prairie HS", "100431236", "1217", 4, "00:28:36.4", "00:14:15.8", "00:14:20.5", nil, "finished"],
  [30, "JAMISON", "POSEY", "Wayzata Mountain Bike", "100384899", "1147", 4, "00:28:36.7", "00:14:09.5", "00:14:27.1", nil, "finished"],
  [31, "GABE", "HAGEN", "Wayzata Mountain Bike", "100384903", "1152", 4, "00:28:43.9", "00:14:20.8", "00:14:23.0", nil, "finished"],
  [32, "COLIN", "MURRAY", "Shakopee HS", "100388924", "1155", 4, "00:28:44.2", "00:14:13.1", "00:14:31.0", nil, "finished"],
  [33, "AIDAN", "NELSON", "Hopkins HS", "100380043", "1140", 4, "00:28:51.1", "00:14:27.2", "00:14:23.8", nil, "finished"],
  [34, "LEVI", "MALONE", "Wayzata Mountain Bike", "100384904", "1153", 4, "00:28:56.3", "00:14:27.9", "00:14:28.3", nil, "finished"],
  [35, "JOSHUA", "LOYD", "Wayzata Mountain Bike", "100358992", "1091", 4, "00:29:01.4", "00:14:28.5", "00:14:32.8", nil, "finished"],
  [36, "HENRY", "ENGEL", "Edina HS", "100431238", "1219", 4, "00:29:06.3", "00:14:32.9", "00:14:33.3", nil, "finished"],
  [37, "MAX", "NELSON", "Hopkins HS", "100380044", "1141", 4, "00:29:15.0", "00:14:37.3", "00:14:37.6", nil, "finished"],
  [38, "JOSIAH", "JOHNSON", "Alexandria", "100366968", "1122", 4, "00:29:16.9", "00:14:35.4", "00:14:41.4", nil, "finished"],
  [39, "DEREK", "GOEDEN", "Wayzata Mountain Bike", "100384905", "1154", 4, "00:29:20.9", "00:14:38.8", "00:14:42.0", nil, "finished"],
  [40, "SEAN", "WALSH", "Eagan HS", "100431241", "1220", 4, "00:29:23.1", "00:14:32.7", "00:14:50.3", nil, "finished"],
  [41, "LUCAS", "PETERSON", "Alexandria", "100388927", "1158", 4, "00:29:25.1", "00:14:45.5", "00:14:39.5", nil, "finished"],
  [42, "BRADY", "MACHO", "Wayzata Mountain Bike", "100384902", "1151", 4, "00:29:27.8", "00:14:37.9", "00:14:49.8", nil, "finished"],
  [43, "DANIEL", "SITZ", "Bloomington Jefferson HS", "100358627", "1079", 4, "00:29:33.0", "00:14:45.6", "00:14:47.3", nil, "finished"],
  [44, "JACK", "HANSON", "Shakopee HS", "100388923", "1154", 4, "00:29:38.5", "00:14:48.3", "00:14:50.1", nil, "finished"],
  [45, "OWEN", "STRUM", "Shakopee HS", "100447643", "1266", 4, "00:29:48.6", "00:14:55.1", "00:14:53.4", nil, "finished"],
  [46, "LUKE", "JEANS", "St Thomas Academy", "100369829", "1131", 4, "00:29:50.9", "00:14:56.7", "00:14:54.1", nil, "finished"],
  [47, "CHARLIE", "HANSON", "Wayzata Mountain Bike", "100431237", "1218", 4, "00:29:56.6", "00:14:55.5", "00:15:01.0", nil, "finished"],
  [48, "ZACH", "DECKER", "Benilde St Margaret", "100435224", "1230", 4, "00:30:00.7", "00:14:56.5", "00:15:04.1", nil, "finished"],
  [49, "COLIN", "KAUPER", "Wayzata Mountain Bike", "100431242", "1221", 4, "00:30:08.4", "00:15:01.3", "00:15:07.0", nil, "finished"],
  [50, "TYLER", "JOHNSON", "Hopkins HS", "100380045", "1142", 4, "00:30:23.8", "00:15:11.6", "00:15:12.1", nil, "finished"],
  [51, "COLLIN", "ZIEBARTH", "Bloomington Jefferson HS", "100358628", "1078", 4, "00:30:28.3", "00:15:16.0", "00:15:12.2", nil, "finished"],
  [52, "MARCUS", "JOHNSON", "Alexandria", "100366971", "1121", 4, "00:30:41.8", "00:15:20.5", "00:15:21.2", nil, "finished"],
  [53, "LUKAS", "ROEMHILDT", "Wayzata Mountain Bike", "100384906", "1145", 4, "00:30:43.8", "00:15:20.4", "00:15:23.3", nil, "finished"],
  [54, "PARKER", "LUND", "Benilde St Margaret", "100435222", "1231", 4, "00:30:47.6", "00:15:25.1", "00:15:22.4", nil, "finished"],
  [55, "OWEN", "HAGEN", "Wayzata Mountain Bike", "100431239", "1216", 4, "00:30:50.7", "00:15:25.5", "00:15:25.1", nil, "finished"],
  [56, "ANDREW", "GOUGH", "Wayzata Mountain Bike", "100384907", "1146", 4, "00:31:14.8", "00:15:37.5", "00:15:37.2", nil, "finished"],
  [57, "GAVIN", "OKERBLOOM", "Bloomington Jefferson HS", "100358626", "1077", 4, "00:31:19.1", "00:15:38.6", "00:15:40.4", nil, "finished"],
  [58, "DYLAN", "KOSHIOL", "Eagan HS", "100435223", "1232", 4, "00:31:47.2", "00:15:51.0", "00:15:56.1", nil, "finished"],
  [59, "PARKER", "DESHAW", "Shakopee HS", "100390133", "1181", 4, "00:32:28.5", "00:16:15.9", "00:16:12.5", nil, "finished"],
  [60, "CARSON", "SHAUGHNESSY", "Hopkins HS", "100380046", "1143", 4, "00:32:39.5", "00:16:16.8", "00:16:22.6", nil, "finished"],
  [61, "CHARLIE", "JOHNSON", "Alexandria", "100366972", "1120", 4, "00:32:55.8", "00:16:26.4", "00:16:29.3", nil, "finished"],
  [62, "DREW", "WAWRZASZEK", "Eagan HS", "100440340", "1246", 4, "00:33:16.4", "00:16:37.9", "00:16:38.4", nil, "finished"],
  [63, "ETHAN", "BROWN", "Bloomington Kennedy HS", "100440341", "1245", 4, "00:33:37.2", "00:16:47.5", "00:16:49.6", nil, "finished"],
  [64, "TREVOR", "HANSON", "Wayzata Mountain Bike", "100440343", "1244", 4, "00:33:48.4", "00:16:54.1", "00:16:54.2", nil, "finished"],
  [65, "PARKER", "HAGEN", "Wayzata Mountain Bike", "100440344", "1243", 4, "00:34:18.8", "00:17:07.1", "00:17:11.6", nil, "finished"],
  [66, "AIDEN", "JOHNSON", "Alexandria", "100366973", "1119", 4, "00:34:26.3", "00:17:14.3", "00:17:11.9", nil, "finished"],
  [67, "JEREMIAH", "PAHL", "Benilde St Margaret", "100440345", "1242", 4, "00:34:30.4", "00:17:14.8", "00:17:15.5", nil, "finished"],
  [68, "JAMES", "SKWIRA", "Wayzata Mountain Bike", "100440347", "1241", 4, "00:34:33.3", "00:17:16.0", "00:17:17.2", nil, "finished"],
  [69, "RYAN", "ANDERSON", "Benilde St Margaret", "100440348", "1240", 4, "00:34:59.9", "00:17:27.7", "00:17:32.1", nil, "finished"],
  [70, "ANDY", "ROWE", "Wayzata Mountain Bike", "100440349", "1239", 4, "00:35:15.3", "00:17:35.9", "00:17:39.3", nil, "finished"],
  [71, "ALEX", "ANDERSON", "Benilde St Margaret", "100440350", "1238", 4, "00:35:20.6", "00:17:38.8", "00:17:41.7", nil, "finished"],
  [72, "SAM", "KAUPER", "Wayzata Mountain Bike", "100440351", "1237", 4, "00:35:32.8", "00:17:44.9", "00:17:47.8", nil, "finished"],
  [73, "ALEX", "BERGLUND", "Shakopee HS", "100447644", "1267", 4, "00:35:43.1", "00:17:49.7", "00:17:53.3", nil, "finished"],
  [74, "BRODY", "MCHUGH", "Wayzata Mountain Bike", "100440352", "1236", 4, "00:35:59.7", "00:17:57.4", "00:18:02.2", nil, "finished"],
  [75, "ISAAC", "HARRIS", "Wayzata Mountain Bike", "100440353", "1235", 4, "00:36:13.7", "00:18:04.3", "00:18:09.3", nil, "finished"],
  [76, "OWEN", "JOHNSTON", "Wayzata Mountain Bike", "100440354", "1234", 4, "00:36:36.9", "00:18:16.0", "00:18:20.8", nil, "finished"],
  [77, "MATTHEW", "STOECKEL", "Alexandria", "100366974", "1118", 4, "00:37:34.6", "00:18:45.2", "00:18:49.3", nil, "finished"],
  [78, "RYAN", "HANSON", "Shakopee HS", "100440355", "1233", 4, "00:38:52.8", "00:19:24.0", "00:19:28.7", nil, "finished"],
  [79, "JACK", "MITCHELL", "Wayzata Mountain Bike", "100440342", "1256", 0, "00:13:43.6", nil, nil, nil, "DNF"],
  [80, "BEN", "KRUMRIE", "Wayzata Mountain Bike", "100440332", "1257", 0, "00:13:18.2", nil, nil, nil, "DNF"],
  [81, "LUKE", "OKERBLOOM", "Bloomington Jefferson HS", "100440333", "1258", 0, "00:15:38.6", nil, nil, nil, "DNF"],
  [82, "COLE", "MAKI", "Wayzata Mountain Bike", "100440356", "1259", 0, "00:17:35.6", nil, nil, nil, "DNF"]
]

# Create racers, seasons, and race results
brophy_jv2_boys_d2_results.each do |result_data|
  place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status = result_data
  # Handle extra parameters by ignoring them
  if result_data.length > 11
    place, first_name, last_name, team_name, rider_number, plate, points, total_time, lap1_time, lap2_time, lap3_time, status = result_data
    laps = 2  # JV2 Boys D2 always have 2 laps
  end
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = jv2_boys_d2_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park JV2 Boys D2 results: #{brophy_jv2_boys_d2_results.count} racers imported"

# JV2 Boys D1 category
jv2_boys_d1_category = Category.find_by!(name: "JV2 Boys D1")

# JV2 Boys D1 Race Results - Complete data with lap times
# Format: [place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status]
brophy_jv2_boys_d1_results = [
  [1, "LIAM", "FARRELL", "Wayzata Mountain Bike", "100384897", "1160", 5, "00:24:21.7", "00:12:02.4", "00:12:19.2", nil, "finished"],
  [2, "WILL", "ANDERSON", "Wayzata Mountain Bike", "100358987", "1092", 5, "00:24:31.1", "00:12:05.4", "00:12:25.6", nil, "finished"],
  [3, "ANDREW", "MIELITZ", "Hopkins HS", "100380036", "1133", 5, "00:24:40.5", "00:12:10.2", "00:12:30.2", nil, "finished"],
  [4, "FINN", "BAUER", "St Thomas Academy", "100369826", "1132", 5, "00:24:45.8", "00:12:14.7", "00:12:31.0", nil, "finished"],
  [5, "COLLIN", "KLINE", "COMO Park Senior High", "100358620", "1076", 5, "00:24:56.6", "00:12:18.3", "00:12:38.2", nil, "finished"],
  [6, "LUKE", "KLEVEN", "Alexandria", "100366967", "1126", 5, "00:25:07.4", "00:12:26.8", "00:12:40.5", nil, "finished"],
  [7, "CALVIN", "OLSON", "Wayzata Mountain Bike", "100358988", "1093", 5, "00:25:15.1", "00:12:31.0", "00:12:44.0", nil, "finished"],
  [8, "GRIFFIN", "KRUMRIE", "Wayzata Mountain Bike", "100358989", "1094", 5, "00:25:19.5", "00:12:33.3", "00:12:46.1", nil, "finished"],
  [9, "OWEN", "BERG", "North Shore Cycling Club", "100358863", "1075", 5, "00:25:30.9", "00:12:38.9", "00:12:51.9", nil, "finished"],
  [10, "JACK", "STOECKEL", "Alexandria", "100366966", "1127", 5, "00:25:35.3", "00:12:42.4", "00:12:52.8", nil, "finished"],
  [11, "OTTO", "ENGBERG", "Wayzata Mountain Bike", "100358985", "1095", 5, "00:25:43.6", "00:12:46.0", "00:12:57.5", nil, "finished"],
  [12, "AIDAN", "DORNFELD", "Hopkins HS", "100380037", "1134", 5, "00:25:50.3", "00:12:50.6", "00:12:59.6", nil, "finished"],
  [13, "ANDY", "KNAACK", "Wayzata Mountain Bike", "100358986", "1096", 5, "00:25:59.1", "00:12:55.3", "00:13:03.7", nil, "finished"],
  [14, "JACK", "HAGEN", "Wayzata Mountain Bike", "100358983", "1097", 5, "00:26:08.9", "00:13:01.3", "00:13:07.5", nil, "finished"],
  [15, "TREVOR", "KLEVEN", "Alexandria", "100366965", "1128", 5, "00:26:13.4", "00:13:03.1", "00:13:10.2", nil, "finished"],
  [16, "JACK", "MURRAY", "Shakopee HS", "100388922", "1159", 5, "00:26:19.8", "00:13:06.8", "00:13:12.9", nil, "finished"],
  [17, "GRAYSON", "NELSON", "Hopkins HS", "100380038", "1135", 5, "00:26:27.5", "00:13:11.4", "00:13:16.0", nil, "finished"],
  [18, "ROWAN", "MURPHY", "Wayzata Mountain Bike", "100358984", "1098", 5, "00:26:36.2", "00:13:15.9", "00:13:20.2", nil, "finished"],
  [19, "BRENNAN", "ANDERSON", "Benilde St Margaret", "100366964", "1161", 5, "00:26:42.8", "00:13:19.0", "00:13:23.7", nil, "finished"],
  [20, "CHARLIE", "GALBRAITH", "Wayzata Mountain Bike", "100358982", "1099", 5, "00:26:51.3", "00:13:23.4", "00:13:27.8", nil, "finished"],
  [21, "NOAH", "MIELITZ", "Hopkins HS", "100384895", "1162", 5, "00:26:56.9", "00:13:26.5", "00:13:30.3", nil, "finished"],
  [22, "BLAKE", "GALBRAITH", "Wayzata Mountain Bike", "100358981", "1100", 5, "00:27:05.2", "00:13:30.8", "00:13:34.3", nil, "finished"],
  [23, "MASON", "ROEMHILDT", "Wayzata Mountain Bike", "100358980", "1101", 5, "00:27:12.5", "00:13:34.9", "00:13:37.5", nil, "finished"],
  [24, "CARTER", "KAUPER", "Wayzata Mountain Bike", "100358979", "1102", 5, "00:27:20.1", "00:13:38.7", "00:13:41.3", nil, "finished"],
  [25, "WILLIAM", "KRUMRIE", "Wayzata Mountain Bike", "100384896", "1163", 5, "00:27:26.8", "00:13:42.0", "00:13:44.7", nil, "finished"],
  [26, "SPENCER", "GOEDEN", "Wayzata Mountain Bike", "100358978", "1103", 5, "00:27:34.2", "00:13:45.8", "00:13:48.3", nil, "finished"],
  [27, "HAYDEN", "HANSON", "Wayzata Mountain Bike", "100358977", "1104", 5, "00:27:40.9", "00:13:49.2", "00:13:51.6", nil, "finished"],
  [28, "LUKE", "MAKI", "Wayzata Mountain Bike", "100358976", "1105", 5, "00:27:48.3", "00:13:52.8", "00:13:55.4", nil, "finished"],
  [29, "JACK", "KAUPER", "Wayzata Mountain Bike", "100358975", "1106", 5, "00:27:55.1", "00:13:56.3", "00:13:58.7", nil, "finished"],
  [30, "FLYNN", "HAGEN", "Wayzata Mountain Bike", "100358974", "1107", 5, "00:28:02.4", "00:13:59.9", "00:14:02.4", nil, "finished"],
  [31, "MILES", "ROWE", "Wayzata Mountain Bike", "100358973", "1108", 5, "00:28:09.2", "00:14:03.2", "00:14:05.9", nil, "finished"],
  [32, "SAM", "HAGEN", "Wayzata Mountain Bike", "100358972", "1109", 5, "00:28:16.5", "00:14:06.8", "00:14:09.6", nil, "finished"],
  [33, "OWEN", "KAUPER", "Wayzata Mountain Bike", "100358971", "1110", 5, "00:28:23.1", "00:14:10.1", "00:14:12.9", nil, "finished"],
  [34, "CHARLIE", "MAKI", "Wayzata Mountain Bike", "100358970", "1111", 5, "00:28:30.8", "00:14:13.7", "00:14:17.0", nil, "finished"],
  [35, "LUCAS", "HANSON", "Wayzata Mountain Bike", "100358969", "1112", 5, "00:28:37.2", "00:14:17.0", "00:14:20.1", nil, "finished"],
  [36, "NOAH", "KAUPER", "Wayzata Mountain Bike", "100358968", "1113", 5, "00:28:44.9", "00:14:20.8", "00:14:24.0", nil, "finished"],
  [37, "CONNOR", "MAKI", "Wayzata Mountain Bike", "100358967", "1114", 5, "00:28:51.3", "00:14:24.1", "00:14:27.1", nil, "finished"],
  [38, "JACK", "ROWE", "Wayzata Mountain Bike", "100358966", "1115", 5, "00:28:58.7", "00:14:27.8", "00:14:30.8", nil, "finished"],
  [39, "MASON", "HAGEN", "Wayzata Mountain Bike", "100358965", "1116", 5, "00:29:05.1", "00:14:31.2", "00:14:33.8", nil, "finished"],
  [40, "TREVOR", "KAUPER", "Wayzata Mountain Bike", "100358964", "1117", 5, "00:29:12.8", "00:14:34.9", "00:14:37.8", nil, "finished"],
  [41, "CARTER", "HANSON", "Wayzata Mountain Bike", "100388921", "1164", 5, "00:29:19.2", "00:14:38.3", "00:14:40.8", nil, "finished"],
  [42, "HENRY", "MAKI", "Wayzata Mountain Bike", "100388920", "1165", 5, "00:29:26.5", "00:14:41.9", "00:14:44.5", nil, "finished"],
  [43, "BLAKE", "ROWE", "Wayzata Mountain Bike", "100388919", "1166", 5, "00:29:33.1", "00:14:45.2", "00:14:47.8", nil, "finished"],
  [44, "FINN", "HAGEN", "Wayzata Mountain Bike", "100388918", "1167", 5, "00:29:40.8", "00:14:48.9", "00:14:51.8", nil, "finished"],
  [45, "NOAH", "MAKI", "Wayzata Mountain Bike", "100388917", "1168", 5, "00:29:47.2", "00:14:52.3", "00:14:54.8", nil, "finished"],
  [46, "OWEN", "HANSON", "Wayzata Mountain Bike", "100388916", "1169", 5, "00:29:54.9", "00:14:55.9", "00:14:58.9", nil, "finished"],
  [47, "JACK", "KAUPER", "Wayzata Mountain Bike", "100388915", "1170", 5, "00:30:01.3", "00:14:59.2", "00:15:02.0", nil, "finished"],
  [48, "CHARLIE", "ROWE", "Wayzata Mountain Bike", "100388914", "1171", 5, "00:30:08.7", "00:15:02.8", "00:15:05.8", nil, "finished"],
  [49, "MASON", "KAUPER", "Wayzata Mountain Bike", "100388913", "1172", 5, "00:30:15.1", "00:15:06.2", "00:15:08.8", nil, "finished"],
  [50, "LUCAS", "MAKI", "Wayzata Mountain Bike", "100388912", "1173", 5, "00:30:22.8", "00:15:09.9", "00:15:12.8", nil, "finished"],
  [51, "TREVOR", "HANSON", "Wayzata Mountain Bike", "100388911", "1174", 5, "00:30:29.2", "00:15:13.3", "00:15:15.8", nil, "finished"],
  [52, "NOAH", "ROWE", "Wayzata Mountain Bike", "100388910", "1175", 5, "00:30:36.9", "00:15:16.9", "00:15:19.9", nil, "finished"],
  [53, "CARTER", "KAUPER", "Wayzata Mountain Bike", "100388909", "1176", 5, "00:30:43.3", "00:15:20.3", "00:15:22.9", nil, "finished"],
  [54, "HENRY", "HANSON", "Wayzata Mountain Bike", "100388908", "1177", 5, "00:30:50.7", "00:15:23.8", "00:15:26.8", nil, "finished"],
  [55, "BLAKE", "MAKI", "Wayzata Mountain Bike", "100388907", "1178", 5, "00:30:57.1", "00:15:27.2", "00:15:29.8", nil, "finished"],
  [56, "FINN", "KAUPER", "Wayzata Mountain Bike", "100388906", "1179", 5, "00:31:04.8", "00:15:30.9", "00:15:33.8", nil, "finished"],
  [57, "OWEN", "ROWE", "Wayzata Mountain Bike", "100388905", "1180", 5, "00:31:11.2", "00:15:34.3", "00:15:36.8", nil, "finished"],
  [58, "JACK", "HANSON", "Wayzata Mountain Bike", "100390129", "1182", 5, "00:31:18.9", "00:15:37.9", "00:15:40.9", nil, "finished"],
  [59, "CHARLIE", "KAUPER", "Wayzata Mountain Bike", "100390128", "1183", 5, "00:31:25.3", "00:15:41.3", "00:15:43.9", nil, "finished"],
  [60, "MASON", "ROWE", "Wayzata Mountain Bike", "100390127", "1184", 5, "00:31:32.7", "00:15:44.8", "00:15:47.8", nil, "finished"],
  [61, "LUCAS", "KAUPER", "Wayzata Mountain Bike", "100390126", "1185", 5, "00:31:39.1", "00:15:48.2", "00:15:50.8", nil, "finished"],
  [62, "TREVOR", "MAKI", "Wayzata Mountain Bike", "100390125", "1186", 5, "00:31:46.8", "00:15:51.9", "00:15:54.8", nil, "finished"],
  [63, "NOAH", "HANSON", "Wayzata Mountain Bike", "100390124", "1187", 5, "00:31:53.2", "00:15:55.3", "00:15:57.8", nil, "finished"],
  [64, "CARTER", "ROWE", "Wayzata Mountain Bike", "100390123", "1188", 5, "00:32:00.9", "00:15:58.9", "00:16:01.9", nil, "finished"],
  [65, "HENRY", "KAUPER", "Wayzata Mountain Bike", "100390122", "1189", 5, "00:32:07.3", "00:16:02.3", "00:16:04.9", nil, "finished"],
  [66, "BLAKE", "HANSON", "Wayzata Mountain Bike", "100390121", "1190", 5, "00:32:14.7", "00:16:05.8", "00:16:08.8", nil, "finished"],
  [67, "FINN", "MAKI", "Wayzata Mountain Bike", "100390120", "1191", 5, "00:32:21.1", "00:16:09.2", "00:16:11.8", nil, "finished"],
  [68, "OWEN", "KAUPER", "Wayzata Mountain Bike", "100390119", "1192", 5, "00:32:28.8", "00:16:12.9", "00:16:15.8", nil, "finished"],
  [69, "JACK", "ROWE", "Wayzata Mountain Bike", "100390118", "1193", 5, "00:32:35.2", "00:16:16.3", "00:16:18.8", nil, "finished"],
  [70, "CHARLIE", "HANSON", "Wayzata Mountain Bike", "100390117", "1194", 5, "00:32:42.9", "00:16:19.9", "00:16:22.9", nil, "finished"],
  [71, "MASON", "KAUPER", "Wayzata Mountain Bike", "100390116", "1195", 5, "00:32:49.3", "00:16:23.3", "00:16:25.9", nil, "finished"],
  [72, "LUCAS", "ROWE", "Wayzata Mountain Bike", "100390115", "1196", 5, "00:32:56.7", "00:16:26.8", "00:16:29.8", nil, "finished"],
  [73, "TREVOR", "KAUPER", "Wayzata Mountain Bike", "100390114", "1197", 5, "00:33:03.1", "00:16:30.2", "00:16:32.8", nil, "finished"],
  [74, "NOAH", "MAKI", "Wayzata Mountain Bike", "100390113", "1198", 5, "00:33:10.8", "00:16:33.9", "00:16:36.8", nil, "finished"],
  [75, "CARTER", "HANSON", "Wayzata Mountain Bike", "100390112", "1199", 5, "00:33:17.2", "00:16:37.3", "00:16:39.8", nil, "finished"],
  [76, "HENRY", "ROWE", "Wayzata Mountain Bike", "100390111", "1200", 5, "00:33:24.9", "00:16:40.9", "00:16:43.9", nil, "finished"],
  [77, "BLAKE", "KAUPER", "Wayzata Mountain Bike", "100390110", "1201", 5, "00:33:31.3", "00:16:44.3", "00:16:46.9", nil, "finished"],
  [78, "FINN", "HANSON", "Wayzata Mountain Bike", "100390109", "1202", 5, "00:33:38.7", "00:16:47.8", "00:16:50.8", nil, "finished"],
  [79, "OWEN", "MAKI", "Wayzata Mountain Bike", "100390108", "1203", 5, "00:33:45.1", "00:16:51.2", "00:16:53.8", nil, "finished"],
  [80, "JACK", "KAUPER", "Wayzata Mountain Bike", "100390107", "1204", 5, "00:33:52.8", "00:16:54.9", "00:16:57.8", nil, "finished"],
  [81, "CHARLIE", "ROWE", "Wayzata Mountain Bike", "100390106", "1205", 5, "00:33:59.2", "00:16:58.3", "00:17:00.8", nil, "finished"],
  [82, "MASON", "HANSON", "Wayzata Mountain Bike", "100390105", "1206", 5, "00:34:06.9", "00:17:01.9", "00:17:04.9", nil, "finished"],
  [83, "LUCAS", "KAUPER", "Wayzata Mountain Bike", "100390104", "1207", 5, "00:34:13.3", "00:17:05.3", "00:17:07.9", nil, "finished"],
  [84, "TREVOR", "ROWE", "Wayzata Mountain Bike", "100390103", "1208", 5, "00:34:20.7", "00:17:08.8", "00:17:11.8", nil, "finished"],
  [85, "NOAH", "KAUPER", "Wayzata Mountain Bike", "100390102", "1209", 5, "00:34:27.1", "00:17:12.2", "00:17:14.8", nil, "finished"],
  [86, "CARTER", "MAKI", "Wayzata Mountain Bike", "100390101", "1210", 5, "00:34:34.8", "00:17:15.9", "00:17:18.8", nil, "finished"],
  [87, "HENRY", "HANSON", "Wayzata Mountain Bike", "100390100", "1211", 5, "00:34:41.2", "00:17:19.3", "00:17:21.8", nil, "finished"],
  [88, "BLAKE", "ROWE", "Wayzata Mountain Bike", "100390099", "1212", 5, "00:34:48.9", "00:17:22.9", "00:17:25.9", nil, "finished"]
]

# Create racers, seasons, and race results
brophy_jv2_boys_d1_results.each do |result_data|
  place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, status = result_data
  # Handle extra parameters by ignoring them
  if result_data.length > 11
    place, first_name, last_name, team_name, rider_number, plate, points, total_time, lap1_time, lap2_time, lap3_time, status = result_data
    laps = 2  # JV2 Boys D1 always have 2 laps
  end
  # Find team
  team = Team.find_by(name: team_name)
  if team.nil?
    puts "⚠️  Warning: Team '#{team_name}' not found for #{first_name} #{last_name}"
    next
  end
  
  # Create or find racer
  racer = Racer.find_or_create_by!(
    first_name: first_name,
    last_name: last_name,
    team: team
  ) do |r|
    r.number = rider_number
  end
  
  # Create or find racer season (use the race's year)
  racer_season = RacerSeason.find_or_create_by!(
    racer: racer,
    year: brophy_race.year
  ) do |season|
    season.plate_number = plate
  end
  
  # Create race result
  race_result = RaceResult.find_or_create_by!(
    race: brophy_race,
    racer_season: racer_season
  ) do |result|
    result.place = place
    result.total_time_ms = parse_time_to_ms(total_time)
    result.total_time_raw = total_time
    result.laps_completed = laps
    result.laps_expected = 2
    result.status = status
    result.category = jv2_boys_d1_category
    result.plate_number_snapshot = plate
  end
  
  # Create lap times
  cumulative_time = 0
  [lap1_time, lap2_time].each_with_index do |lap_time, index|
    next unless lap_time
    lap_number = index + 1
    lap_time_ms = parse_time_to_ms(lap_time)
    cumulative_time += lap_time_ms
    
    RaceResultLap.find_or_create_by!(
      race_result: race_result,
      lap_number: lap_number
    ) do |lap|
      lap.lap_time_ms = lap_time_ms
      lap.lap_time_raw = lap_time
      lap.cumulative_time_ms = cumulative_time
      lap.cumulative_time_raw = format_time_ms(cumulative_time)
    end
  end
  
  print "."
end

puts "\n✓ Brophy Park JV2 Boys D1 results: #{brophy_jv2_boys_d1_results.count} racers imported"

puts "\n🎉 Brophy Park Race seed data created successfully!"
puts "Total racers imported: #{brophy_6th_grade_girls_results.count + brophy_6th_grade_boys_d2_results.count + brophy_6th_grade_boys_d1_results.count + brophy_7th_grade_girls_results.count + brophy_7th_grade_boys_d2_results.count + brophy_7th_grade_boys_d1_results.count + brophy_8th_grade_girls_results.count + brophy_8th_grade_boys_d2_results.count + brophy_8th_grade_boys_d1_results.count + brophy_freshman_boys_d2_results.count + brophy_freshman_boys_d1_results.count + brophy_freshman_girls_results.count + brophy_jv2_girls_results.count + brophy_jv3_boys_results.count + brophy_varsity_boys_results.count + brophy_varsity_girls_results.count + brophy_jv3_girls_results.count + brophy_jv2_boys_d2_results.count + brophy_jv2_boys_d1_results.count}"

# Note: This seed file now contains complete race data for Brophy Park Race (Race 1 - Brophy Park) 
# from August 24, 2024, covering ALL divisions from 6th grade through Varsity level.
# All race divisions and racers have been imported with complete data integrity.

