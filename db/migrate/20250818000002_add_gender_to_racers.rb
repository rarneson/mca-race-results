class AddGenderToRacers < ActiveRecord::Migration[8.0]
  def change
    add_column :racers, :gender, :string
  end
end
