class Racer < ApplicationRecord
  belongs_to :team, optional: true
  has_many :racer_seasons, dependent: :destroy
  has_many :race_results, through: :racer_seasons
  
  scope :orphaned, -> { where(team: nil) }
  scope :with_team, -> { where.not(team: nil) }

  def name
    "#{first_name} #{last_name}"
  end

  def team_name
    team&.name || "No Team"
  end

  def average_lap_time_seconds
    return 0 if race_results.empty?
    
    total_time_ms = race_results.sum(:total_time_ms) || 0
    total_laps = race_results.sum { |r| r.race_result_laps.count }
    return 0 if total_laps.zero?
    
    (total_time_ms / 1000.0) / total_laps
  end

  def average_overall_time_seconds
    return 0 if race_results.empty?
    avg_ms = race_results.average(:total_time_ms) || 0
    avg_ms / 1000.0
  end

  def lap_variability_seconds
    lap_times = all_lap_times
    return 0 if lap_times.empty?
    
    mean = lap_times.sum / lap_times.size.to_f
    variance = lap_times.map { |t| (t - mean)**2 }.sum / lap_times.size
    Math.sqrt(variance)
  end

  def fastest_lap_seconds
    lap_times = all_lap_times
    lap_times.empty? ? 0 : lap_times.min
  end

  def slowest_lap_seconds
    lap_times = all_lap_times
    lap_times.empty? ? 0 : lap_times.max
  end

  def pacing_index
    return 0 if fastest_lap_seconds.zero? || average_lap_time_seconds.zero?
    fastest_lap_seconds.to_f / average_lap_time_seconds
  end

  def endurance_score
    return 0 if race_results.empty?
    
    scores = race_results.map do |result|
      laps = result.race_result_laps.order(:lap_number)
      next 1.0 if laps.count < 2
      
      first_lap = laps.first.lap_time_seconds
      last_lap = laps.last.lap_time_seconds
      next 1.0 if first_lap.zero?
      
      last_lap.to_f / first_lap
    end.compact
    
    scores.empty? ? 0 : scores.sum / scores.size
  end

  private

  def all_lap_times
    race_results.includes(:race_result_laps).flat_map do |result|
      result.race_result_laps.map(&:lap_time_seconds).compact
    end
  end
end
