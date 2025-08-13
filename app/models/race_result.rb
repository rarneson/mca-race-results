class RaceResult < ApplicationRecord
  belongs_to :race
  belongs_to :racer_season
  belongs_to :racer_season_assignment
  has_many :race_result_laps, dependent: :destroy
end
