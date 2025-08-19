class UpdateCategoryReferences < ActiveRecord::Migration[8.0]
  def change
    # Add category references
    add_reference :racer_seasons, :category, null: true, foreign_key: true
    add_reference :racer_season_assignments, :category, null: true, foreign_key: true
    add_reference :race_results, :category_snapshot, null: true, foreign_key: { to_table: :categories }
    
    # Remove old integer category columns (will do this in a separate migration after data migration)
    # remove_column :racer_seasons, :category, :integer
    # remove_column :racer_season_assignments, :category, :integer  
    # remove_column :race_results, :category_snapshot, :integer
  end
end