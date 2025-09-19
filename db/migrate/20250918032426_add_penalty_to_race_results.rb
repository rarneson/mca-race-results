class AddPenaltyToRaceResults < ActiveRecord::Migration[8.0]
  def change
    add_column :race_results, :penalty, :string
  end
end
