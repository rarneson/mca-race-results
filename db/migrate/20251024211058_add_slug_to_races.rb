class AddSlugToRaces < ActiveRecord::Migration[8.0]
  def change
    add_column :races, :slug, :string
    add_index :races, :slug, unique: true
  end
end
