module TeamsHelper
  def group_racers_by_category(racers)
    # Get all race results with categories for these racers
    racers_with_categories = {}

    racers.each do |racer|
      # Get race results and their categories
      race_results = racer.race_results.includes(:category)
      categories = race_results.map(&:category).compact.uniq(&:id)
      
      
      # If no categories found in race results, racer is uncategorized
      if categories.empty?
        # Just add directly to uncategorized instead of creating an object
          racers_with_categories["Uncategorized"] ||= []
          unless racers_with_categories["Uncategorized"].any? { |existing_racer| existing_racer.id == racer.id }
            racers_with_categories["Uncategorized"] << racer
          end
          next # Skip the categories.each loop below
      end
      
      # Process each unique category for this racer
      seen_categories = Set.new
      categories.each do |category|
        category_name = category.name
        
        # Skip if we've already processed this category for this racer
        next if seen_categories.include?(category_name)
        seen_categories.add(category_name)
        
        racers_with_categories[category_name] ||= []
        unless racers_with_categories[category_name].any? { |existing_racer| existing_racer.id == racer.id }
          racers_with_categories[category_name] << racer
        end
      end
    end
    
    # Sort categories and racers, ensuring no duplicates
    sorted_categories = racers_with_categories.sort_by { |category_name, _| category_name }
    sorted_categories.to_h do |category_name, category_racers|
      [category_name, category_racers.uniq(&:id).sort_by { |r| r.last_name || '' }]
    end
  end
end
