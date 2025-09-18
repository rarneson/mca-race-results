class AddCommentsToRaceResults < ActiveRecord::Migration[8.0]
  def change
    add_column :race_results, :comments, :text
  end
end
