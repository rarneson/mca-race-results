class Team < ApplicationRecord
  has_many :racers, dependent: :destroy
  
  enum :division, { division_1: 1, division_2: 2 }
end
