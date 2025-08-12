# Results for a racer in a race (ties to specific season/assignment)
class CreateRaceResults < ActiveRecord::Migration[8.0]
  def change
    create_table :race_results do |t|
      t.references :race, null: false, foreign_key: true
      t.references :racer_season, null: false, foreign_key: true
      t.references :racer_season_assignment, null: false, foreign_key: true
      t.integer :place
      t.integer :total_time_ms
      t.integer :laps_completed
      t.integer :laps_expected
      t.string :status
      t.integer :category_snapshot
      t.string :plate_number_snapshot

      t.timestamps
    end
  end
end
