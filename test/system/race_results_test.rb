require "application_system_test_case"

class RaceResultsTest < ApplicationSystemTestCase
  setup do
    @race_result = race_results(:one)
  end

  test "visiting the index" do
    visit race_results_url
    assert_selector "h1", text: "Race results"
  end

  test "should create race result" do
    visit race_results_url
    click_on "New race result"

    click_on "Create Race result"

    assert_text "Race result was successfully created"
    click_on "Back"
  end

  test "should update Race result" do
    visit race_result_url(@race_result)
    click_on "Edit this race result", match: :first

    click_on "Update Race result"

    assert_text "Race result was successfully updated"
    click_on "Back"
  end

  test "should destroy Race result" do
    visit race_result_url(@race_result)
    accept_confirm { click_on "Destroy this race result", match: :first }

    assert_text "Race result was successfully destroyed"
  end
end
