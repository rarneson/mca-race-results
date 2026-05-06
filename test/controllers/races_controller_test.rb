require "test_helper"

class RacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race = races(:cascade_mountain_challenge)
    @team = teams(:mountain_velocity)
    @racer = racers(:alex_rodriguez)
    @racer_season = racer_seasons(:alex_2024)
    @race_result = race_results(:alex_first_place)
  end

  test "should get index" do
    get races_url
    assert_response :success
    assert_select "h1", "ALL_RACES"
    assert_select "div", text: @race.name
  end

  test "should show race" do
    get race_url(@race)
    assert_response :success
    assert_select "h1", @race.name.upcase
    assert_select "a", text: /#{@racer.first_name}/
  end

  test "should display category filter" do
    get race_url(@race)
    assert_response :success

    assert_select "div.hud-label", text: /CATEGORY/
    assert_select "select"
  end

  test "should display standings panel" do
    get race_url(@race)
    assert_response :success

    assert_select "div.hud-label", text: /STANDINGS/
  end

  test "should display race results table with HUD column headers" do
    get race_url(@race)
    assert_response :success

    assert_select "table"
    assert_select "th", text: /POS/
    assert_select "th", text: /RACER/
    assert_select "th", text: /TIME/
    assert_select "th", text: /GAP/
  end

  test "should handle race with no results" do
    empty_race = Race.create!(
      name: "Empty Race",
      race_date: Date.current,
      location: "Test Location",
      year: 2024
    )

    get race_url(empty_race)
    assert_response :success
  end
end
