# One season per racer per year
# A racer will have a different category and plate number each year
class CreateRacerSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :racer_seasons do |t|
      t.references :racer, null: false, foreign_key: true
      t.integer :year
      t.integer :category
      t.string :plate_number
      t.integer :penalty_ms

      t.timestamps
    end
  end
end
