require "application_system_test_case"

class RacerSeasonsTest < ApplicationSystemTestCase
  setup do
    @racer_season = racer_seasons(:one)
  end

  test "visiting the index" do
    visit racer_seasons_url
    assert_selector "h1", text: "Racer seasons"
  end

  test "should create racer season" do
    visit racer_seasons_url
    click_on "New racer season"

    click_on "Create Racer season"

    assert_text "Racer season was successfully created"
    click_on "Back"
  end

  test "should update Racer season" do
    visit racer_season_url(@racer_season)
    click_on "Edit this racer season", match: :first

    click_on "Update Racer season"

    assert_text "Racer season was successfully updated"
    click_on "Back"
  end

  test "should destroy Racer season" do
    visit racer_season_url(@racer_season)
    accept_confirm { click_on "Destroy this racer season", match: :first }

    assert_text "Racer season was successfully destroyed"
  end
end
