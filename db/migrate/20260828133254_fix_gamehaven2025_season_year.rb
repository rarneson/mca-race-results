class FixGamehaven2025SeasonYear < ActiveRecord::Migration[8.1]
  # The 2025 Gamehaven Rochester race was originally seeded with race.year = 2024.
  # Because the import helper stamps RacerSeason.year from race.year, every result
  # in this race was attached to a 2024 season (and many of those seasons are shared
  # with real 2024 races). This moves each result onto the racer's correct 2025
  # season, carrying the plate number, and removes any 2024 season left empty.
  #
  # Idempotent and keyed on natural attributes (name + date), so it is safe to run
  # against any environment regardless of primary-key values.
  def up
    race = Race.find_by(name: "Race 4S - Gamehaven Rochester", race_date: Date.new(2025, 9, 20))
    return say("Race not found; nothing to do.") unless race

    race.update!(year: 2025) if race.year != 2025

    touched_season_ids = []

    race.race_results.includes(:racer_season).find_each do |result|
      old_season = result.racer_season
      next if old_season.year == 2025

      correct_season = RacerSeason.find_or_create_by!(racer_id: old_season.racer_id, year: 2025) do |season|
        season.plate_number = old_season.plate_number
      end

      next if correct_season.id == old_season.id

      result.update!(racer_season: correct_season)
      touched_season_ids << old_season.id
    end

    RacerSeason.where(id: touched_season_ids.uniq).find_each do |season|
      season.destroy! unless season.race_results.exists?
    end

    say("Reassigned #{touched_season_ids.size} results to 2025 seasons.")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
