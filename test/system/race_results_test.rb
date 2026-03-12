require "application_system_test_case"

class RaceResultsTest < ApplicationSystemTestCase
  setup do
    @race = races(:cascade_mountain_challenge)
  end

  test "visiting race results through race page" do
    visit race_url(@race)
    assert_selector "h3", text: "Race Results"
    assert_selector "table"
  end
end
