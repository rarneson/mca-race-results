class RaceResult < ApplicationRecord
  belongs_to :race
  belongs_to :racer_season
  belongs_to :category, optional: true
  has_many :race_result_laps, dependent: :destroy

  validates :status, presence: true

  scope :finished, -> { where(status: "finished") }
  scope :dnf, -> { where(status: "DNF") }
  scope :dns, -> { where(status: "DNS") }
  scope :not_finished, -> { where.not(status: "finished") }

  def finished?
    status&.downcase == "finished"
  end

  def dnf?
    status&.upcase == "DNF"
  end

  def dns?
    status&.upcase == "DNS"
  end

  def dsq?
    status&.upcase == "DSQ"
  end

  def overall_time_seconds
    return 0 if total_time_ms.nil?
    total_time_ms / 1000.0
  end
end
