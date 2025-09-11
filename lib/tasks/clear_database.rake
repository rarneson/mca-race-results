namespace :db do
    desc "Delete all race-related data from the database"
    task clear_database: :environment do
        puts 'Deleting all race data...'
        
        # Delete in correct order to respect foreign key constraints
        # Start with the most dependent (child) tables first
        puts '  Deleting race result laps...'
        RaceResultLap.delete_all
        
        puts '  Deleting race results...'
        RaceResult.delete_all
        
        puts '  Deleting races...'
        Race.delete_all
        
        puts '  Deleting racer seasons...'
        RacerSeason.delete_all
        
        puts '  Deleting racers...'
        Racer.delete_all
        
        puts '  Deleting teams...'
        Team.delete_all
        
        puts '  Deleting categories...'
        Category.delete_all
        
        puts 'All race data deleted successfully!'
    end
end