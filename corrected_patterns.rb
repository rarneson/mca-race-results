# Corrected detection patterns for MCA Race 7 Redhead

# Instead of exact matches, use these patterns:

# Pattern 1: Race7 Readhead - Official Results
# Change from: "Race7 Readhead - Official Results"
# Change to:   "Race7Readhead-OfficialResults"
# Or use regex: /Race7\s*Readhead\s*-?\s*Official\s*Results/i

# Pattern 2: Date range
# Change from: "10/12/2024 - 10/13/2024"  
# Change to:   "10/12/2024-10/13/2024"
# Or use regex: /10\/12\/2024\s*-\s*10\/13\/2024/

# Pattern 3: Race timing attribution
# Change from: "Race Timing & Results by Precision Race LLC"
# Change to:   "RaceTiming&ResultsbyPrecisionRaceLLC"
# Or use regex: /Race\s*Timing\s*&\s*Results\s*by\s*Precision\s*Race\s*LLC/i

puts "=== RECOMMENDED PATTERN UPDATES ==="

# Test the corrected patterns
require 'pdf-reader'

pdf_path = '/Users/ryanarneson/Code/mca-race-results/tmp/race_pdfs/2024/MCA_7_Redhead_Official_Results_v3.pdf'
reader = PDF::Reader.new(pdf_path)

full_text = ""
reader.pages.each do |page|
  full_text += page.text + "\n"
end

# Corrected exact patterns
corrected_patterns = [
  "Race7Readhead-OfficialResults",
  "10/12/2024-10/13/2024", 
  "RaceTiming&ResultsbyPrecisionRaceLLC"
]

puts "\n=== TESTING CORRECTED PATTERNS ==="
corrected_patterns.each_with_index do |pattern, index|
  puts "\n#{index + 1}. Testing corrected pattern: '#{pattern}'"
  
  if full_text.include?(pattern)
    puts "   ✓ SUCCESS: Pattern found!"
  else
    puts "   ✗ FAILED: Pattern still not found"
  end
end

# Flexible regex patterns (recommended approach)
puts "\n=== TESTING FLEXIBLE REGEX PATTERNS ==="

regex_patterns = [
  { name: "Race7 Readhead", pattern: /Race7\s*Readhead\s*-?\s*Official\s*Results/i },
  { name: "Date range", pattern: /10\/12\/2024\s*-\s*10\/13\/2024/ },
  { name: "Race timing", pattern: /Race\s*Timing\s*&\s*Results\s*by\s*Precision\s*Race\s*LLC/i }
]

regex_patterns.each_with_index do |item, index|
  puts "\n#{index + 1}. Testing regex for #{item[:name]}: #{item[:pattern]}"
  
  match = full_text.match(item[:pattern])
  if match
    puts "   ✓ SUCCESS: Found match: '#{match[0]}'"
  else
    puts "   ✗ FAILED: No regex match found"
  end
end