require 'net/http'
require 'uri'

page = 1
all_cards = []

loop do
  url = URI("https://api.pokemontcg.io/v2/cards?page=#{page}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["XApi-Key"] = "89fe5de6-821b-4d18-8167-fa34bd3f66da"

  response = http.request(request)
  cards = JSON.parse(response.body)["data"]

  break if cards.empty? # Way to know if we are done (empty page)

  all_cards.concat(cards) # add the cards from this page the array of cards
  puts "page #{page} / 70 added"
  page += 1 # increment the page number for the next iteration
end

all_cards.each do |card|
  card_price = card.dig("cardmarket", "prices", "averageSellPrice") || rand(1..20)
  Card.create(
    name: card["name"],
    image_url: card["images"]["small"],
    rarity: card["rarity"],
    price: card_price
  )
end
puts "Cards Completed"

puts "Creating Users"

200.times do
  User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
    username: Faker::Internet.username
  })
end

puts "Users Completed"
puts "Creating Listings"

# Grab all cards and users
cards = Card.all
users = User.all
listing_number = 1
# Define the conditions to randomise from so we have the prices can be different based on state of card
conditions = ['Mint', 'Like New', 'Used', 'Poor']

# Create listings for each card
cards.each do |card|
  # Generate between 0 and 3 listings for each card
  rand(4).times do
    # Random user
    user = users.sample

    # Base the price on the condition of the card using multipliers
    condition_multiplier = case conditions.sample
                           when 'Mint'
                             1.0
                           when 'Like New'
                             0.8
                           when 'Used'
                             0.5
                           when 'Poor'
                             0.2
                           else
                             0.0
                           end

    listing_price = (card.price * condition_multiplier).round(2)

    # Create a listing with the decided factors
    Listing.create(
      user: user,
      card: card,
      condition: conditions.sample,
      price: listing_price
    )
  end
  # Lets us know its running!!
  puts "Listings for card #{listing_number} created"
  listing_number += 1
end
