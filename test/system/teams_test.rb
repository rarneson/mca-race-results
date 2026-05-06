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
end
