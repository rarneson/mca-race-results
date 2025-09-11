class RaceResult < ApplicationRecord
  belongs_to :race
  belongs_to :racer_season
  belongs_to :category, optional: true
  has_many :race_result_laps, dependent: :destroy

  def overall_time_seconds
    return 0 if total_time_ms.nil?
    total_time_ms / 1000.0
  end
end
