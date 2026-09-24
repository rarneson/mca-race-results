# frozen_string_literal: true

# Structural checks on a seed file, then a real import into the test database
# inside a transaction that is always rolled back.
#
#   RAILS_ENV=test bin/rails runner \
#     .claude/skills/import-race-data/scripts/verify_seed.rb db/seeds/2026_brophy_park.rb
#
# Exits non-zero if anything is wrong. Leaves no data behind.

path = ARGV[0] or abort "usage: rails runner verify_seed.rb db/seeds/<file>.rb"
abort "not found: #{path}" unless File.exist?(path)

seeds_rb = File.read(Rails.root.join("db/seeds.rb"))
team_names = seeds_rb[/TEAM_NAMES = \[(.*?)\]\.freeze/m, 1].scan(/"([^"]+)"/).flatten
category_data = seeds_rb[/CATEGORY_DATA = \[(.*?)\]\.freeze/m, 1]
                  .scan(/name: "([^"]+)", laps: (\d+), sort_order: (\d+)/)

problems = []
src = File.read(path)

# ---------------------------------------------------------------- static checks

divisions = src.scan(/^# ([^\n]+?) Results\nresults_(\w+) = \[\n(.*?)\n?^\]$/m)
problems << "expected 19 division arrays, found #{divisions.size}" unless divisions.size == 19

rows_by_division = {}
divisions.each do |name, _var, body|
  rows = body.to_s.lines.reject { |l| l.strip.empty? }.map { |l| eval(l.strip.sub(/,\z/, "")) }
  rows_by_division[name] = rows
  next if rows.empty?

  places = rows.map(&:first)
  problems << "#{name}: places are #{places.first(5).inspect}..., expected 1..#{rows.size}" unless places == (1..rows.size).to_a

  rows.each do |r|
    tag = "#{name} p#{r[0]}"
    problems << "#{tag}: expected 15 fields, got #{r.size}" unless r.size == 15
    problems << "#{tag}: unknown team #{r[3].inspect}" unless team_names.include?(r[3])
    problems << "#{tag}: rider id #{r[4].inspect} is not 9 digits" unless r[4].to_s.match?(/\A\d{9}\z/)
    problems << "#{tag}: status #{r[12].inspect}" unless %w[finished DNF DNS DSQ DQ].include?(r[12])
    laps = r[6]
    times = r[8..11].compact.reject(&:empty?)
    problems << "#{tag}: #{laps} laps but #{times.size} lap times" if laps.positive? && times.size != laps
    problems << "#{tag}: laps=0 but has a total time" if laps.zero? && !r[7].to_s.empty?
  end
end

all = rows_by_division.flat_map { |d, rs| rs.map { |r| [ d ] + r } }
all.group_by { |r| r[5] }.select { |_, v| v.size > 1 }.each do |id, v|
  problems << "rider id #{id} appears #{v.size}x: #{v.map { |r| "#{r[0]} p#{r[1]}" }.join(', ')}"
end
all.group_by { |r| [ r[0], r[6] ] }.select { |_, v| v.size > 1 }.each do |(div, plate), v|
  problems << "plate #{plate} used #{v.size}x within #{div}"
end

if problems.any?
  warn "FAILED - #{problems.size} structural problem(s):"
  problems.first(40).each { |p| warn "  - #{p}" }
  warn "  ... #{problems.size - 40} more" if problems.size > 40
  exit 1
end

expected_total = all.size
puts "Structural checks passed (#{expected_total} rows across #{divisions.size} divisions)."

# ---------------------------------------------------------------- live import

race_name = src[/name: "([^"]+)"/, 1]
imported = nil
lap_count = nil
statuses = nil
missing_teams = nil

ActiveRecord::Base.transaction do
  category_data.each { |n, _l, s| Category.find_or_create_by!(name: n) { |c| c.sort_order = s.to_i } }
  team_names.each { |t| Team.find_or_create_by!(name: t) }

  before = RaceResult.count
  original_stdout = $stdout
  $stdout = StringIO.new
  begin
    load File.expand_path(path)
    output = $stdout.string
  ensure
    $stdout = original_stdout
  end

  missing_teams = output.scan(/^.*(?:Team not found|orphan|WARNING).*$/i)

  race = Race.find_by(name: race_name)
  raise "race #{race_name.inspect} was not created" if race.nil?

  imported = RaceResult.where(race: race).count
  lap_count = RaceResultLap.joins(:race_result).where(race_results: { race_id: race.id }).count
  statuses = RaceResult.where(race: race).group(:status).count
  created = RaceResult.count - before

  problems << "imported #{imported} results but file has #{expected_total} rows" unless imported == expected_total
  problems << "created #{created} rows, expected #{expected_total}" unless created == expected_total

  raise ActiveRecord::Rollback
end

# Every lap the file claims should have become a RaceResultLap row.
expected_laps = all.sum { |r| r[7].to_i }

puts "Imported into test DB (rolled back): #{imported} results, #{lap_count} lap records."
puts "Statuses: #{statuses.inspect}"
problems << "expected #{expected_laps} lap records, got #{lap_count}" unless lap_count == expected_laps
problems.concat(missing_teams.to_a.map { |m| "import warning: #{m.strip}" })

if problems.any?
  warn "\nFAILED:"
  problems.each { |p| warn "  - #{p}" }
  exit 1
end

puts "\n✅ #{race_name} verified: structure, import, and lap counts all consistent."
