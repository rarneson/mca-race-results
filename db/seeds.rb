# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Definitive list of all legitimate team names
# This is the authoritative source - teams must be created from this list
TEAM_NAMES = [
  "Alexandria Youth Cycling",
  "Apple Valley HS",
  "Armstrong Cycle",
  "Austin HS",
  "BBBikers",
  "Bemidji",
  "Bloomington",
  "Bloomington Jefferson",
  "Borealis",
  "Brainerd HS",
  "Breck",
  "Burnsville HS",
  "Cannon Valley",
  "Champlin Park HS",
  "Chanhassen HS",
  "Chaska HS",
  "Cloquet-Esko-Carlton",
  "Cook County",
  "Crosby-Ironton HS",
  "Eagan HS",
  "East Ridge HS",
  "Eastview HS",
  "Eden Prairie HS",
  "Edina Cycling",
  "Elk River",
  "Hastings",
  "Hermantown-Proctor",
  "Hopkins HS",
  "Hudson HS",
  "Hutchinson Tigers",
  "Kerkhoven",
  "Lake Area Composite",
  "Lakeville North HS",
  "Lakeville South HS",
  "Mahtomedi HS",
  "Mankato West HS",
  "Maple Grove HS",
  "Minneapolis Northside",
  "Minneapolis Roosevelt HS",
  "Minneapolis South HS",
  "Minneapolis Southside",
  "Minneapolis Southwest HS",
  "Minneapolis Washburn HS",
  "Minnesota Valley",
  "Minnetonka HS",
  "Mound Westonka",
  "Mounds View HS",
  "New Prague MS and HS",
  "North Dakota",
  "Northwest",
  "Northwoods Cycling",
  "Orono HS",
  "Osseo Composite",
  "Osseo HS",
  "Prior Lake HS",
  "River Falls HS",
  "Rochester Area",
  "Rochester Century HS",
  "Rochester Mayo",
  "Rock Ridge",
  "Rockford",
  "Rogers HS",
  "Rosemount HS",
  "Roseville",
  "Shakopee HS",
  "St Cloud",
  "St Croix",
  "St Louis Park HS",
  "St Michael / Albertville",
  "St Paul Central",
  "St Paul Composite - North",
  "St Paul Composite - South",
  "St Paul Highland Park",
  "Stillwater Mountain Bike",
  "Tioga Trailblazers",
  "Totino Grace-Irondale",
  "Waconia HS",
  "Wayzata Mountain Bike",
  "White Bear Lake HS",
  "Winona",
  "Woodbury HS"
].freeze

CATEGORY_DATA = [
  { name: "6th Grade Girls", sort_order: 1 },
  { name: "6th Grade Boys D1", sort_order: 2 },
  { name: "6th Grade Boys D2", sort_order: 3 },
  { name: "7th Grade Girls", sort_order: 4 },
  { name: "7th Grade Boys D1", sort_order: 5 },
  { name: "7th Grade Boys D2", sort_order: 6 },
  { name: "8th Grade Girls", sort_order: 7 },
  { name: "8th Grade Boys D1", sort_order: 8 },
  { name: "8th Grade Boys D2", sort_order: 9 },
  { name: "Freshman Girls", sort_order: 10 },
  { name: "Freshman Boys D1", sort_order: 11 },
  { name: "Freshman Boys D2", sort_order: 12 },
  { name: "JV2 Girls", sort_order: 13 },
  { name: "JV2 Boys D1", sort_order: 14 },
  { name: "JV2 Boys D2", sort_order: 15 },
  { name: "JV3 Girls", sort_order: 16 },
  { name: "JV3 Boys D1", sort_order: 17 },
  { name: "JV3 Boys D2", sort_order: 18 },
  { name: "Varsity Girls", sort_order: 19 },
  { name: "Varsity Boys D1", sort_order: 20 },
  { name: "Varsity Boys D2", sort_order: 21 }
].freeze

puts "Creating categories..."

CATEGORY_DATA.each do |data|
  category = Category.find_or_create_by!(name: data[:name]) do |c|
    c.sort_order = data[:sort_order]
  end
  puts "✓ #{category.name}" if category.persisted?
end

puts "#{Category.count} categories created/verified."

puts "Creating teams from authoritative list..."

TEAM_NAMES.each do |team_name|
  team = Team.find_or_create_by!(name: team_name)
  puts "✓ #{team.name}" if team.persisted?
end

puts "#{Team.count} teams created/verified."
