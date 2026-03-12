require "application_system_test_case"

class RacesTest < ApplicationSystemTestCase
  setup do
    @race = races(:cascade_mountain_challenge)
  end

  test "visiting the races index page" do
    visit races_url

    assert_selector "h1", text: "Race Results"
    assert_selector "h3", text: @race.name
  end

  test "visiting the race results page" do
    visit race_url(@race)

    assert_selector "h1", text: "Race Results"
    assert_selector "h2", text: @race.name
    assert_text @race.location
  end

  test "displays category filter" do
    visit race_url(@race)

    assert_text "Filter by Category"
  end

  test "displays race results table" do
    visit race_url(@race)

    assert_selector "thead"
    assert_selector "tbody"
    assert_selector "th", text: /pos/i
    assert_selector "th", text: /name/i
    assert_selector "td", text: "Alex Rodriguez"
  end

  test "shows navigation tabs" do
    visit race_url(@race)

    assert_text "Results"
    assert_text "Lap Analysis"
  end

  test "can navigate from index to race show" do
    visit races_url

    click_link @race.name

    assert_current_path race_path(@race)
    assert_selector "h2", text: @race.name
  end
end
