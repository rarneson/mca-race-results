module ApplicationHelper
  def time_from_ms(milliseconds)
    return '00:00.0' if milliseconds.nil? || milliseconds == 0
    
    total_seconds = milliseconds / 1000.0
    minutes = (total_seconds / 60).floor
    seconds = (total_seconds % 60).floor
    ms = (milliseconds % 1000) / 100
    
    "%d:%02d.%d" % [minutes, seconds, ms]
  end
end
