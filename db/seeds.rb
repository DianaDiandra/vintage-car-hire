# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Cleaning up database..."
Review.destroy_all
Booking.destroy_all
Car.destroy_all
User.destroy_all
puts "Cleared all users and cars."

# Create sample user
user = User.create!(
  email: "test@example.com",
  password: "password"
)

require 'open-uri'

cars = [
  {
    brand: "Vintage Mustang",
    address: "SW3 5UU, London",
    description: <<~DESC,
    Experience the raw power of American automotive history with this meticulously maintained 1969 Ford Mustang Boss 302. \n\n
    - 5.0L V8 engine producing 450HP with original 4-speed manual transmission
    - Classic Wimbledon White exterior with black racing stripes
    - Modern upgrades include power steering and Bluetooth-enabled retro-style radio
    - Exempt from ULEZ charges under historic vehicle classification
    - Includes classic car insurance coverage up to £100,000

    Feel the thrill of authentic muscle car performance while cruising through London in style. This collectible piece of automotive history comes with a full service record and recent mechanical overhaul. Perfect for weddings, photo shoots, or reliving the golden era of American motoring.
    DESC
    price: 450.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747760698/classic-mustang-blue-hero_vwd8uj.jpg",
    filename: "mustang.jpg"
  },
  {
    brand: "Vintage Porsche",
    address: "SW3 5UU, London",
    description: <<~DESC,
    Own the road in this iconic 1973 Porsche 911 Carrera RS 2.7. \n\n
    - 2.7L air-cooled flat-six engine with 210HP
    - Original Grand Prix White exterior with classic Fuchs wheels
    - Recently restored interior with period-correct houndstooth seats
    - Includes Porsche Classic Certificate of Authenticity
    - Modern safety upgrades: 3-point seatbelts and LED driving lights

    Experience the pure analog driving experience that made Porsche legendary. This lightweight sports car offers unparalleled mechanical feedback and handling precision. Comes with complimentary access to specialist maintenance facilities during your rental period.
    DESC
    price: 600.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747755712/classic-vintage-car_jz2ohk.jpg",
    filename: "porsche.jpg"
  },
  {
    brand: "Rolls Royce Phantom",
    address: "M1 1AD, Manchester",
    description: <<~DESC,
    Travel in ultimate luxury with this 1965 Rolls-Royce Phantom V. \n\n
    - 6.2L V8 engine with automatic transmission
    - Royal Blue exterior with hand-polished chrome accents
    - Bespoke interior featuring Wilton wool carpets and burr walnut veneers
    - Includes chauffeur service option at £50/hour
    - Complimentary champagne cooler and premium detailing service

    Originally delivered to British aristocracy, this stately limousine offers unparalleled comfort and presence. Perfect for weddings, corporate events, or special occasions. Features modern discreet upgrades including air conditioning and USB charging ports while maintaining classic charm.
    DESC
    price: 1200.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747761501/1200px-2019_Rolls-Royce_Phantom_V12_Automatic_6.75_sfvtpl.jpg",
    filename: "rolls_royce.jpg"
  },
  {
    brand: "Vintage Ferrari",
    address: "B75 7AX, Birmangham",
    description: <<~DESC,
    Command attention in this 1989 Ferrari Testarossa. \n\n
    - 4.9L flat-12 engine producing 390HP
    - Iconic Rosso Corsa red exterior with black leather interior
    - Recent engine rebuild by Ferrari Classiche specialists
    - Includes 300-mile daily allowance with option to extend
    - Track day package available (£500/day extra)

    The ultimate 80s supercar icon, featuring the signature side strakes and pop-up headlights. Comes with GoPro mounting system to capture your drives. Enjoy complimentary valet service and priority access to London's premium car parks.
    DESC
    price: 800.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747832994/2024-ferrari-sf90-xx-stradale-109-654a668fc71a3.jpg_b9dsxm.jpg",
    filename: "ferrari.jpg"
  },
  {
    brand: "Vintage Lamborghini",
    address: "B90 4GT, Birmangham",
    description: <<~DESC,
    Unleash the bull with this 1972 Lamborghini Miura SV. \n\n
    - 3.9L V12 engine producing 385HP
    - Verde Metallizzato green exterior with tan leather interior
    - Fully restored by Lamborghini Polo Storico
    - Includes 24/7 roadside assistance and concierge service
    - Security escort option available for high-profile events

    The car that defined the supercar category, featuring revolutionary mid-engine layout and stunning Gandini design. Complete with original tool kit and factory documentation. Experience automotive history while enjoying modern conveniences like GPS tracking and climate control.
    DESC
    price: 900.00,
    availability: true,
    image_url: "https://res.cloudinary.com/di9w8jptl/image/upload/v1747833178/s2-mobile_a5cjnu.jpg",
    filename: "lamborghini.jpg"
  }
]

cars.each do |car_attrs|
  begin
    file = URI.open(car_attrs[:image_url])
    car = Car.create!(
      brand: car_attrs[:brand],
      description: car_attrs[:description].strip,
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
user = User.find_by(email: "test@example.com")

Car.all.each do |car|
  5.times do
    Review.create!(
      car: car,
      user_id: user.id,
      comment: Faker::Lorem.paragraph(sentence_count: 3),
      rating: rand(4..5)
    )
  end
end

puts "Seed data created successfully!"
