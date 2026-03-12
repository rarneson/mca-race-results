require "test_helper"

class TeamsHelperTest < ActionView::TestCase
  include TeamsHelper

  test "group_racers_by_category should return empty hash for empty racers" do
    result = group_racers_by_category([])
    assert_equal({}, result)
  end

  test "group_racers_by_category should handle racers without categories" do
    # Create a racer without any race results (and thus no categories)
    racer = Racer.create!(first_name: "Test", last_name: "Racer")

    result = group_racers_by_category([ racer ])
    assert_equal({ "Uncategorized" => [ racer ] }, result)
  end

  test "group_racers_by_category should group racers by their categories" do
    # Create test data
    category1 = Category.create!(name: "Test Varsity #{Time.current.to_i}", sort_order: 1)
    category2 = Category.create!(name: "Test JV #{Time.current.to_i}", sort_order: 2)

    racer1 = Racer.create!(first_name: "Test1", last_name: "Racer1")
    racer2 = Racer.create!(first_name: "Test2", last_name: "Racer2")

    race = Race.create!(name: "Test Race #{Time.current.to_i}", race_date: Date.current)

    # Create racer seasons
    racer_season1 = RacerSeason.create!(racer: racer1)
    racer_season2 = RacerSeason.create!(racer: racer2)

    # Create race results with categories
    RaceResult.create!(racer_season: racer_season1, race: race, category: category1, place: 1, status: "finished")
    RaceResult.create!(racer_season: racer_season2, race: race, category: category2, place: 2, status: "finished")

    result = group_racers_by_category([ racer1, racer2 ])

    assert_equal 2, result.keys.count
    assert_includes result.keys, category1.name
    assert_includes result.keys, category2.name
    assert_equal [ racer1 ], result[category1.name]
    assert_equal [ racer2 ], result[category2.name]
  end
end
