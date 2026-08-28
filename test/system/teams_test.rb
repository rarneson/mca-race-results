require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase
  setup do
    @team = teams(:one)
  end

  test "visiting the index" do
    visit teams_url
    assert_selector "h1", text: "ALL_TEAMS"
  end

  test "should show team" do
    visit team_url(@team)
    assert_text @team.name.upcase
  end

  test "searching stays scoped to the selected year" do
    create_2025_team("Northern Lights")

    visit teams_url
    click_on "2024"
    assert_selector "h1", text: "ALL_TEAMS.2024"

    fill_in "team_search", with: "Mountain"
    assert_no_selector "a", text: /Trail Blazers/
    assert_selector "a", text: /Mountain Velocity/
    assert_no_text "no teams match"
  end

  test "clearing the search stays on the selected year" do
    create_2025_team("Northern Lights")

    visit teams_url
    click_on "2024"

    fill_in "team_search", with: "Mountain"
    assert_selector "a", text: /Mountain Velocity/

    fill_in "team_search", with: ""
    assert_selector "a", text: /Trail Blazers/
    assert_no_selector "a", text: /Northern Lights/
  end

  test "switching years keeps the search term" do
    create_2025_team("Northern Lights")

    visit teams_url
    fill_in "team_search", with: "Northern"
    assert_selector "a", text: /Northern Lights/

    click_on "2024"
    assert_selector "h1", text: "ALL_TEAMS.2024"
    assert_equal "Northern", find("#team_search").value
  end

  private

  def create_2025_team(name)
    team = Team.create!(name: name, division: 1)
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
    team
  end
end
