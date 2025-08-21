module ApplicationHelper
  def time_from_ms(milliseconds)
    return '00:00' if milliseconds.nil? || milliseconds == 0
    
    total_seconds = milliseconds / 1000
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    
    "%d:%02d" % [minutes, seconds]
  end
end
