class SimplifyCategorySystem < ActiveRecord::Migration[8.0]
  def up
    # Rename race_results.category_snapshot_id to category_id
    rename_column :race_results, :category_snapshot_id, :category_id
    
    # Remove foreign key and column reference to racer_season_assignments
    remove_foreign_key :race_results, :racer_season_assignments
    remove_column :race_results, :racer_season_assignment_id, :integer
    
    # Drop the racer_season_assignments table entirely
    drop_table :racer_season_assignments
    
    # Remove category_id from racer_seasons table
    remove_column :racer_seasons, :category_id, :integer
  end

  def down
    # Reverse the changes in reverse order
    add_column :racer_seasons, :category_id, :integer
    add_index :racer_seasons, :category_id
    add_foreign_key :racer_seasons, :categories, column: :category_id
    
    # Recreate racer_season_assignments table
    create_table :racer_season_assignments do |t|
      t.references :racer_season, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.date :start_on
      t.date :end_on
      t.string :reason
      t.timestamps
    end
    
    # Add back the racer_season_assignment_id to race_results
    add_column :race_results, :racer_season_assignment_id, :integer, null: false
    add_foreign_key :race_results, :racer_season_assignments
    
    # Rename back
    rename_column :race_results, :category_id, :category_snapshot_id
  end
end
