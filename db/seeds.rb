# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'faker'

puts "Cleaning up database..."
Review.destroy_all
User.destroy_all
Car.destroy_all
puts "Cleared all users and cars."

# Create a sample user
user = User.create!(
  email: "test@example.com",
  password: "password"
)

require 'open-uri'

cars = [
  {
    brand: "Vintage Mustang",
    description: "Classic American muscle car.",
    price: 45000.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747760698/classic-mustang-blue-hero_vwd8uj.jpg",
    filename: "mustang.jpg"
  },
  {
    brand: "Vintage Porsche",
    description: "Classic German sports car.",
    price: 60000.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747755712/classic-vintage-car_jz2ohk.jpg",
    filename: "porsche.jpg"
  },
  {
    brand: "Rolls Royce Phantom",
    description: "Elegant luxury vintage car.",
    price: 120000.00,
    availability: false,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747761501/1200px-2019_Rolls-Royce_Phantom_V12_Automatic_6.75_sfvtpl.jpg",
    filename: "rolls_royce.jpg"
  }
]

cars.each do |car_attrs|
  begin
    file = URI.open(car_attrs[:image_url])
    car = Car.create!(
      brand: car_attrs[:brand],
      description: car_attrs[:description],
      price: car_attrs[:price],
      availability: car_attrs[:availability],
      user: user
    )
    car.image.attach(io: file, filename: car_attrs[:filename], content_type: "image/jpeg")
    puts "Successfully added #{car.brand} with Cloudinary image."
    file.close
  rescue => e
    puts "Failed to add #{car_attrs[:brand]}: #{e.message}"
  end
end

puts "Creating reviews..."

# Car.all.each do |car|
#   rand(2..5).times do
#     Review.create!(
#       car: car,
#       comment: Faker::Lorem.sentence(word_count: 8),
#       rating: rand(3..5)
#     )
#   end
# end
