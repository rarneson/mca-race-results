require "application_system_test_case"

class RacersTest < ApplicationSystemTestCase
  setup do
    @racer = racers(:alex_rodriguez)
  end

  test "visiting the index" do
    visit racers_url
    assert_selector "h1", text: "ALL_RACERS"
  end

  test "should show racer" do
    visit racer_url(@racer)
    assert_text @racer.name.upcase
  end
end
