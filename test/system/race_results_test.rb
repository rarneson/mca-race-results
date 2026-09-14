require "application_system_test_case"

class RaceResultsTest < ApplicationSystemTestCase
  setup do
    @race = races(:cascade_mountain_challenge)
  end

  test "visiting race results through race page" do
    visit race_url(@race)
    assert_selector "h1", text: @race.name.upcase
    assert_selector "table"
  end
end
