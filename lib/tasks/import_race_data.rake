require_relative '../race_data/parser_factory'

namespace :import do
  desc "Import race results from PDF files"
  task race_results: :environment do
    year = ENV['YEAR'] || '2024'
    pdf_directory = ENV['PDF_DIR'] || Rails.root.join('tmp', 'race_pdfs', year)
    
    unless Dir.exist?(pdf_directory)
      puts "PDF directory not found: #{pdf_directory}"
      puts "Set PDF_DIR environment variable or place PDFs in tmp/race_pdfs/#{year}/"
      exit 1
    end

    pdf_files = Dir.glob("#{pdf_directory}/**/*.pdf")
    
    if pdf_files.empty?
      puts "No PDF files found in #{pdf_directory}"
      exit 1
    end

    puts "Found #{pdf_files.count} PDF files to process..."
    
    successful_imports = 0
    failed_imports = []

    pdf_files.each_with_index do |pdf_path, index|
      puts "\n[#{index + 1}/#{pdf_files.count}] Processing: #{File.basename(pdf_path)}"
      
      begin
        # Parse PDF using factory
        parser = RaceData::ParserFactory.create_parser(pdf_path)
        raw_data = parser.extract_race_data
        
        # Normalize data
        normalizer = RaceData::Normalizer.new(raw_data)
        normalized_data = normalizer.normalize
        
        # Import to database
        importer = RaceData::Importer.new(normalized_data)
        race = importer.import!
        
        puts "✓ Successfully imported race: #{race.name} (#{race.race_date})"
        successful_imports += 1
        
      rescue => e
        error_msg = "Failed to import #{File.basename(pdf_path)}: #{e.message}"
        puts "✗ #{error_msg}"
        failed_imports << { file: pdf_path, error: e.message }
        
        # Continue processing other files
      end
    end
    
    puts "\n" + "="*50
    puts "Import Summary:"
    puts "Successfully imported: #{successful_imports}"
    puts "Failed imports: #{failed_imports.count}"
    
    if failed_imports.any?
      puts "\nFailed files:"
      failed_imports.each do |failure|
        puts "  - #{File.basename(failure[:file])}: #{failure[:error]}"
      end
    end
  end

  desc "Import a single race result PDF"
  task :single_race, [:pdf_path] => :environment do |task, args|
    pdf_path = args[:pdf_path]
    
    unless pdf_path && File.exist?(pdf_path)
      puts "Usage: rails import:single_race[path/to/race.pdf]"
      exit 1
    end

    puts "Processing: #{pdf_path}"
    
    begin
      # Parse PDF using factory
      parser = RaceData::ParserFactory.create_parser(pdf_path)
      raw_data = parser.extract_race_data
      
      # Normalize data
      normalizer = RaceData::Normalizer.new(raw_data)
      normalized_data = normalizer.normalize
      
      # Import to database
      importer = RaceData::Importer.new(normalized_data)
      race = importer.import!
      
      puts "✓ Successfully imported race: #{race.name} (#{race.race_date})"
      puts "  - Results: #{race.race_results.count}"
      puts "  - Lap times: #{RaceResultLap.joins(:race_result).where(race_results: { race: race }).count}"
      
    rescue => e
      puts "✗ Failed to import: #{e.message}"
      puts e.backtrace.first(5).join("\n") if Rails.env.development?
      exit 1
    end
  end

  desc "Detect PDF format for a race file"
  task :detect_format, [:pdf_path] => :environment do |task, args|
    pdf_path = args[:pdf_path]
    
    unless pdf_path && File.exist?(pdf_path)
      puts "Usage: rails import:detect_format[path/to/race.pdf]"
      exit 1
    end

    puts "Analyzing format: #{pdf_path}"
    
    begin
      parser = RaceData::ParserFactory.create_parser(pdf_path)
      puts "✓ Detected format: #{parser.class.name}"
      
    rescue RaceData::UnsupportedFormatError => e
      puts "✗ #{e.message}"
      puts "\nAvailable parsers:"
      RaceData::ParserFactory::PARSERS.each do |parser_class|
        puts "  - #{parser_class.name}"
      end
      exit 1
    rescue => e
      puts "✗ Error detecting format: #{e.message}"
      exit 1
    end
  end

  desc "Validate race data structure without importing"
  task :validate, [:pdf_path] => :environment do |task, args|
    pdf_path = args[:pdf_path]
    
    unless pdf_path && File.exist?(pdf_path)
      puts "Usage: rails import:validate[path/to/race.pdf]"
      exit 1
    end

    puts "Validating: #{pdf_path}"
    
    begin
      # Try factory first, fallback to MCA parser for debugging
      begin
        parser = RaceData::ParserFactory.create_parser(pdf_path)
      rescue RaceData::UnsupportedFormatError
        puts "Format not recognized, using MCA parser for debugging..."
        parser = RaceData::McaPdfParser.new(pdf_path)
      end
      
      raw_data = parser.extract_race_data
      
      puts "\nRaw data structure:"
      pp raw_data
      
      # Normalize data
      normalizer = RaceData::Normalizer.new(raw_data)
      normalized_data = normalizer.normalize
      
      puts "\nNormalized data structure:"
      pp normalized_data
      
      puts "\n✓ Validation complete - data structure looks good"
      
    rescue => e
      puts "✗ Validation failed: #{e.message}"
      puts e.backtrace.first(5).join("\n") if Rails.env.development?
      exit 1
    end
  end

  desc "Clean up team names that contain racer names"
  task clean_team_names: :environment do
    puts "Cleaning up team names that contain racer names..."
    
    # Comprehensive team patterns based on all known legitimate teams
    team_patterns = [
      # Specific school/team patterns
      /Alexandria\s*Youth\s*Cycling/i,
      /Apple\s*Valley\s*HS?/i,
      /Armstrong\s*Cycle/i,
      /Austin\s*HS?/i,
      /BBBikers/i,
      /Bemidji/i,
      /Bikers/i,
      /Bloomington(\s*Jefferson)?/i,
      /Borealis/i,
      /Brainerd\s*HS?/i,
      /Breck/i,
      /Burnsville\s*HS?/i,
      /Cannon\s*Valley/i,
      /Champlin\s*Park?.*HS?/i,
      /Chanhassen\s*HS?/i,
      /Chaska\s*HS?/i,
      /Cloquet-?Esko-?Carlton/i,
      /Cook\s*County/i,
      /Crosby-?Ironton.*HS?/i,
      /Eagan\s*HS?/i,
      /East\s*Ridge\s*HS?/i,
      /Eastview\s*HS?/i,
      /Eden\s*Prairie\s*HS?/i,
      /Edina\s*Cycling/i,
      /Elk\s*River/i,
      /Falls\s*HS?/i,
      /Grove\s*HS?/i,
      /Hastings/i,
      /Hermantown-?\s*Proctor/i,
      /Hopkins\s*HS?/i,
      /Hudson\s*HS?/i,
      /Hutchinson\s*T[ige]+rs?/i,
      /Kerkhoven/i,
      /Lake\s*Area\s*Composite/i,
      /Lake\s*HS?/i,
      /Lakeville\s*(North|Nhr).*HS?/i,
      /Lakeville\s*(South|Soh).*HS?/i,
      /Mahtomedi\s*HS?/i,
      /Mankato(\s*West)?\s*HS?/i,
      /Maple\s*Grove.*HS?/i,
      /Minneapolis(\s*(Northside|Nrthside|orthside|Roosevelt|South|Southside|Southwest|Washburn))?(\s*HS)?/i,
      /Minnesota\s*Valley/i,
      /Minnetonka\s*HS?/i,
      /Mound\s*Westo?n?ka/i,
      /Mounds\s*View\s*HS?/i,
      /New\s*Prague\s*(MS\s*and\s*)?HS?/i,
      /North\s*Dakota/i,
      /Northwest/i,
      /Northwoods\s*Cycling/i,
      /Orono\s*HS?/i,
      /Osseo\s*(Composite|HS?)/i,
      /Park\s*HS?/i,
      /Prairie\s*HS?/i,
      /Prior\s*Lake\s*HS?/i,
      /Ridge\s*HS?/i,
      /River(\s*Falls\s*HS?)?/i,
      /Rochester\s*(Area|Century|Mayo)/i,
      /Rock\s*Ridge/i,
      /Rockford/i,
      /Rogers\s*HS?/i,
      /Rosemount\s*HS?/i,
      /Roseville/i,
      /Shakopee\s*HS?/i,
      /St\.?\s*Cloud/i,
      /St\.?\s*Croix/i,
      /St\.?\s*Louis\s*Park\s*HS?/i,
      /St\.?\s*Michael\s*\/?\s*[Aa]lbertville/i,
      /St\.?\s*Paul\s*(Central|Composite\s*-?\s*(North|South)|Highland\s*Park)/i,
      /Stillwater\s*M[ou]+ntain\s*Bike/i,
      /Tioga\s*Trailblazers/i,
      /Totino\s*Grace-?\s*Irondale/i,
      /Valley\s*HS?/i,
      /View\s*HS?/i,
      /Waconia\s*HS?/i,
      /Wayzata\s*Mountain\s*Bike/i,
      /West\s*HS?/i,
      /White\s*Bear\s*Lake?.*HS?/i,
      /Winona/i,
      /Woodbury\s*HS?/i
    ]
    
    fixed_count = 0
    
    Team.all.each do |team|
      original_name = team.name
      
      # Skip if team name looks normal (doesn't contain obvious racer name patterns)
      next unless original_name.match?(/^[A-Z]{2,}\s+[A-Z]+.*\s{5,}/)
      
      # Try to extract the real team name from the corrupted string
      team_patterns.each do |pattern|
        if match = original_name.match(pattern)
          # Extract the team name part
          extracted_team = match[0].strip
          
          # Clean up spacing and formatting
          clean_team_name = extracted_team.gsub(/\s+/, ' ').strip
          
          # Update if we found a reasonable team name
          if clean_team_name.length > 3 && clean_team_name != original_name
            puts "Fixing: '#{original_name}' -> '#{clean_team_name}'"
            team.update!(name: clean_team_name)
            fixed_count += 1
            break
          end
        end
      end
    end
    
    puts "\n✓ Fixed #{fixed_count} team names"
    puts "Remaining teams with potential issues:"
    
    # Show teams that still might have issues
    Team.all.each do |team|
      if team.name.match?(/^[A-Z]{2,}\s+[A-Z]+.*\s{5,}/)
        puts "  - #{team.name}"
      end
    end
  end
end