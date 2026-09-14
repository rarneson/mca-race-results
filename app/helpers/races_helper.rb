module RacesHelper
  def format_signed_delta(ms)
    return "—" if ms.nil?
    return "0:00.0" if ms.zero?

    sign = ms.negative? ? "-" : "+"
    "#{sign}#{time_from_ms(ms.abs)}"
  end
end
