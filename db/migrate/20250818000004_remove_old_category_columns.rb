class RemoveOldCategoryColumns < ActiveRecord::Migration[8.0]
  def change
    # Remove old integer category columns now that we have proper foreign key references
    remove_column :racer_seasons, :category, :integer
    remove_column :racer_season_assignments, :category, :integer  
    remove_column :race_results, :category_snapshot, :integer
  end
end