class RaceResult < ApplicationRecord
  belongs_to :race
  belongs_to :racer_season
  belongs_to :racer_season_assignment
end
