require 'net/http'
require 'uri'

page = 1
all_cards = []

loop do
  url = URI("https://api.pokemontcg.io/v2/cards?page=#{page}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["XApi-Key"] = "89fe5de6-821b-4d18-8167-fa34bd3f66da" # replace "your_api_key" with your actual API key

  response = http.request(request)
  cards = JSON.parse(response.body)["data"]

  break if cards.empty? # stop if there are no more cards

  all_cards.concat(cards) # add the cards from this page to the total
  puts "page #{page} / 70 added"
  page += 1 # increment the page number for the next iteration

end

all_cards.each do |card|
  card_price = card.dig("tcgplayer", "prices", "holofoil", "market") || rand(1..100)
  Card.create(
    name: card["name"],
    image_url: card["images"]["small"],
    rarity: card["rarity"],
    price: card_price
  )
end
"Completed"
