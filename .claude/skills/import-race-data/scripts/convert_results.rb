#!/usr/bin/env ruby
# frozen_string_literal: true

# Convert a full raw race-results paste into a db/seeds/ seed file.
#
#   ruby .claude/skills/import-race-data/scripts/convert_results.rb \
#     --raw tmp/race_raw.txt \
#     --out db/seeds/2026_brophy_park.rb \
#     --name "Race 5 - Brophy Park" \
#     --date "September 19, 2026" \
#     --location "Brophy Park" \
#     --year 2026
#
# Every row is round-tripped back to its source line before anything is
# written; a single mismatch aborts the run. Judgement calls (team aliases,
# name casing, penalty vs comment, roster changes) are printed as a review
# report for a human to read -- they are never silently applied.

require "optparse"

ROOT = File.expand_path("../../../..", __dir__)

# Division order and variable names must match db/seeds/_template.rb exactly.
DIVISIONS = [
  [ "6th Grade Girls",   "results_6th_grade_girls",   1 ],
  [ "6th Grade Boys D2", "results_6th_grade_boys_d2", 1 ],
  [ "6th Grade Boys D1", "results_6th_grade_boys_d1", 1 ],
  [ "7th Grade Girls",   "results_7th_grade_girls",   1 ],
  [ "7th Grade Boys D2", "results_7th_grade_boys_d2", 1 ],
  [ "7th Grade Boys D1", "results_7th_grade_boys_d1", 1 ],
  [ "8th Grade Girls",   "results_8th_grade_girls",   1 ],
  [ "8th Grade Boys D2", "results_8th_grade_boys_d2", 1 ],
  [ "8th Grade Boys D1", "results_8th_grade_boys_d1", 1 ],
  [ "Freshman Boys D2",  "results_freshman_boys_d2",  2 ],
  [ "Freshman Boys D1",  "results_freshman_boys_d1",  2 ],
  [ "Freshman Girls",    "results_freshman_girls",    2 ],
  [ "JV2 Girls",         "results_jv2_girls",         2 ],
  [ "JV3 Boys",          "results_jv3_boys",          3 ],
  [ "Varsity Boys",      "results_varsity_boys",      4 ],
  [ "JV3 Girls",         "results_jv3_girls",         3 ],
  [ "Varsity Girls",     "results_varsity_girls",     4 ],
  [ "JV2 Boys D2",       "results_jv2_boys_d2",       2 ],
  [ "JV2 Boys D1",       "results_jv2_boys_d1",       2 ]
].freeze

# Timing-software spellings that differ from the authoritative TEAM_NAMES list
# in db/seeds.rb. Add new entries here as they show up, and mention them to the
# user -- a recurring alias usually means the upstream export changed.
TEAM_ALIASES = {
  "Lakes Area Composite" => "Lake Area Composite"
}.freeze

TIME_RE = /\A\d{1,2}:\d{2}:\d{2}\.\d\z/
ID_RE   = /\A\d{9}\z/

options = { year: nil }
OptionParser.new do |o|
  o.on("--raw PATH")      { |v| options[:raw] = v }
  o.on("--out PATH")      { |v| options[:out] = v }
  o.on("--name NAME")     { |v| options[:name] = v }
  o.on("--date DATE")     { |v| options[:date] = v }
  o.on("--location LOC")  { |v| options[:location] = v }
  o.on("--year YEAR")     { |v| options[:year] = v.to_i }
  o.on("--merge")         { options[:merge] = true }
end.parse!

%i[raw out name date location year].each do |k|
  abort "missing --#{k}" if options[k].nil?
end

# ---------------------------------------------------------------- reference data

seeds_rb = File.read(File.join(ROOT, "db/seeds.rb"))
TEAMS = seeds_rb[/TEAM_NAMES = \[(.*?)\]\.freeze/m, 1].scan(/"([^"]+)"/).flatten.freeze
abort "could not read TEAM_NAMES from db/seeds.rb" if TEAMS.empty?

