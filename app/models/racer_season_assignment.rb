class RacerSeasonAssignment < ApplicationRecord
  belongs_to :racer_season
  belongs_to :category, optional: true
  has_many :race_results, dependent: :destroy
end
