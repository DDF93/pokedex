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

  def rarity_class(rarity)
    case rarity
    when "Common"
      "rarity-common"
    when "Uncommon"
      "rarity-uncommon"
    when "Rare", "Double Rare", "Rare ACE", "Rare BREAK", "Rare Holo", "Rare Holo EX", "Rare Holo GX", "Rare Holo LV.X", "Rare Holo Star", "Rare Holo V", "Rare Holo VMAX", "Rare Holo VSTAR", "Rare Prime", "Rare Prism Star", "Rare Ultra"
      "rarity-rare"
    when "Hyper Rare", "Rare Rainbow", "Rare Secret", "Rare Shining", "Rare Shiny", "Rare Shiny GX", "Shiny Rare", "Shiny Ultra Rare", "Ultra Rare"
      "rarity-hyper-rare"
    when "Promo", "Amazing Rare", "Classic Collection", "Illustration Rare", "LEGEND", "Radiant Rare", "Special Illustration Rare", "Trainer Gallery Rare Holo"
      "rarity-special"
    else
      "rarity-common"
    end
  end
end