# Most recent prior spelling for each rider id, so we can inherit an established
# name split ("Jerid Jr" / "Adickes") and repair shouted source casing.
# Files sort chronologically (2023_ < 2024_ < 2025_ < 2026_), so last write wins.
PRIOR = {}
Dir[File.join(ROOT, "db/seeds/*.rb")].sort.each do |f|
  next if File.basename(f) == "_template.rb"
  next if File.expand_path(f) == File.expand_path(options[:out])
  File.foreach(f) do |line|
    next unless line =~ /^\s*\[ \d+, "([^"]*)", "([^"]*)", "([^"]*)", "(\d{9})"/
    PRIOR[$4] = { first: $1, last: $2, team: $3, file: File.basename(f, ".rb") }
  end
end

# ---------------------------------------------------------------- helpers

def fmt_time(t)
  h, m, s = t.split(":")
  if h == "00"
    "#{m.sub(/\A0+(?=\d)/, '')}:#{s}"
  else
    "#{h.sub(/\A0+(?=\d)/, '')}:#{m}:#{s}"
  end
end

def unfmt_time(t)
  parts = t.split(":")
  parts.unshift("0") while parts.size < 3
  format("%02d:%02d:%s", parts[0].to_i, parts[1].to_i, parts[2].rjust(4, "0"))
end

# A token that is entirely upper- or lower-case is a timing-export artifact
# ("GILBERT NELSON", "Morgan shield"), not a real preference.
def shouted?(tokens)
  tokens.any? do |t|
    letters = t.gsub(/[^A-Za-z]/, "")
    next false if letters.length < 2
    letters == letters.upcase || letters == letters.downcase
  end
end

# Longest matching team suffix wins: "St Louis Park HS" must beat "Park HS".
def split_name_team(tokens)
  1.upto(tokens.length - 1) do |i|
    candidate = tokens[i..].join(" ")
    canonical = TEAM_ALIASES[candidate] || candidate
    next unless TEAMS.include?(canonical)
    return [ tokens[0...i], canonical, candidate ]
  end
  nil
end

report = Hash.new { |h, k| h[k] = [] }
divisions = {}
current = nil
fatal = []

# ---------------------------------------------------------------- parse

