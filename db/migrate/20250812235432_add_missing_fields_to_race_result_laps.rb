class AddMissingFieldsToRaceResultLaps < ActiveRecord::Migration[8.0]
  def change
    add_column :race_result_laps, :lap_time_raw, :string
    add_column :race_result_laps, :cumulative_time_raw, :string
  end
end
