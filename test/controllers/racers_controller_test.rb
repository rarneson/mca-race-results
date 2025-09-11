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

  test "should show racer with team link in header" do
    get racer_url(@racer)
    assert_response :success
    # Check that team name is a link to team show page
    assert_select "a[href='#{team_path(@racer.team)}']", text: @racer.team_name
  end

  test "should show racer without team link when no team assigned" do
    # Create a racer without a team
    teamless_racer = Racer.create!(first_name: "Solo", last_name: "Rider")
    
    get racer_url(teamless_racer)
    assert_response :success
    # Should show "No Team" as plain text, not a link
    assert_select 'span', text: "No Team"
    assert_select "a", text: "No Team", count: 0  # Should not be a link
  end

  test "get_current_category returns most recent assignment" do
    racer = racers(:alex_rodriguez)
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    assert_not_nil category
    assert_equal 'Varsity', category.name
  end

  test "get_current_category returns category from most recent race result" do
    racer = racers(:alex_rodriguez)
    
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    assert_not_nil category
    assert_equal 'Varsity', category.name  # Should return category from race result
  end

  test "get_current_category handles racer with no race results" do
    # Test racer with no race results
    racer = racers(:sarah_chen)
    
    # Remove all race results to test fallback
    racer.racer_seasons.each { |season| season.race_results.destroy_all }
    
    controller = RacersController.new
    controller.instance_variable_set(:@racer, racer)
    
    category = controller.send(:get_current_category)
    # Should return nil when no race results exist
    assert_nil category, "Racer with no race results should have no category"
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