File.readlines(options[:raw], chomp: true).each_with_index do |line, idx|
  lineno = idx + 1
  next if line.strip.empty?

  if line =~ /\ADivision:\s*(.+)\z/
    current = $1.strip
    unless DIVISIONS.any? { |d, _, _| d == current }
      fatal << "line #{lineno}: unknown division #{current.inspect}"
    end
    divisions[current] ||= []
    next
  end

  # Column header emitted above each division block.
  next if line =~ /\APlace\s+Plate\s+Name/

  if current.nil?
    fatal << "line #{lineno}: data row before any 'Division:' header"
    next
  end

  tokens = line.split(" ")
  id_idx = tokens.index { |t| t =~ ID_RE }
  if id_idx.nil?
    fatal << "line #{lineno}: no 9-digit rider id: #{line}"
    next
  end

  place, plate = tokens[0], tokens[1]
  id = tokens[id_idx]

  split = split_name_team(tokens[2...id_idx])
  if split.nil?
    fatal << "line #{lineno}: no known team found in #{tokens[2...id_idx].join(' ').inspect}"
    next
  end
  name_tokens, team, team_src = split
  if name_tokens.size < 2
    fatal << "line #{lineno}: no first+last name left after team match: #{line}"
    next
  end

  report[:team_alias] << "#{team_src} -> #{team}  (#{current} p#{place})" if team_src != team

  first = name_tokens[0]
  last  = name_tokens[1..].join(" ")
  source_full = name_tokens.join(" ")
  prior = PRIOR[id]

  if prior && "#{prior[:first]} #{prior[:last]}".downcase == source_full.downcase
    # Same human, same name. Two independent repairs, never conflated:
    #   1. shouted source casing -> take the prior spelling wholesale
    #   2. different split point  -> re-split here, but keep SOURCE casing,
    #      so a genuine correction ("Degier" -> "DeGier") still lands.
    if shouted?(name_tokens)
      if [ prior[:first], prior[:last] ] != [ first, last ]
        report[:casing] << "#{source_full.inspect} -> #{prior[:first]} #{prior[:last]} (#{prior[:file]})"
        first, last = prior[:first], prior[:last]
      end
    else
      prior_first_tokens = prior[:first].split(" ").size
      if prior_first_tokens != first.split(" ").size && prior_first_tokens < name_tokens.size
        first = name_tokens[0, prior_first_tokens].join(" ")
        last  = name_tokens[prior_first_tokens..].join(" ")
        report[:split] << "#{source_full.inspect} split as #{first.inspect}/#{last.inspect} (per #{prior[:file]})"
      end
      if [ prior[:first], prior[:last] ] != [ first, last ]
        report[:casing_kept] << "#{id}: kept source #{first} #{last}, prior was #{prior[:first]} #{prior[:last]} (#{prior[:file]})"
      end
    end
  elsif prior
    report[:name_change] << "#{id}: #{prior[:first]} #{prior[:last]} (#{prior[:file]}) -> #{first} #{last}"
  else
    report[:new_racer] << "#{first} #{last} (#{team}) #{id} - #{current}"
  end

  report[:team_change] << "#{first} #{last} (#{id}): #{prior[:team]} -> #{team}" if prior && prior[:team] != team

  rest = tokens[(id_idx + 1)..]
  laps = rest[0].to_i
  tail = rest[1..]

  status = "finished"
  if tail.first == "DNF"
    status = "DNF"
    tail = tail[1..]
  end

  times = []
  times.unshift(tail.pop) while tail.any? && tail.last =~ TIME_RE
  penalty_text = tail.join(" ")
  penalty_text = nil if penalty_text.empty?

  penalty = nil
  comments = nil
  if penalty_text
    # Warnings carry no time/place adjustment, so they live in comments;
    # everything else is a scored penalty. Matches existing seed files.
    if penalty_text.match?(/\Awarning\b/i)
      comments = penalty_text
      report[:comment] << "#{current} p#{place} #{first} #{last}: comments=#{penalty_text.inspect}"
    else
      penalty = penalty_text
      report[:penalty] << "#{current} p#{place} #{first} #{last}: penalty=#{penalty_text.inspect}"
    end
  end

  expected = DIVISIONS.find { |d, _, _| d == current }&.last || 1

  if laps.zero?
    total = '""'
    slots = case expected
    when 1 then [ '""', "nil", "nil", "nil" ]
    when 2 then [ '""', '""', "nil", "nil" ]
    else        [ '""', '""', '""', "nil" ]
    end
    lap_strs = []
  else
    if times.size != laps + 1
      fatal << "line #{lineno}: found #{times.size} times, expected #{laps + 1} (total + #{laps} laps): #{line}"
      next
    end
    total = "\"#{fmt_time(times[0])}\""
    lap_strs = times[1..].map { |t| fmt_time(t) }
    slots = lap_strs.map { |t| "\"#{t}\"" } + [ "nil" ] * (4 - lap_strs.size)
  end

  qp = penalty ? "\"#{penalty}\"" : "nil"
  qc = comments ? "\"#{comments}\"" : "nil"

  divisions[current] << {
    ruby: "  [ #{place}, \"#{first}\", \"#{last}\", \"#{team}\", \"#{id}\", " \
          "\"#{plate}\", #{laps}, #{total}, #{slots.join(', ')}, \"#{status}\", #{qp}, #{qc} ]",
    # Round-trip uses the ORIGINAL source spellings, so normalisation above
    # cannot mask a parsing error.
    roundtrip: begin
      parts = [ place, plate, source_full, team_src, id, laps ]
      parts << "DNF" if status == "DNF"
      parts << penalty_text if penalty_text
      unless laps.zero?
        parts << unfmt_time(fmt_time(times[0]))
        lap_strs.each { |t| parts << unfmt_time(t) }
      end
      parts.join(" ")
    end,
    source: line,
    place: place.to_i
  }
end

# ---------------------------------------------------------------- verify

divisions.each do |div, rows|
  places = rows.map { |r| r[:place] }
  fatal << "#{div}: places are #{places.first(5).inspect}..., expected 1..#{rows.size}" unless places == (1..rows.size).to_a
  rows.each do |r|
    fatal << "round-trip mismatch\n    src: #{r[:source]}\n    gen: #{r[:roundtrip]}" if r[:source] != r[:roundtrip]
  end
end

# ---------------------------------------------------------------- merge guard
#
# A race is often delivered a few divisions at a time. Writing this file must
# never drop divisions that an earlier drop already populated.

