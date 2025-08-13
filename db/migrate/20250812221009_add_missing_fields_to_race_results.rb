class AddMissingFieldsToRaceResults < ActiveRecord::Migration[8.0]
  def change
    add_column :race_results, :total_time_raw, :string
  end
end
