require "application_system_test_case"

class RacesTest < ApplicationSystemTestCase
  setup do
    @race = races(:cascade_mountain_challenge)
  end

  test "visiting the races index page" do
    visit races_url

    assert_selector "h1", text: "ALL_RACES"
    assert_text @race.name
  end

  test "visiting the race results page" do
    visit race_url(@race)

    assert_selector "h1", text: @race.name.upcase
    assert_text @race.location
  end

  test "displays category filter" do
    visit race_url(@race)

    assert_text "CATEGORY"
    assert_selector "select"
  end

  test "displays race results table" do
    visit race_url(@race)

    assert_selector "thead"
    assert_selector "tbody"
    assert_selector "th", text: /pos/i
    assert_selector "th", text: /racer/i
    assert_text "Alex Rodriguez"
  end

  test "shows navigation tabs" do
    visit race_url(@race)

    assert_text "RESULTS"
    assert_text "LAP_ANALYSIS"
  end

  test "can navigate from index to race show" do
    visit races_url

    click_link @race.name

    assert_current_path race_path(@race)
    assert_selector "h1", text: @race.name.upcase
  end

  test "compares two racers head-to-head" do
    alex = race_results(:alex_first_place)
    sarah = race_results(:sarah_second_place)

    visit compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, sarah.racer_season_id ])

    assert_selector "h1", text: @race.name.upcase
    assert_text "LAP-BY-LAP"
    assert_text alex.racer_season.racer.name
    assert_text sarah.racer_season.racer.name
    assert_text "OVERALL GAP"
  end

  test "compare empty state when no racers selected" do
    visit compare_race_url(@race)

    assert_text "select two racers"
  end
end
