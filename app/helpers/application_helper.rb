module ApplicationHelper
  def time_ago_in_words_from_now(time)
    distance_in_minutes = ((Time.now - time) / 60).round
    case distance_in_minutes
    when 0..1
      "just now"
    when 2..59
      "#{distance_in_minutes} minutes ago"
    when 60..90
      "1 hour ago"
    when 90..1440
      "#{(distance_in_minutes / 60).round} hours ago"
    else
      "#{(distance_in_minutes / 1440).round} days ago"
    end
  end
end
