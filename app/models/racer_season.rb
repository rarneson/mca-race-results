class RacerSeason < ApplicationRecord
  belongs_to :racer
  has_many :racer_season_assignments, dependent: :destroy
  has_many :race_results, dependent: :destroy
end
