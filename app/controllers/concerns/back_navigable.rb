module BackNavigable
  extend ActiveSupport::Concern

  private

  def determine_back_path(default_path:, default_text:)
    referer = request.referer

    if referer.present?
      case referer
      when /\/teams\/([\w-]+)/
        team_slug = referer.match(/\/teams\/([\w-]+)/)[1]
        [ team_path(team_slug), "Back to Team" ]
      when /\/races\/([\w-]+)/
        race_slug = referer.match(/\/races\/([\w-]+)/)[1]
        [ race_path(race_slug), "Back to Race" ]
      when /\/racers/
        [ racers_path, "Back to Racers" ]
      else
        [ default_path, default_text ]
      end
    else
      [ default_path, default_text ]
    end
  end
end
