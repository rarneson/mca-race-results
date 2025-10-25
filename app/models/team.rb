class Team < ApplicationRecord
  has_many :racers, dependent: :destroy

  enum :division, { division_1: 1, division_2: 2 }

  before_validation :generate_slug, if: -> { name.present? && (slug.blank? || name_changed?) }

  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    base_slug = name.parameterize
    potential_slug = base_slug
    counter = 1

    while Team.where(slug: potential_slug).where.not(id: id).exists?
      potential_slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    self.slug = potential_slug
  end
end
