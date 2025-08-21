require "test_helper"

class RacersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @racer = racers(:alex_rodriguez)
  end

  test "should get index" do
    get racers_url
    assert_response :success
  end

  test "should get new" do
    get new_racer_url
    assert_response :success
  end

  test "should create racer" do
    assert_difference("Racer.count") do
      post racers_url, params: { racer: {} }
    end

    assert_redirected_to racer_url(Racer.last)
  end

  test "should show racer" do
    get racer_url(@racer)
    assert_response :success
  end

  test "should show racer with current category" do
    get racer_url(@racer)
    assert_response :success
    assert_select 'span', text: /Varsity/  # Check that category is displayed in header
  end

  test "get_current_category returns most recent assignment" do
    racer = racers(:alex_rodriguez)
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    assert_not_nil category
    assert_equal 'Varsity', category.name
  end

  test "get_current_category handles racer with multiple assignments" do
    racer = racers(:alex_rodriguez)
    
    # Create a newer assignment
    newer_assignment = RacerSeasonAssignment.create!(
      racer_season: racer_seasons(:alex_2024),
      category: categories(:jv3),
      start_on: Date.new(2024, 6, 1),
      end_on: Date.new(2024, 12, 31),
      reason: "Mid-season promotion"
    )
    
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    assert_not_nil category
    assert_equal 'JV3', category.name  # Should return the newer assignment
  end

  test "get_current_category handles racer with only season assignment" do
    # Test fallback to racer_season category when no season assignments exist
    racer = racers(:sarah_chen)
    
    # Remove all season assignments to test fallback
    RacerSeasonAssignment.where(racer_season: racer.racer_seasons).destroy_all
    
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    # Should still return a category from the racer_season itself
    assert_not_nil category, "Racer should always have a category"
  end

  test "should get edit" do
    get edit_racer_url(@racer)
    assert_response :success
  end

  test "should update racer" do
    patch racer_url(@racer), params: { racer: {} }
    assert_redirected_to racer_url(@racer)
  end

  test "should destroy racer" do
    assert_difference("Racer.count", -1) do
      delete racer_url(@racer)
    end

    assert_redirected_to racers_url
  end
end
