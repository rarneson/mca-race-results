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

    assert_select "h1", "Teams"
  end

  test "should list teams with race results on index" do
    get teams_url, params: { year: 2024 }
    assert_response :success

    assert_select "a", "Mountain Velocity"
    assert_select "a", "Trail Blazers"
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

    assert_select "h1", "Teams"
  end

  test "should get index when no teams exist" do
    Team.destroy_all
    get teams_url
    assert_response :success

    assert_select "h3", "No teams found"
  end

  test "should show team" do
    get team_url(@team)
    assert_response :success
  end
end
