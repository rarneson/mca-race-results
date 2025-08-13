require 'pdf-reader'

# Extract text from the PDF
pdf_path = '/Users/ryanarneson/Code/mca-race-results/tmp/race_pdfs/2024/MCA_7_Redhead_Official_Results_v3.pdf'
reader = PDF::Reader.new(pdf_path)

# Extract all text from the PDF
full_text = ""
reader.pages.each do |page|
  full_text += page.text + "\n"
end

puts "=== PDF TEXT EXTRACTION DEBUG ==="
puts "Total characters extracted: #{full_text.length}"
puts "Number of pages: #{reader.page_count}"
puts "\n"

# Search patterns you want to find
search_patterns = [
  "Race7 Readhead - Official Results",
  "10/12/2024 - 10/13/2024", 
  "Race Timing & Results by Precision Race LLC"
]

puts "=== PATTERN SEARCH RESULTS ==="

search_patterns.each_with_index do |pattern, index|
  puts "\n#{index + 1}. Searching for: '#{pattern}'"
  
  if full_text.include?(pattern)
    puts "   ✓ FOUND: Exact match found!"
    
    # Find the position and show context
    position = full_text.index(pattern)
    start_context = [position - 50, 0].max
    end_context = [position + pattern.length + 50, full_text.length].min
    
    puts "   Context: '#{full_text[start_context...end_context]}'"
  else
    puts "   ✗ NOT FOUND: Exact match not found"
    
    # Try to find similar text
    puts "   Searching for similar patterns..."
    
    case pattern
    when "Race7 Readhead - Official Results"
      # Look for variations
      variations = [
        "Race7 Readhead",
        "Readhead - Official Results", 
        "Race7",
        "Official Results",
        "Readhead"
      ]
      
      variations.each do |variation|
        if full_text.include?(variation)
          position = full_text.index(variation)
          start_context = [position - 30, 0].max
          end_context = [position + variation.length + 30, full_text.length].min
          puts "     Found similar: '#{variation}' in context: '#{full_text[start_context...end_context]}'"
        end
      end
      
    when "10/12/2024 - 10/13/2024"
      # Look for date patterns
      date_patterns = [
        "10/12/2024",
        "10/13/2024",
        "2024",
        /\d{1,2}\/\d{1,2}\/\d{4}/
      ]
      
      date_patterns.each do |date_pattern|
        if date_pattern.is_a?(Regexp)
          matches = full_text.scan(date_pattern)
          if matches.any?
            puts "     Found date pattern matches: #{matches.uniq.join(', ')}"
          end
        elsif full_text.include?(date_pattern)
          position = full_text.index(date_pattern)
          start_context = [position - 30, 0].max
          end_context = [position + date_pattern.length + 30, full_text.length].min
          puts "     Found date part: '#{date_pattern}' in context: '#{full_text[start_context...end_context]}'"
        end
      end
      
    when "Race Timing & Results by Precision Race LLC"
      # Look for timing/results patterns
      timing_patterns = [
        "Race Timing",
        "Precision Race",
        "Race LLC",
        "Timing & Results",
        "Results by Precision"
      ]
      
      timing_patterns.each do |timing_pattern|
        if full_text.include?(timing_pattern)
          position = full_text.index(timing_pattern)
          start_context = [position - 30, 0].max
          end_context = [position + timing_pattern.length + 30, full_text.length].min
          puts "     Found timing part: '#{timing_pattern}' in context: '#{full_text[start_context...end_context]}'"
        end
      end
    end
  end
end

puts "\n=== FIRST 500 CHARACTERS OF EXTRACTED TEXT ==="
puts full_text[0, 500]

puts "\n=== LAST 500 CHARACTERS OF EXTRACTED TEXT ==="
puts full_text[-500, 500]

puts "\n=== CHECKING FIRST PAGE SPECIFICALLY ==="
if reader.pages.any?
  first_page_text = reader.pages[0].text
  puts "First page text (first 200 chars): #{first_page_text[0, 200]}"
  
  search_patterns.each do |pattern|
    if first_page_text.include?(pattern)
      puts "✓ Found '#{pattern}' on first page"
    else
      puts "✗ '#{pattern}' not found on first page"
    end
  end
end