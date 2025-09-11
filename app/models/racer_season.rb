class RacerSeason < ApplicationRecord
  belongs_to :racer
  has_many :race_results, dependent: :destroy
  
  delegate :team, to: :racer
  
  # Get the racer's current category based on their most recent race
  def current_category
    race_results.joins(:race)
                .order('races.race_date DESC')
                .first&.category
  end
  
  # Get all categories this racer has competed in this season
  def categories_competed
    race_results.joins(:category)
                .select('categories.*')
                .distinct
  end
end
