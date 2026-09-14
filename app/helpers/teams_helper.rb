module TeamsHelper
  def group_racers_by_category(racers, year = Date.current.year)
    # Get all race results with categories for these racers filtered by year
    racers_with_categories = {}

    racers.each do |racer|
      # Get race results and their categories for the specified year
      race_results = racer.race_results.includes(:category, :race)
                          .joins(:race).merge(Race.in_year(year))
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

    sort_category_pairs(racers_with_categories).to_h do |category_name, category_racers|
      [ category_name, category_racers.uniq(&:id).sort_by { |r| r.last_name || "" } ]
    end
  end

  # Sorts [category_name, value] pairs descending by Category#sort_order (Varsity
  # first, then JV3, JV2, Freshman, 8th, 7th, 6th grade), with unknown/uncategorized
  # names last
  def sort_category_pairs(pairs)
    category_sort_orders = Category.pluck(:name, :sort_order).to_h
    pairs.sort_by do |category_name, _|
      sort_order = category_sort_orders[category_name]
      sort_order ? -sort_order : Float::INFINITY
    end
  end
end
