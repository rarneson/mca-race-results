class AddUniqueConstraintToRaceResults < ActiveRecord::Migration[8.0]
  def change
    # First remove duplicates
    execute <<~SQL
      DELETE FROM race_results 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM race_results 
        GROUP BY race_id, racer_season_id
      )
    SQL
    
    # Add unique index to prevent future duplicates
    add_index :race_results, [:race_id, :racer_season_id], unique: true
  end
end
