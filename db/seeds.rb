# db/seeds.rb
puts "Destroying old records..."
Booking.destroy_all
Vehicle.destroy_all
User.destroy_all

puts "Seeding Users..."
owner = User.create!(
  email: "owner@scooterbnb.com",
  password: "password",
  name: "Scooter Owner",
  bio: "I love scooters!"
)

renter = User.create!(
  email: "renter@scooterbnb.com",
  password: "password",
  name: "Scooter Renter",
  bio: "I enjoy riding scooters!"
)

puts "Attaching user avatars via Active Storage (uploads will go to Cloudinary)..."
owner_avatar_path = Rails.root.join("db", "seeds_images", "owner_avatar.jpeg")
renter_avatar_path = Rails.root.join("db", "seeds_images", "test_avatar.jpg")

owner.avatar.attach(
  io: File.open(owner_avatar_path),
  filename: "owner_avatar.jpeg",
  content_type: "image/jpeg"
)

renter.avatar.attach(
  io: File.open(renter_avatar_path),
  filename: "test_avatar.jpg",
  content_type: "image/jpeg"
)

puts "Seeding Vehicles..."
vehicle = Vehicle.create!(
  title: "Electric Scooter",
  description: "A fun and eco-friendly scooter!",
  vehicle_type: "Electric",
  engine_size: "0cc",
  price_per_day: 25,
  location: "New York City",
  available_from: Date.today,
  available_to: Date.today + 30,
  user: owner
)

vehicle1 = Vehicle.create!(
  title: "Electric Scooter",
  description: "A fun and eco-friendly scooter!",
  vehicle_type: "Electric",
  engine_size: "0cc",
  price_per_day: 25,
  location: "New York City",
  available_from: Date.today,
  available_to: Date.today + 30,
  user: owner
)

puts "Attaching vehicle photos via Active Storage..."
veh_photo1_path = Rails.root.join("db", "seeds_images", "veh0_image1.jpg")
veh_photo2_path = Rails.root.join("db", "seeds_images", "veh0_image2.jpg")

vehicle.photos.attach([
  { io: File.open(veh_photo1_path), filename: "veh0_image1.jpg", content_type: "image/jpeg" },
  { io: File.open(veh_photo2_path), filename: "veh0_image2.jpg", content_type: "image/jpeg" }
])

vehicle1.photos.attach([
  { io: File.open(veh_photo1_path), filename: "veh0_image1.jpg", content_type: "image/jpeg" },
  { io: File.open(veh_photo2_path), filename: "veh0_image2.jpg", content_type: "image/jpeg" }
])

puts "Seeding Bookings..."
Booking.create!(
  start_date: Date.today + 1,
  end_date: Date.today + 5,
  status: "confirmed",
  user: renter,
  vehicle: vehicle
)

puts "Seeding complete."