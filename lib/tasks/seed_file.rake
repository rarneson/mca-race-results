namespace :db do
  namespace :seed do
    desc "Run a specific seed file from db/seeds/ (e.g., rake db:seed:file FILE=2023_detroit_lakes)"
    task file: :environment do
      name = ENV["FILE"]
      abort "Usage: rake db:seed:file FILE=filename (without .rb extension)" unless name

      file = Rails.root.join("db", "seeds", "#{name}.rb")
      abort "Seed file not found: #{file}" unless File.exist?(file)

      puts "Loading #{name}.rb..."
      load file
      puts "Done."
    end
  end
end
