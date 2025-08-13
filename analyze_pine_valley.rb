#!/usr/bin/env ruby

require 'pdf/reader'

# Extract text from Pine Valley PDF
pdf_path = '/Users/ryanarneson/Code/mca-race-results/tmp/race_pdfs/MCA_6_PineValley_OFFICIAL_Results.pdf'
reader = PDF::Reader.new(pdf_path)

puts "=== PINE VALLEY MCA RACE 6 TEXT EXTRACTION ==="
puts

# Extract text from all pages
all_text = ""
reader.pages.each_with_index do |page, index|
  page_text = page.text
  all_text += page_text
  puts "--- PAGE #{index + 1} ---"
  puts page_text
  puts
end

puts "=== ANALYSIS ==="
puts

lines = all_text.split("\n").map(&:strip).reject(&:empty?)

puts "First 50 lines:"
lines.first(50).each_with_index do |line, i|
  puts "#{(i+1).to_s.rjust(3)}: #{line}"
end

puts
puts "=== FORMAT CHARACTERISTICS ==="

# Analyze header structure
puts "Header patterns found:"
header_lines = lines.first(10)
header_lines.each_with_index do |line, i|
  puts "#{(i+1).to_s.rjust(2)}: #{line}"
end

puts
puts "Division patterns found:"
division_lines = lines.select { |line| line.downcase.include?("division") }
division_lines.first(10).each do |line|
  puts "  #{line}"
end

puts
puts "Race name/title patterns:"
race_lines = lines.select { |line| line.match?(/race\s+\d+/i) || line.include?("Pine Valley") }
race_lines.each do |line|
  puts "  #{line}"
end

puts
puts "Date patterns:"
date_lines = lines.select { |line| line.match?(/\d{1,2}[-\/]\d{1,2}[-\/]\d{4}/) || line.match?(/\w+ \d{1,2}-\d{1,2},? \d{4}/) }
date_lines.each do |line|
  puts "  #{line}"
end

puts
puts "Time format patterns (first few examples):"
time_lines = lines.select { |line| line.match?(/\d+:\d+:\d+\.\d+/) || line.match?(/\d+:\d+\.\d+/) }
time_lines.first(5).each do |line|
  puts "  #{line}"
end

puts
puts "Result line structure (first few division results):"
in_results = false
current_division = nil
result_count = 0

lines.each do |line|
  if line.start_with?("Division:")
    current_division = line
    in_results = false
    puts "\n#{current_division}"
    next
  end
  
  if current_division && line.include?("Place") && line.include?("Name")
    in_results = true
    puts "  Header: #{line}"
    next
  end
  
  if in_results && line.match?(/^\s*\d+\s+/)
    puts "  Result: #{line}"
    result_count += 1
    break if result_count >= 3  # Just show first few examples
  end
end