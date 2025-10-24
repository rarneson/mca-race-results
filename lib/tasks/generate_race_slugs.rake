namespace :races do
  desc "Generate slugs for all races"
  task generate_slugs: :environment do
    Race.find_each do |race|
      race.send(:generate_slug)
      race.save!(validate: false)
      puts "Generated slug for #{race.name}: #{race.slug}"
    end
    puts "All slugs generated successfully!"
  end
end
