# Normalized per-lap times
class CreateRaceResultLaps < ActiveRecord::Migration[8.0]
  def change
    create_table :race_result_laps do |t|
      t.references :race_result, null: false, foreign_key: true
      t.integer :lap_number
      t.integer :lap_time_ms
      t.integer :cumulative_time_ms

      t.timestamps
    end
  end
end
