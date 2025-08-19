module RaceData
  class TeamNameExtractor
    # Definitive list of all legitimate team names
    # This is the authoritative list - teams must match exactly
    VALID_TEAMS = [
      "Alexandria Youth Cycling",
      "Apple Valley HS",
      "Armstrong Cycle",
      "Austin HS",
      "BBBikers",
      "Bemidji",
      "Bloomington",
      "Bloomington Jefferson",
      "Borealis",
      "Brainerd HS",
      "Breck",
      "Burnsville HS",
      "Cannon Valley",
      "Champlin Park HS",
      "Chanhassen HS",
      "Chaska HS",
      "Cloquet-Esko-Carlton",
      "Cook County",
      "Crosby-Ironton HS",
      "Eagan HS",
      "East Ridge HS",
      "Eastview HS",
      "Eden Prairie HS",
      "Edina Cycling",
      "Elk River",
      "Hastings",
      "Hermantown-Proctor",
      "Hopkins HS",
      "Hudson HS",
      "Hutchinson Tigers",
      "Kerkhoven",
      "Lake Area Composite",
      "Lakeville North HS",
      "Lakeville South HS",
      "Mahtomedi HS",
      "Mankato West HS",
      "Maple Grove HS",
      "Minneapolis Northside",
      "Minneapolis Roosevelt HS",
      "Minneapolis South HS",
      "Minneapolis Southside",
      "Minneapolis Southwest HS",
      "Minneapolis Washburn HS",
      "Minnesota Valley",
      "Minnetonka HS",
      "Mound Westonka",
      "Mounds View HS",
      "New Prague MS and HS",
      "North Dakota",
      "Northwest",
      "Northwoods Cycling",
      "Orono HS",
      "Osseo Composite",
      "Osseo HS",
      "Prior Lake HS",
      "River Falls HS",
      "Rochester Area",
      "Rochester Century HS",
      "Rochester Mayo",
      "Rock Ridge",
      "Rockford",
      "Rogers HS",
      "Rosemount HS",
      "Roseville",
      "Shakopee HS",
      "St Cloud",
      "St Croix",
      "St Louis Park HS",
      "St Michael / Albertville",
      "St Paul Central",
      "St Paul Composite - North",
      "St Paul Composite - South",
      "St Paul Highland Park",
      "Stillwater Mountain Bike",
      "Tioga Trailblazers",
      "Totino Grace-Irondale",
      "Waconia HS",
      "Wayzata Mountain Bike",
      "White Bear Lake HS",
      "Winona",
      "Woodbury HS"
    ].freeze

    def self.extract_team_name(text)
      return nil if text.blank?
      
      # Normalize spacing for comparison
      normalized_text = text.gsub(/\s+/, ' ').strip
      
      # Try exact matching first (most reliable)
      exact_match = find_exact_team_match(normalized_text)
      return exact_match if exact_match
      
      # Try fuzzy matching for common PDF extraction artifacts
      fuzzy_match = find_fuzzy_team_match(normalized_text)
      return fuzzy_match if fuzzy_match
      
      # Try extracting from corrupted format (name + team concatenated)
      corrupted_match = extract_from_corrupted_format(normalized_text)
      return corrupted_match if corrupted_match
      
      # No valid team found
      nil
    end

    private

    def self.find_exact_team_match(text)
      # Look for exact team name matches in the text
      VALID_TEAMS.each do |team|
        if text.include?(team)
          return team
        end
      end
      nil
    end

    def self.find_fuzzy_team_match(text)
      # Handle common PDF extraction artifacts
      VALID_TEAMS.each do |team|
        # Create fuzzy patterns for common artifacts
        fuzzy_patterns = generate_fuzzy_patterns(team)
        
        fuzzy_patterns.each do |pattern|
          if text.match?(pattern)
            return team
          end
        end
      end
      nil
    end

    def self.generate_fuzzy_patterns(team)
      patterns = []
      
      # Original team with flexible spacing
      flexible_spacing = team.gsub(/\s+/, '\s+')
      patterns << /#{Regexp.escape(flexible_spacing)}/i
      
      # Common PDF artifacts
      if team.include?('HS')
        # "Park HS" might become "ParHS", "Park H S", etc.
        artifact_version = team.gsub(/\s+HS/, 'HS').gsub(/\s+/, '\s*')
        patterns << /#{Regexp.escape(artifact_version)}/i
        
        # "North HS" might become "NhrHS", "NorthHS", etc.
        if team.include?('North')
          north_artifact = team.gsub('North HS', 'NhrHS').gsub(/\s+/, '\s*')
          patterns << /#{Regexp.escape(north_artifact)}/i
        end
        
        # "South HS" might become "SohHS", "SouthHS", etc.
        if team.include?('South')
          south_artifact = team.gsub('South HS', 'SohHS').gsub(/\s+/, '\s*')
          patterns << /#{Regexp.escape(south_artifact)}/i
        end
      end
      
      # Specific team variations
      case team
      when 'Champlin Park HS'
        patterns << /Champlin\s*Park?.*HS/i
        patterns << /Champlin\s*ParHS/i
        patterns << /Champlin\s*Park\s*S/i
        patterns << /Champlin\s*ParkHS/i
      when 'Lakeville North HS'
        patterns << /Lakeville\s*N[or]*th.*HS/i
        patterns << /Lakeville\s*NhrHS/i
        patterns << /Lakeville\s*NorthHS/i
      when 'Lakeville South HS'
        patterns << /Lakeville\s*S[ou]*th.*HS/i
        patterns << /Lakeville\s*SohHS/i
        patterns << /Lakeville\s*SouthHS/i
      when 'St Michael / Albertville'
        patterns << /St\.?\s*Michael\s*\/\s*Albertville/i
        patterns << /St\.?\s*Michael\/Albertville/i
        patterns << /StMichael\/Albertville/i
      when 'Hermantown-Proctor'
        patterns << /Hermantown-?\s*Proctor/i
        patterns << /Hermantown\s*-\s*Proctor/i
      end
      
      # Handle "Hutchinson Tigers" variations
      if team == 'Hutchinson Tigers'
        patterns << /Hutchinson\s*T[ige]*rs?/i
        patterns << /Hutchinson\s*gers/i
        patterns << /Hutchinson\s*Tirs/i
      end
      
      # Handle "Stillwater Mountain Bike" typos
      if team == 'Stillwater Mountain Bike'
        patterns << /Stillwater\s*M[ou]*ntain\s*Bike/i
        patterns << /Stillwater\s*Montain\s*Bike/i
      end
      
      patterns
    end

    def self.extract_from_corrupted_format(text)
      # Handle "NAME FRAGMENT    TEAM NAME" format with multiple spaces
      if text.match?(/^[A-Z]{2,}\s+[A-Z]+.*\s{3,}\w+/)
        parts = text.split(/\s{3,}/)
        
        # Check each part (starting from the end) against valid teams
        parts.reverse.each do |part|
          part = part.strip
          next if part.length < 3
          
          # Try exact match first
          exact_match = find_exact_team_match(part)
          return exact_match if exact_match
          
          # Try fuzzy match
          fuzzy_match = find_fuzzy_team_match(part)
          return fuzzy_match if fuzzy_match
        end
      end
      
      nil
    end
  end
end