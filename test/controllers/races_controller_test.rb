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
    assert_select "h2", "All Races"
    assert_select "h3", @race.name
  end

  test "should show race" do
    get race_url(@race)
    assert_response :success
    assert_select "h2", @race.name
    assert_select "td", text: /#{@racer.first_name}/
  end

  test "should display race statistics" do
    get race_url(@race)
    assert_response :success
    
    # Check for category filter buttons
    assert_select "span.text-sm.font-medium.text-gray-700", "Filter by Category"
    assert_select "a", text: /All Categories/
  end

  test "should display category results" do
    get race_url(@race)
    assert_response :success
    
    # Check for results table header
    assert_select "h3", "Race Results"
  end

  test "should display race results table" do
    get race_url(@race)
    assert_response :success
    
    # Check for results table
    assert_select "table"
    assert_select "th", "Pos"
    assert_select "th", "Name" 
    assert_select "th", "Time"
    assert_select "th", "Gap"
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