# Find racers by last name (case-insensitive, database-agnostic)
  racers = Racer.where("UPPER(last_name) = ?", "ARNESON")
  racers.each { |r| puts "#{r.first_name} #{r.last_name} - Team: #{r.team.name}" }

  # Or for partial matching
  racers = Racer.where("UPPER(last_name) LIKE ?", "%ARNESON%")

  # Find Sam Arneson specifically
  sam = Racer.joins(:team).find_by(first_name: "SAMUEL", last_name: "ARNESON")
  puts "#{sam.first_name} #{sam.last_name} - #{sam.team.name}"

  # Get all race results for Sam with proper eager loading
  sam.racer_seasons.includes(race_results: [:race, :race_result_laps]).each do |season|
    puts "\n=== #{season.year} Season ==="
    season.race_results.includes(:race).each do |result|
      puts "Race: #{result.race.name} (#{result.race.race_date})"
      puts "Place: #{result.place}, Time: #{result.total_time_raw}, Laps: #{result.laps_completed}"

      # Show lap times
      result.race_result_laps.order(:lap_number).each do |lap|
        puts "  Lap #{lap.lap_number}: #{lap.lap_time_raw} (cumulative: #{lap.cumulative_time_raw})"
      end
    end
  end

  # Get Lake Rebecca race and show top finishers
  rebecca_race = Race.find_by(name: "Race 2 - Lake Rebecca")
  puts "#{rebecca_race.name} - #{rebecca_race.race_date}"
  puts "Total results: #{rebecca_race.race_results.count}"

  # Top 10 finishers with proper joins and includes
  top_results = rebecca_race.race_results
    .joins(racer_season: {racer: :team})
    .includes(racer_season: {racer: :team})
    .where.not(place: nil)
    .order(:place)
    .limit(10)

  top_results.each do |result|
    racer = result.racer_season.racer
    puts "#{result.place}. #{racer.first_name} #{racer.last_name} (#{racer.team.name}) - #{result.total_time_raw}"
  end

  # Check that text cleanup worked
  park_teams = Team.where("name LIKE ?", "%Park HS%")
  puts "Teams with 'Park HS': #{park_teams.pluck(:name).uniq}"

  # Check cleaned names
  zander_racers = Racer.where(first_name: "ZANDER")
  puts "Racers named ZANDER: #{zander_racers.pluck(:first_name, :last_name)}"

  # More flexible search
  efram_racers = Racer.where("first_name LIKE ?", "EFRAM%")
  puts "Racers with EFRAM: #{efram_racers.pluck(:first_name, :last_name)}"

  # Summary stats using ActiveRecord aggregations
  race = Race.find_by(name: "Race 2 - Lake Rebecca")
  puts "=== #{race.name} Summary ==="
  puts "Date: #{race.race_date}"
  puts "Total Results: #{race.race_results.count}"
  puts "Total Lap Times: #{race.race_results.joins(:race_result_laps).count}"
  puts "Unique Teams: #{race.race_results.joins(racer_season: {racer: :team}).distinct.count('teams.id')}"
  puts "Categories: #{race.race_results.distinct.pluck(:category_snapshot).compact.sort}"
  puts "DNF Count: #{race.race_results.where(status: 'DNF').count}"