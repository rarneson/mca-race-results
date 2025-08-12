class CreateRaces < ActiveRecord::Migration[8.0]
  def change
    create_table :races do |t|
      t.string :name
      t.date :race_date
      t.string :location
      t.integer :year

      t.timestamps
    end
  end
end
