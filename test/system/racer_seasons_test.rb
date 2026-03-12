require "application_system_test_case"

class RacerSeasonsTest < ApplicationSystemTestCase
  setup do
    @racer_season = racer_seasons(:one)
  end

  test "visiting the index" do
    visit racer_seasons_url
    assert_selector "h1", text: "Racer seasons"
  end
end
