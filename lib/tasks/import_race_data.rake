namespace :import do
  desc "Import race results from PDF files"
  task race_results: :environment do
    pdf_directory = ENV['PDF_DIR'] || Rails.root.join('tmp', 'race_pdfs')
    
    unless Dir.exist?(pdf_directory)
      puts "PDF directory not found: #{pdf_directory}"
      puts "Set PDF_DIR environment variable or place PDFs in tmp/race_pdfs/"
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
        # Parse PDF
        parser = RaceData::PdfParser.new(pdf_path)
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
      # Parse PDF
      parser = RaceData::PdfParser.new(pdf_path)
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

  desc "Validate race data structure without importing"
  task :validate, [:pdf_path] => :environment do |task, args|
    pdf_path = args[:pdf_path]
    
    unless pdf_path && File.exist?(pdf_path)
      puts "Usage: rails import:validate[path/to/race.pdf]"
      exit 1
    end

    puts "Validating: #{pdf_path}"
    
    begin
      # Parse PDF
      parser = RaceData::PdfParser.new(pdf_path)
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
end