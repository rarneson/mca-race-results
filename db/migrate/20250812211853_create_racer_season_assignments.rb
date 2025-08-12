class CreateRacerSeasonAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :racer_season_assignments do |t|
      t.references :racer_season, null: false, foreign_key: true
      t.integer :category
      t.date :start_on
      t.date :end_on
      t.text :reason

      t.timestamps
    end
  end
end
