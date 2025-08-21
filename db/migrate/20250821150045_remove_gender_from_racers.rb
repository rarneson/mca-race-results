class RemoveGenderFromRacers < ActiveRecord::Migration[8.0]
  def change
    remove_column :racers, :gender, :string
  end
end
