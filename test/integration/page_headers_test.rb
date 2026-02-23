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
    assert_select "h1.text-3xl.font-bold.text-gray-900", "Race Results"
    assert_select "p.text-gray-600", "Browse all race results by season"
  end

  test "races show renders page header with title and subtitle" do
    get race_url(@race)
    assert_response :success
    assert_select "h1.text-3xl.font-bold.text-gray-900", "Race Results"
    assert_select "p.text-gray-600", "Browse all race results by season"
  end

  test "racers index renders page header with title" do
    get racers_url
    assert_response :success
    assert_select "h1.text-3xl.font-bold.text-gray-900", "Racers"
  end

  test "racers index renders dynamic count in subtitle" do
    get racers_url
    assert_response :success
    assert_select "p.text-gray-600 span#racers_count"
  end

  test "teams index renders page header with title" do
    get teams_url
    assert_response :success
    assert_select "h1.text-3xl.font-bold.text-gray-900", "Teams"
  end

  test "teams index renders dynamic count in subtitle" do
    get teams_url
    assert_response :success
    assert_select "p.text-gray-600 span#teams_count"
  end

  test "teams show renders page header with team name and subtitle" do
    get team_url(@team)
    assert_response :success
    assert_select "h1.text-3xl.font-bold.text-gray-900", @team.name
    assert_select "p.text-gray-600", /Complete roster and performance for/
  end

  test "all page headers have consistent h1 mb-2 class" do
    [ races_url, race_url(@race), racers_url, teams_url, team_url(@team) ].each do |url|
      get url
      assert_response :success
      assert_select "h1.mb-2", minimum: 1, message: "Expected h1.mb-2 on #{url}"
    end
  end
end