existing = {}
if File.exist?(options[:out])
  prev = File.read(options[:out])
  prev_name = prev[/name: "([^"]+)"/, 1]
  if prev_name && prev_name != options[:name]
    fatal << "#{options[:out]} already holds #{prev_name.inspect} but --name is #{options[:name].inspect}"
  end
  prev.scan(/^# ([^\n]+?) Results\nresults_\w+ = \[\n(.*?)\n?^\]$/m).each do |div, body|
    rows = body.to_s.lines.map { |l| l.strip.sub(/,\z/, "") }.reject(&:empty?).map { |l| "  #{l}" }
    existing[div] = rows unless rows.empty?
  end
end

carried  = existing.keys - divisions.keys
replaced = existing.keys & divisions.keys

if carried.any? && !options[:merge]
  fatal << "#{options[:out]} already has data for #{carried.size} division(s) absent from this " \
           "paste (#{carried.join(', ')}).\n      Re-run with --merge to keep them, or delete the " \
           "file first to start the race over."
end

unless fatal.empty?
  warn "\nABORTED - #{fatal.size} problem(s); nothing written:\n"
  fatal.first(40).each { |f| warn "  - #{f}" }
  warn "  ... #{fatal.size - 40} more" if fatal.size > 40
  exit 1
end

# ---------------------------------------------------------------- write

out = +<<~RUBY
  require_relative '../../lib/race_data/race_seed_helpers'

  # Include the shared helpers
  include RaceData::RaceSeedHelpers

  # ===============================================================================
  # RACE DATA - #{options[:name]} (#{options[:date]})
  # ===============================================================================

  puts "Creating #{options[:name]} results..."

  # Create the race
  race = Race.find_or_create_by!(
    name: "#{options[:name]}",
    race_date: Date.parse("#{options[:date]}")
  ) do |race|
    race.location = "#{options[:location]}"
    race.year = #{options[:year]}
  end

  puts "✓ Race: \#{race.name} (\#{race.race_date})"

  # ===============================================================================
  # RACE RESULTS DATA
  # ===============================================================================

RUBY

DIVISIONS.each do |div, var, _|
  rows = if divisions.key?(div)
           divisions[div].map { |r| r[:ruby] }
  else
           existing[div] || []
  end
  out << "# #{div} Results\n#{var} = [\n"
  out << rows.join(",\n") << "\n" unless rows.empty?
  out << "]\n\n"
end

out << <<~RUBY
  # ===============================================================================
  # IMPORT ALL DIVISIONS
  # ===============================================================================

RUBY

DIVISIONS.each do |div, var, _|
  out << %(import_division_results(race, "#{div}", #{var}, get_expected_laps("#{div}"))\n)
end

out << <<~RUBY

  puts "\\n🎉 #{options[:name]} seed data created successfully!"
  puts "Total racers imported: \#{RaceResult.where(race: race).count}"
RUBY

File.write(options[:out], out)

# ---------------------------------------------------------------- report

total = divisions.values.sum(&:size)
puts "Wrote #{options[:out]}"
puts "Round-trip: all #{total} rows in this paste reproduce their source line exactly.\n\n"

grand = 0
DIVISIONS.each do |div, _, _|
  if divisions.key?(div)
    n = divisions[div].size
    grand += n
    note = replaced.include?(div) ? " (replaced #{existing[div].size} existing)" : ""
    puts format("  %-20s %d rows%s", div, n, note)
  elsif existing[div]
    grand += existing[div].size
    puts format("  %-20s %d rows (kept from earlier drop)", div, existing[div].size)
  else
    puts format("  %-20s %s", div, "(not in paste - empty array)")
  end
end
puts "  #{'TOTAL'.ljust(20)} #{grand} rows in file"

sections = [
  [ :team_alias,  "Team-name aliases applied (source spelling -> TEAM_NAMES)" ],
  [ :casing,      "Source casing repaired from prior races" ],
  [ :split,       "First/last split inherited from prior races" ],
  [ :casing_kept, "REVIEW - kept source casing, differs from prior races" ],
  [ :penalty,     "Penalties recorded" ],
  [ :comment,     "Comments recorded" ],
  [ :name_change, "REVIEW - name differs from last race for this rider id" ],
  [ :team_change, "REVIEW - team differs from last race for this rider id" ],
  [ :new_racer,   "Riders new to the dataset" ]
]

sections.each do |key, title|
  items = report[key]
  next if items.empty?
  puts "\n#{title}: #{items.size}"
  items.first(30).each { |i| puts "  - #{i}" }
  puts "  ... #{items.size - 30} more" if items.size > 30
end
