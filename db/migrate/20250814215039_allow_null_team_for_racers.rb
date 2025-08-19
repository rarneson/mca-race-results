class AllowNullTeamForRacers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :racers, :team_id, true
  end
end
