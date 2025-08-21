require "application_system_test_case"

class RacesTest < ApplicationSystemTestCase
  setup do
    @race = races(:cascade_mountain_challenge)
  end

  test "visiting the races index page" do
    visit races_url

    assert_selector "h1", text: "MTB Race Center"
    assert_selector "h2", text: "All Races"
    assert_selector "h3", text: @race.name
  end

  test "visiting the race results page" do
    visit race_url(@race)

    assert_selector "h1", text: "MTB Race Center"
    assert_selector "h2", text: @race.name
    assert_text @race.location
  end

  test "displays race statistics correctly" do
    visit race_url(@race)

    # Check overall winner card
    assert_selector ".text-amber-600", text: /Alex Rodriguez/
    
    # Check participants count
    assert_selector ".text-gray-900", text: /2/
    
    # Check results table exists
    assert_selector "table"
    assert_selector "th", text: /Pos/i
    assert_selector "th", text: /Name/i
    assert_selector "th", text: /Time/i
  end

  test "displays category filter buttons" do
    visit race_url(@race)
    
    # Check for category filter section
    assert_selector ".text-gray-700", text: "Filter by Category"
    assert_selector ".bg-emerald-100", text: "All Categories"
  end

  test "displays race results in table format" do
    visit race_url(@race)
    
    # Check table structure
    assert_selector "thead"
    assert_selector "tbody"
    assert_selector "tr"
    
    # Check for specific racer data
    assert_selector "td", text: "Alex Rodriguez"
    assert_selector ".bg-green-100", text: "FINISHED"
  end

  test "shows navigation tabs" do
    visit race_url(@race)
    
    assert_selector ".border-emerald-500", text: "Results"
    assert_selector ".text-gray-500", text: "Lap Analysis"
    assert_selector ".text-gray-500", text: "Statistics"
  end

  test "can navigate from index to race show" do
    visit races_url
    
    click_link @race.name
    
    assert_current_path race_path(@race)
    assert_selector "h2", text: @race.name
  end
end