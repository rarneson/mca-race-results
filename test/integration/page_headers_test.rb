require "test_helper"

class PageHeadersTest < ActionDispatch::IntegrationTest
  setup do
    @race = races(:cascade_mountain_challenge)
    @team = teams(:mountain_velocity)
    @racer = racers(:alex_rodriguez)
  end

  test "races index renders page header with title and subtitle" do
    get races_url
    assert_response :success
    assert_select "h1.hud-mono.text-hud-accent", "ALL_RACES"
    assert_select "p.text-hud-ink-dim", /Every MCA mountain bike race/
  end

  test "races show renders page header with race name and date" do
    get race_url(@race)
    assert_response :success
    assert_select "h1.hud-mono.text-hud-accent", @race.name.upcase
    assert_select "div.hud-mono.text-hud-ink-dim", /#{Regexp.escape(@race.race_date.strftime("%B %-d, %Y"))}/
  end

  test "racers index renders page header with title" do
    get racers_url
    assert_response :success
    assert_select "h1.hud-mono.text-hud-accent", /\AALL_RACERS\./
  end

  test "teams index renders page header with title" do
    get teams_url
    assert_response :success
    assert_select "h1.hud-mono.text-hud-accent", /\AALL_TEAMS\./
  end

  test "teams show renders page header with team name" do
    get team_url(@team)
    assert_response :success
    assert_select "h1.hud-mono.text-hud-accent", @team.name.upcase
  end
end
