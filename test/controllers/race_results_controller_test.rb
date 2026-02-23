require "test_helper"

class RaceResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race_result = race_results(:one)
  end

  test "should get index" do
    get race_results_url
    assert_response :success
  end

  test "should get new" do
    get new_race_result_url
    assert_response :success
  end

  test "should create race_result" do
    assert_difference("RaceResult.count") do
      post race_results_url, params: { race_result: {
        race_id: races(:pine_valley_race).id,
        racer_season_id: racer_seasons(:one).id,
        status: "finished",
        place: 1
      } }
    end

    assert_redirected_to race_result_url(RaceResult.last)
  end

  test "should show race_result" do
    get race_result_url(@race_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_race_result_url(@race_result)
    assert_response :success
  end

  test "should update race_result" do
    patch race_result_url(@race_result), params: { race_result: { status: "finished" } }
    assert_redirected_to race_result_url(@race_result)
  end

  test "should destroy race_result" do
    assert_difference("RaceResult.count", -1) do
      delete race_result_url(@race_result)
    end

    assert_redirected_to race_results_url
  end
end
