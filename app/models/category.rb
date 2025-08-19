class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :sort_order, presence: true

  scope :by_sort_order, -> { order(:sort_order) }

  def self.find_by_text(text)
    return nil if text.blank?
    
    # Clean up common variations
    cleaned_text = text.strip
      .gsub(/\s+/, ' ')
      .gsub(/Grade\s+/, 'Grade ')
      
    # Try exact match first
    category = find_by(name: cleaned_text)
    return category if category
    
    # Try fuzzy matching for common variations
    all.each do |category|
      if matches_category?(cleaned_text, category.name)
        return category
      end
    end
    
    nil
  end

  def gender
    name.include?('Girls') ? 'Girls' : 'Boys'
  end

  private

  def self.matches_category?(text, category_name)
    # Handle common PDF extraction variations
    variations = [
      category_name,
      category_name.gsub('th Grade', ' Grade'),
      category_name.gsub('Grade', 'Gr'),
      category_name.gsub(' Boys', ' Boy'),
      category_name.gsub(' Girls', ' Girl')
    ]
    
    variations.any? { |variation| text.include?(variation) || variation.include?(text) }
  end
end