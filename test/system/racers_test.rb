require "application_system_test_case"

class RacersTest < ApplicationSystemTestCase
  setup do
    @racer = racers(:alex_rodriguez)
  end

  test "visiting the index" do
    visit racers_url
    assert_selector "h1", text: "ALL_RACERS"
  end

  test "should show racer" do
    visit racer_url(@racer)
    assert_text @racer.name.upcase
  end

  test "searching stays scoped to the selected year" do
    create_2025_racer

    visit racers_url
    click_on "2024"
    assert_selector "h1", text: "ALL_RACERS.2024"

    fill_in "racer_search", with: "Chen"
    assert_no_selector "a", text: /Alex Rodriguez/
    assert_selector "a", text: /Sarah Chen/
  end

  test "switching years keeps the search term" do
    create_2025_racer

    visit racers_url
    fill_in "racer_search", with: "Nora"
    assert_selector "a", text: /Nora North/

    click_on "2024"
    assert_selector "h1", text: "ALL_RACERS.2024"
    assert_equal "Nora", find("#racer_search").value
  end

  private

  def create_2025_racer
    team = Team.create!(name: "Northern Lights", division: 1)
    racer = Racer.create!(first_name: "Nora", last_name: "North", number: "77", team: team)
    race = Race.create!(name: "Northwoods Classic", race_date: Date.new(2025, 6, 1), location: "Duluth, MN", year: 2025)
    season = RacerSeason.create!(racer: racer, year: 2025, plate_number: "77", penalty_ms: 0)
    RaceResult.create!(
      race: race,
      racer_season: season,
      place: 1,
      total_time_ms: 5_940_000,
      laps_completed: 3,
      laps_expected: 3,
      status: "finished",
      category: categories(:varsity),
      plate_number_snapshot: "77"
    )
    racer
  end
end
