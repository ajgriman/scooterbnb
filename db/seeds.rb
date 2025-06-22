# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require "open-uri"

# 1. Wipe existing data
Booking.delete_all
Vehicle.delete_all
User.delete_all

# 2. Create users
owner = User.create!(
  email:    "owner@scooterbnb.com",
  password: "password",
  name:     "Owner Alice"
)

renter = User.create!(
  email:    "renter@scooterbnb.com",
  password: "password",
  name:     "Renter Bob"
)

# 3. Sample image URLs (swap with real URLs later)
placeholder_images = [
  "https://movimentmobilidadeurbana.com.br/wp-content/uploads/2022/12/KY_0195-1-scaled.jpg",
  "https://cdn.awsli.com.br/2500x2500/2299/2299072/produto/144097131/5b0a111f1f.jpg"
]

# 4. Seed owner’s vehicles
vehicles_data = [
  {
    title:          "City Cruiser Scooter",
    description:    "Easy handling for daily commutes.",
    vehicle_type:   "scooter",
    engine_size:    "150cc",
    price_per_day:  2000,
    location:       "San Francisco, CA",
    available_from: Date.today,
    available_to:   Date.today + 10
  },
  {
    title:          "Vintage Roadster",
    description:    "Classic motorcycle vibes.",
    vehicle_type:   "motorcycle",
    engine_size:    "500cc",
    price_per_day:  4500,
    location:       "San Francisco, CA",
    available_from: Date.today + 2,
    available_to:   Date.today + 14
  }
]

vehicles = vehicles_data.map.with_index do |attrs, idx|
  v = owner.vehicles.create!(attrs)
  # attach two placeholder images
  placeholder_images.each do |url|
    v.photos.attach(
      io:       URI.open(url),
      filename: "veh#{idx}-#{File.basename(url)}"
    )
  end
  v
end

# 5. Seed bookings by the renter
# Booking 1: valid booking on first vehicle
Booking.create!(
  start_date:  Date.today + 1,
  end_date:    Date.today + 3,
  user:        renter,
  vehicle:     vehicles.first
)

# Booking 2: overlapping booking on second vehicle to test validation
invalid_booking = Booking.new(
  start_date:  Date.today + 5,
  end_date:    Date.today + 4,  # end before start
  user:        renter,
  vehicle:     vehicles.second
)
puts "Invalid booking errors: #{invalid_booking.tap(&:valid?).errors.full_messages}"

puts "Seeds complete:"
puts "- Users: #{User.count}"
puts "- Vehicles: #{Vehicle.count}"
puts "- Bookings: #{Booking.count} (#{Booking.where(status: 'pending').size} pending)"