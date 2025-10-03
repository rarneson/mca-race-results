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
    
    # Check that the page renders without error
    assert_select "h1", "Teams"
    assert_select "h2", "All Teams"  # Check that the "All Teams" section is rendered
  end

  test "should get index with search" do
    get teams_url, params: { search: "Mountain" }
    assert_response :success
    
    # Check that the page renders without error
    assert_select "h1", "Teams"
  end

  test "should get index when no teams exist" do
    Team.destroy_all
    get teams_url
    assert_response :success
    
    # Should show empty state
    assert_select "h3", "No teams found"
  end

  test "should get new" do
    get new_team_url
    assert_response :success
  end

  test "should create team" do
    assert_difference("Team.count") do
      post teams_url, params: { team: { name: "New Test Team", division: "division_1" } }
    end

    assert_redirected_to team_url(Team.last)
  end

  test "should show team" do
    get team_url(@team)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_url(@team)
    assert_response :success
  end

  test "should update team" do
    patch team_url(@team), params: { team: { name: "Updated Team Name" } }
    assert_redirected_to team_url(@team)
  end

  test "should destroy team" do
    assert_difference("Team.count", -1) do
      delete team_url(@team)
    end

    assert_redirected_to teams_url
  end
end
