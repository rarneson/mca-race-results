class AddSlugToTeams < ActiveRecord::Migration[8.0]
  def change
    add_column :teams, :slug, :string
    add_index :teams, :slug, unique: true
  end
end
