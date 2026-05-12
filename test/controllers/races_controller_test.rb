require "test_helper"

class RacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race = races(:cascade_mountain_challenge)
    @team = teams(:mountain_velocity)
    @racer = racers(:alex_rodriguez)
    @racer_season = racer_seasons(:alex_2024)
    @race_result = race_results(:alex_first_place)
  end

  test "should get index" do
    get races_url
    assert_response :success
    assert_select "h1", "ALL_RACES"
    assert_select "div", text: @race.name
  end

  test "should show race" do
    get race_url(@race)
    assert_response :success
    assert_select "h1", @race.name.upcase
    assert_select "a", text: /#{@racer.first_name}/
  end

  test "should display category filter" do
    get race_url(@race)
    assert_response :success

    assert_select "div.hud-label", text: /CATEGORY/
    assert_select "select"
  end

  test "should display standings panel" do
    get race_url(@race)
    assert_response :success

    assert_select "div.hud-label", text: /STANDINGS/
  end

  test "should display race results table with HUD column headers" do
    get race_url(@race)
    assert_response :success

    assert_select "table"
    assert_select "th", text: /POS/
    assert_select "th", text: /RACER/
    assert_select "th", text: /TIME/
    assert_select "th", text: /GAP/
  end

  test "should handle race with no results" do
    empty_race = Race.create!(
      name: "Empty Race",
      race_date: Date.current,
      location: "Test Location",
      year: 2024
    )

    get race_url(empty_race)
    assert_response :success
  end

  test "compare with two valid racers renders head-to-head" do
    alex = race_results(:alex_first_place)
    sarah = race_results(:sarah_second_place)

    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, sarah.racer_season_id ])
    assert_response :success

    assert_select "h1", @race.name.upcase
    assert_select "div.hud-label", text: /LAP-BY-LAP/
    assert_select "th", text: /LAP_GAP/
    assert_select "table" do
      assert_select "tbody tr", minimum: 3
    end
    assert_match alex.racer_season.racer.name, response.body
    assert_match sarah.racer_season.racer.name, response.body
  end

  test "compare shows overall gap when lap counts match" do
    alex = race_results(:alex_first_place)
    sarah = race_results(:sarah_second_place)

    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, sarah.racer_season_id ])
    assert_response :success
    assert_select "div", text: /OVERALL GAP/
  end

  test "compare with fewer than two ids renders empty state" do
    get compare_race_url(@race, racer_season_ids: [ race_results(:alex_first_place).racer_season_id ])
    assert_response :success
    assert_select "div", text: /select two racers/
  end

  test "compare with no ids renders empty state" do
    get compare_race_url(@race)
    assert_response :success
    assert_select "div", text: /select two racers/
  end

  test "compare with ids not in this race renders empty state" do
    get compare_race_url(@race, racer_season_ids: [ 99_998, 99_999 ])
    assert_response :success
    assert_select "div", text: /select two racers/
  end

  test "compare flags cross-category comparison" do
    jv3 = categories(:jv3)
    mike = Racer.create!(first_name: "Mike", last_name: "Jones", team: teams(:mountain_velocity))
    mike_season = RacerSeason.create!(racer: mike, year: 2024, plate_number: "55")
    mike_result = RaceResult.create!(
      race: @race,
      racer_season: mike_season,
      place: 1,
      total_time_ms: 4_000_000,
      laps_completed: 2,
      laps_expected: 2,
      status: "finished",
      category: jv3,
      plate_number_snapshot: "55"
    )
    RaceResultLap.create!(race_result: mike_result, lap_number: 1, lap_time_ms: 2_000_000, cumulative_time_ms: 2_000_000)
    RaceResultLap.create!(race_result: mike_result, lap_number: 2, lap_time_ms: 2_000_000, cumulative_time_ms: 4_000_000)

    alex = race_results(:alex_first_place)
    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, mike_season.id ])
    assert_response :success

    assert_select "div", text: /DIFFERENT_CATEGORIES/
    assert_select "div", text: /GAP THROUGH L02/
  end

  test "compare back link preserves category from referer" do
    alex = race_results(:alex_first_place)
    sarah = race_results(:sarah_second_place)

    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, sarah.racer_season_id ]),
        headers: { "HTTP_REFERER" => race_url(@race, category: "Varsity") }
    assert_response :success

    expected_href = race_path(@race, category: "Varsity")
    assert_select "a.hud-link[href=?]", expected_href, text: /Back to Race/
  end

  test "compare back link falls back to shared racer category when referer lacks one" do
    alex = race_results(:alex_first_place)
    sarah = race_results(:sarah_second_place)

    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, sarah.racer_season_id ])
    assert_response :success

    expected_href = race_path(@race, category: alex.category.name)
    assert_select "a.hud-link[href=?]", expected_href, text: /Back to Race/
  end

  test "compare back link omits category when racers differ and no referer" do
    jv3 = categories(:jv3)
    mike = Racer.create!(first_name: "Mike", last_name: "Jones", team: teams(:mountain_velocity))
    mike_season = RacerSeason.create!(racer: mike, year: 2024, plate_number: "55")
    RaceResult.create!(
      race: @race,
      racer_season: mike_season,
      place: 1,
      total_time_ms: 4_000_000,
      laps_completed: 2,
      laps_expected: 2,
      status: "finished",
      category: jv3,
      plate_number_snapshot: "55"
    )

    alex = race_results(:alex_first_place)
    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, mike_season.id ])
    assert_response :success

    assert_select "a.hud-link[href=?]", race_path(@race), text: /Back to Race/
  end

  test "compare empty state back button preserves category from referer" do
    get compare_race_url(@race, racer_season_ids: [ race_results(:alex_first_place).racer_season_id ]),
        headers: { "HTTP_REFERER" => race_url(@race, category: "Varsity") }
    assert_response :success

    assert_select "a.hud-button[href=?]", race_path(@race, category: "Varsity"), text: /BACK TO RACE/
  end

  test "compare handles a DNF racer" do
    dnf_racer = Racer.create!(first_name: "Dani", last_name: "DNF", team: teams(:mountain_velocity))
    dnf_season = RacerSeason.create!(racer: dnf_racer, year: 2024, plate_number: "99")
    RaceResult.create!(
      race: @race,
      racer_season: dnf_season,
      place: nil,
      total_time_ms: nil,
      laps_completed: 0,
      laps_expected: 3,
      status: "DNF",
      category: categories(:varsity),
      plate_number_snapshot: "99"
    )

    alex = race_results(:alex_first_place)
    get compare_race_url(@race, racer_season_ids: [ alex.racer_season_id, dnf_season.id ])
    assert_response :success
    assert_match "DNF", response.body
  end
end
