module ApplicationHelper
  include Pagy::Frontend

  def pagy_daisyui_nav(pagy)
    html = +'<div class="join">'

    if pagy.prev
      html << link_to("«", pagy_url_for(pagy, pagy.prev), class: "join-item btn btn-sm")
    else
      html << '<button class="join-item btn btn-sm btn-disabled">«</button>'
    end

    pagy.series.each do |item|
      case item
      when Integer
        if item == pagy.page
          html << %(<button class="join-item btn btn-sm btn-active">#{item}</button>)
        else
          html << link_to(item, pagy_url_for(pagy, item), class: "join-item btn btn-sm")
        end
      when "gap"
        html << '<button class="join-item btn btn-sm btn-disabled">...</button>'
      end
    end

    if pagy.next
      html << link_to("»", pagy_url_for(pagy, pagy.next), class: "join-item btn btn-sm")
    else
      html << '<button class="join-item btn btn-sm btn-disabled">»</button>'
    end

    html << "</div>"
    html.html_safe
  end

  def time_from_ms(milliseconds)
    return "00:00.0" if milliseconds.nil? || milliseconds == 0

    total_seconds = milliseconds / 1000.0
    minutes = (total_seconds / 60).floor
    seconds = (total_seconds % 60).floor
    ms = (milliseconds % 1000) / 100

    "%d:%02d.%d" % [ minutes, seconds, ms ]
  end

  def category_css_class(category_name)
    return "bg-gray-100 text-gray-700" if category_name.blank?

    case category_name
    when /6th Grade/
      "bg-green-100 text-green-700"
    when /7th Grade/
      "bg-blue-100 text-blue-700"
    when /8th Grade/
      "bg-purple-100 text-purple-700"
    when /Freshman/
      "bg-yellow-100 text-yellow-700"
    when /JV2/
      "bg-orange-100 text-orange-700"
    when /JV3/
      "bg-red-100 text-red-700"
    when /Varsity/
      "bg-indigo-100 text-indigo-700"
    else
      "bg-gray-100 text-gray-700"
    end
  end

  def place_css_class(place)
    return "" unless place

    if place == 1
      "text-amber-600 font-bold"
    elsif place <= 3
      "text-orange-600 font-bold"
    else
      ""
    end
  end

  def status_css_class(status)
    return "bg-gray-100 text-gray-800" if status.blank?

    case status.upcase
    when "DNF"
      "bg-red-100 text-red-800"
    when "DNS"
      "bg-yellow-100 text-yellow-800"
    when "DSQ"
      "bg-purple-100 text-purple-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end
end
