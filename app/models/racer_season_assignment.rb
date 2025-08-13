class RacerSeasonAssignment < ApplicationRecord
  belongs_to :racer_season
  has_many :race_results, dependent: :destroy
end
