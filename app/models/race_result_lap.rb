class RaceResultLap < ApplicationRecord
  belongs_to :race_result

  def lap_time_seconds
    return 0 if lap_time_ms.nil?
    lap_time_ms / 1000.0
  end

  def cumulative_time_seconds
    return 0 if cumulative_time_ms.nil?
    cumulative_time_ms / 1000.0
  end
end
