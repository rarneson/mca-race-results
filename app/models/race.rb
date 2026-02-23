class Race < ApplicationRecord
  has_many :race_results, dependent: :destroy

  scope :in_year, ->(year) { where(race_date: Date.new(year, 1, 1)..Date.new(year, 12, 31)) }
  scope :available_years, -> { distinct.pluck(:race_date).map(&:year).uniq.sort.reverse }

  before_validation :generate_slug, if: -> { name.present? && (slug.blank? || name_changed?) }

  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    year_prefix = year || race_date&.year || Time.current.year
    base_slug = "#{year_prefix}-#{name.parameterize}"
    potential_slug = base_slug
    counter = 1

    while Race.where(slug: potential_slug).where.not(id: id).exists?
      potential_slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    self.slug = potential_slug
  end
end
