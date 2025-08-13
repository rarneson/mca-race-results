#!/usr/bin/env ruby

require 'bundler/setup'
require 'pdf/reader'

# Extract text from the PDF
def extract_pdf_text(pdf_path)
  reader = PDF::Reader.new(pdf_path)
  text = ""
  reader.pages.each_with_index do |page, index|
    puts "\n=== PAGE #{index + 1} ==="
    page_text = page.text
    text += page_text + "\n"
    
    # Show first 50 lines of each page for analysis
    lines = page_text.split("\n")
    lines.first(50).each_with_index do |line, line_num|
      puts "#{sprintf('%3d', line_num + 1)}: #{line.strip}" unless line.strip.empty?
    end
    
    break if index >= 2  # Only show first 3 pages for analysis
  end
  text
end

# Analyze the format
def analyze_format(text)
  lines = text.split("\n").map(&:strip).reject(&:empty?)
  
  puts "\n=== FORMAT ANALYSIS ==="
  
  # Find race header info
  puts "\n--- RACE HEADER INFO ---"
  header_lines = lines.first(20)
  header_lines.each_with_index do |line, i|
    puts "#{sprintf('%2d', i)}: #{line}"
  end
  
  # Find divisions
  puts "\n--- DIVISIONS FOUND ---"
  division_lines = lines.select { |line| line.start_with?("Division:") }
  division_lines.each { |div| puts div }
  
  # Analyze result line format
  puts "\n--- SAMPLE RESULT LINES ---"
  in_results = false
  current_division = nil
  sample_count = 0
  
  lines.each do |line|
    if line.start_with?("Division:")
      current_division = line
      in_results = false
      puts "\n#{current_division}"
      next
    end
    
    # Skip header line
    if current_division && line.include?("Place") && line.include?("Name") && line.include?("Team")
      in_results = true
      puts "HEADER: #{line}"
      next
    end
    
    # Show sample result lines
    if in_results && line.match?(/^\s*\d+\s+/) && sample_count < 3
      puts "RESULT: #{line}"
      sample_count += 1
    end
    
    break if sample_count >= 3
  end
  
  # Analyze time formats
  puts "\n--- TIME FORMAT ANALYSIS ---"
  time_patterns = lines.join(" ").scan(/\d+:\d+:\d+\.\d+|\d+:\d+\.\d+/)
  puts "Found time patterns:"
  time_patterns.first(10).each { |time| puts "  #{time}" }
  
  # Check for special conditions
  puts "\n--- SPECIAL CONDITIONS ---"
  special_lines = lines.select do |line|
    line.include?("DNF") || 
    line.include?("DNS") || 
    line.include?("Bike Swap") ||
    line.include?("Outside Assist") ||
    line.include?("Pulled by Ref")
  end
  special_lines.first(5).each { |line| puts "  #{line}" }
end

# Run the analysis
pdf_path = "/Users/ryanarneson/Code/mca-race-results/tmp/race_pdfs/MCA_5N_Whitetail_Official_Results_v2-1.pdf"

if File.exist?(pdf_path)
  puts "Analyzing: #{pdf_path}"
  text = extract_pdf_text(pdf_path)
  analyze_format(text)
else
  puts "PDF file not found: #{pdf_path}"
end