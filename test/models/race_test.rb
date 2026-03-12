require "test_helper"

class RaceTest < ActiveSupport::TestCase
  test "race has many race results" do
    race = races(:cascade_mountain_challenge)
    assert_respond_to race, :race_results
    assert race.race_results.count > 0
  end

  test "race has required attributes" do
    race = Race.new(
      name: "Test Race",
      race_date: Date.current,
      location: "Test Location",
      year: 2024
    )

    assert race.valid?
  end

  test "destroying race destroys associated race results" do
    race = races(:cascade_mountain_challenge)
    result_count = race.race_results.count
    assert result_count > 0

    race.destroy
    assert_equal 0, RaceResult.where(race_id: race.id).count
  end
end
