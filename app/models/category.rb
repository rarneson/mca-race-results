class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :sort_order, presence: true

  scope :by_sort_order, -> { order(:sort_order) }

  def self.find_by_text(text)
    return nil if text.blank?
    
    # Clean up common variations
    cleaned_text = text.strip.gsub(/\s+/, ' ')
    
    # Handle specific PDF truncation issues from Lake Rebecca and other PDFs
    truncation_fixes = {
      'h Grade Boys 1' => '6th Grade Boys D1',
      'h Grade Boys 2' => '6th Grade Boys D2', 
      'h Grade Girls' => '7th Grade Girls',
      'rshman Boys D1' => 'Freshman Boys D1',
      'rshman Boys D2' => 'Freshman Boys D2',
      'rshman Girls' => 'Freshman Girls'
    }
    
    # Apply truncation fix if found
    fixed_text = truncation_fixes[cleaned_text] || cleaned_text
    
    # Try exact match first
    category = find_by(name: fixed_text)
    return category if category
    
    # Try fuzzy matching for common variations
    all.each do |category|
      if matches_category?(fixed_text, category.name)
        return category
      end
    end
    
    nil
  end


  private

  def self.matches_category?(text, category_name)
    # Handle common PDF extraction variations
    text_lower = text.downcase.strip
    category_lower = category_name.downcase
    
    # Simple fuzzy matching for common variations
    variations = [
      category_name,
      category_lower,
      category_lower.gsub('th grade', ' grade'),
      category_lower.gsub(' d1', ' 1').gsub(' d2', ' 2'),
      text_lower.gsub(' 1', ' d1').gsub(' 2', ' d2')
    ]
    
    variations.any? { |variation| text_lower.include?(variation) || variation.include?(text_lower) }
  end
end