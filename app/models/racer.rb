class Racer < ApplicationRecord
  belongs_to :team
  has_many :racer_seasons, dependent: :destroy
end
