require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = teams(:one)
  end

  test "should get index" do
    get teams_url
    assert_response :success
  end

  test "should get index and display team statistics" do
    get teams_url
    assert_response :success

    assert_select "h1", /\AALL_TEAMS\./
  end

  test "should list teams with race results on index" do
    get teams_url, params: { year: 2024 }
    assert_response :success

    assert_select "a", text: /Mountain Velocity/
    assert_select "a", text: /Trail Blazers/
  end

  test "should default to most recent year with data" do
    get teams_url
    assert_response :success

    assert @response.body.include?("Mountain Velocity") || @response.body.include?("Trail Blazers"),
           "Expected teams to be listed when defaulting to most recent year with data"
  end

  test "should get index with search" do
    get teams_url, params: { search: "Mountain" }
    assert_response :success

    assert_select "h1", /\AALL_TEAMS\./
  end

  test "should get index when no teams exist" do
    Team.destroy_all
    get teams_url
    assert_response :success

    assert_select "p", /no teams recorded/
  end

  test "should show team" do
    get team_url(@team)
    assert_response :success
  end

  test "search is scoped to the selected year" do
    create_2025_team("Northern Lights")

    get teams_url, params: { year: 2025, search: "Northern" }
    assert_response :success
    assert_select "a", text: /Northern Lights/

    get teams_url, params: { year: 2024, search: "Northern" }
    assert_response :success
    assert_select "p", /no teams match/
  end

  test "clearing the search keeps the selected year" do
    create_2025_team("Northern Lights")

    get teams_url, params: { year: 2025 }
    assert_response :success
    assert_select "a", text: /Northern Lights/
    assert_select "a", text: /Mountain Velocity/, count: 0
  end

  test "year tabs carry the active search term" do
    create_2025_team("Northern Lights")

    get teams_url, params: { year: 2024, search: "Mountain" }
    assert_response :success
    assert_select "a[href=?]", teams_path(year: 2025, search: "Mountain")
  end

  test "turbo stream search response refreshes the year tabs" do
    create_2025_team("Northern Lights")

    get teams_url, params: { year: 2025, search: "Northern" }, as: :turbo_stream
    assert_response :success

    assert_match "teams_filters", @response.body
    assert_match "teams_table", @response.body
    assert_match "teams_count", @response.body
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
