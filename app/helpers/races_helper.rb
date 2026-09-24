module RacesHelper
  MIDDLE_SCHOOL_PREFIXES = %w[6th 7th 8th].freeze

  # Tags a category for the race overview field filters (girls/boys, school level).
  def category_field_tags(category_name)
    name = category_name.to_s

    [
      name.match?(/girls/i) ? "girls" : "boys",
      MIDDLE_SCHOOL_PREFIXES.any? { |prefix| name.start_with?(prefix) } ? "middle_school" : "high_school"
    ]
  end

  # Left-edge stripe that ranks a row in the overview podium.
  def podium_stripe_class(place)
    case place
    when 1 then "border-hud-amber"
    when 2 then "border-hud-ink/30"
    else "border-hud-border"
    end
  end

  def gap_from_leader(ms)
    return "—" if ms.nil?
    return "leader" if ms.zero?
    return "+#{format('%.1f', ms / 1000.0)}" if ms < 1000

    "+#{time_from_ms(ms)}"
  end

  def format_signed_delta(ms)
    return "—" if ms.nil?
    return "0:00.0" if ms.zero?

    sign = ms.negative? ? "-" : "+"
    "#{sign}#{time_from_ms(ms.abs)}"
  end
end
