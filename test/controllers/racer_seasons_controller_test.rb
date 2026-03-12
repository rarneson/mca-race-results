require "test_helper"

class RacerSeasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @racer_season = racer_seasons(:one)
    @racer = racers(:alex_rodriguez)
  end

  test "should get index" do
    get racer_seasons_url
    assert_response :success
  end

  test "should get new" do
    get new_racer_season_url
    assert_response :success
  end

  test "should create racer_season" do
    assert_difference("RacerSeason.count") do
      post racer_seasons_url, params: { racer_season: { racer_id: @racer.id, year: 2025 } }
    end

    assert_redirected_to racer_season_url(RacerSeason.last)
  end

  test "should show racer_season" do
    get racer_season_url(@racer_season)
    assert_response :success
  end

  test "should get edit" do
    get edit_racer_season_url(@racer_season)
    assert_response :success
  end

  test "should update racer_season" do
    patch racer_season_url(@racer_season), params: { racer_season: {} }
    assert_redirected_to racer_season_url(@racer_season)
  end

  test "should destroy racer_season" do
    assert_difference("RacerSeason.count", -1) do
      delete racer_season_url(@racer_season)
    end

    assert_redirected_to racer_seasons_url
  end
end
