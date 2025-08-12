# Racers (belongs_to :team)
class CreateRacers < ActiveRecord::Migration[8.0]
  def change
    create_table :racers do |t|
      t.string :first_name
      t.string :last_name
      t.string :number
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
