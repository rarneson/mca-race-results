require "application_system_test_case"

class RacersTest < ApplicationSystemTestCase
  setup do
    @racer = racers(:one)
  end

  test "visiting the index" do
    visit racers_url
    assert_selector "h1", text: "Racers"
  end

  test "should create racer" do
    visit racers_url
    click_on "New racer"

    click_on "Create Racer"

    assert_text "Racer was successfully created"
    click_on "Back"
  end

  test "should update Racer" do
    visit racer_url(@racer)
    click_on "Edit this racer", match: :first

    click_on "Update Racer"

    assert_text "Racer was successfully updated"
    click_on "Back"
  end

  test "should destroy Racer" do
    visit racer_url(@racer)
    accept_confirm { click_on "Destroy this racer", match: :first }

    assert_text "Racer was successfully destroyed"
  end
end
