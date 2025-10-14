class AddDescriptionToRaces < ActiveRecord::Migration[8.0]
  def change
    add_column :races, :description, :text
  end
end
