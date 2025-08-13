#!/usr/bin/env ruby

require 'bundler/setup'
require 'pdf/reader'

# Extract all text from the PDF for comprehensive analysis
def extract_full_text(pdf_path)
  reader = PDF::Reader.new(pdf_path)
  full_text = ""
  
  reader.pages.each do |page|
    full_text += page.text + "\n"
  end
  
  full_text
end

# Analyze different sections and formats
def comprehensive_analysis(text)
  lines = text.split("\n").map(&:strip).reject(&:empty?)
  
  puts "=== FULL FORMAT ANALYSIS ==="
  puts "Total lines: #{lines.length}"
  
  # Show race header
  puts "\n--- RACE HEADER ---"
  lines.first(10).each_with_index { |line, i| puts "#{i+1}: #{line}" }
  
  # Find all divisions
  puts "\n--- ALL DIVISIONS ---"
  divisions = lines.select { |line| line.start_with?("Division:") }
  divisions.each { |div| puts div }
  
  # Sample different result line formats across divisions
  puts "\n--- RESULT LINE FORMAT SAMPLES ---"
  current_division = nil
  samples = {}
  in_results = false
  
  lines.each do |line|
    if line.start_with?("Division:")
      current_division = line.sub("Division:", "").strip
      in_results = false
      samples[current_division] = [] if samples[current_division].nil?
      next
    end
    
    # Skip header line
    if current_division && line.include?("Place") && line.include?("Name") 
      in_results = true
      next
    end
    
    # Collect sample result lines
    if in_results && current_division && line.match?(/^\s*\d+\s+/) && samples[current_division].length < 2
      samples[current_division] << line
    end
  end
  
  samples.each do |division, sample_lines|
    puts "\n#{division}:"
    sample_lines.each { |line| puts "  #{line}" }
  end
  
  # Check for different time formats
  puts "\n--- TIME FORMATS FOUND ---"
  all_times = text.scan(/\d{1,2}:\d{2}:\d{2}\.\d+|\d{1,2}:\d{2}\.\d+/)
  puts "Sample times:"
  all_times.uniq.first(10).each { |time| puts "  #{time}" }
  
  # Find special conditions and comments
  puts "\n--- SPECIAL CONDITIONS ---"
  special_patterns = [
    "DNF", "DNS", "DSQ", "Bike Swap", "Outside Assist", 
    "Pulled by Ref", "Min", "Penalty", "Adjust"
  ]
  
  special_lines = []
  lines.each do |line|
    special_patterns.each do |pattern|
      if line.include?(pattern) && !line.include?("Comment")
        special_lines << line
        break
      end
    end
  end
  
  puts "Found #{special_lines.length} lines with special conditions:"
  special_lines.first(10).each { |line| puts "  #{line}" }
  
  # Analyze different lap structures (some have multiple laps)
  puts "\n--- LAP STRUCTURE ANALYSIS ---"
  multi_lap_lines = lines.select { |line| line.include?("Lap 2") || line.include?("Lap 3") || line.include?("Lap 4") }
  if multi_lap_lines.any?
    puts "Found multi-lap races:"
    multi_lap_lines.first(3).each { |line| puts "  #{line}" }
  else
    puts "This appears to be primarily single-lap races"
  end
  
  # Show what the header lines look like across different divisions
  puts "\n--- HEADER LINE VARIATIONS ---"
  header_lines = []
  lines.each_with_index do |line, i|
    if line.include?("Place") && line.include?("Name") && line.include?("Team")
      header_lines << line
    end
  end
  
  header_lines.uniq.each { |header| puts "  #{header}" }
end

# Run the analysis
pdf_path = "/Users/ryanarneson/Code/mca-race-results/tmp/race_pdfs/MCA_5N_Whitetail_Official_Results_v2-1.pdf"

if File.exist?(pdf_path)
  puts "Extracting and analyzing full PDF: #{pdf_path}"
  text = extract_full_text(pdf_path)
  comprehensive_analysis(text)
  
  # Save extracted text for further reference
  File.write("whitetail_extracted_text.txt", text)
  puts "\nExtracted text saved to: whitetail_extracted_text.txt"
else
  puts "PDF file not found: #{pdf_path}"
end