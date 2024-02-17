# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

url = "https://api.pokemontcg.io/v2/cards/"

cards = JSON.parse(open(url).read)
cards.each do |card|
  Card.create(
    name: card["name"],
    image_url: card["images"]["small"],
    rarity: card["rarity"],
    price: card["tcgplayer"]["prices"]["holofoil"]["market"]
  )

end
"Completed"
