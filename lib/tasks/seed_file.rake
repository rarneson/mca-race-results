namespace :db do
  namespace :seed do
    desc "Run a specific seed file from db/seeds/ (e.g., rake db:seed:file[2023_detroit_lakes])"
    task :file, [:name] => :environment do |_t, args|
      abort "Usage: rake db:seed:file[filename] (without .rb extension)" unless args[:name]

      file = Rails.root.join("db", "seeds", "#{args[:name]}.rb")
      abort "Seed file not found: #{file}" unless File.exist?(file)

      puts "Loading #{args[:name]}.rb..."
      load file
      puts "Done."
    end
  end
end
