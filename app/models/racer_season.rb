class RacerSeason < ApplicationRecord
  belongs_to :racer
  belongs_to :category, optional: true
  has_many :racer_season_assignments, dependent: :destroy
  has_many :race_results, dependent: :destroy
end
