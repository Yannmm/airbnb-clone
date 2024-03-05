# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!({
    email: 'test1@gmail.com',
    password: '123456'
})

10.times do |i|
    property = Property.create!({
        name: Faker::Lorem.unique.sentence(word_count: 3),
        description: Faker::Lorem.paragraph(sentence_count: 2),
        headline: Faker::Lorem.unique.sentence(word_count: 6),
        address_1: Faker::Address.full_address,
        address_2: Faker::Address.street_name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
        price: Money::from_amount((50..100).to_a.sample, 'USD'),
    })

    property.images.attach(io: File.open("db/images/property_#{i + 1}.JPG"), filename: "#{property.name}.jpg")
    property.images.attach(io: File.open("db/images/property_#{i + 7}.JPG"), filename: "#{property.name}.jpg")
    
    (50..100).to_a.sample.times do 
        Review.create!({ 
            content: Faker::Lorem.paragraph(sentence_count: 10),
            communication_rating: (1..5).to_a.sample,
            accuracy_rating: (1..5).to_a.sample,
            checkin_rating: (1..5).to_a.sample,
            value_rating: (1..5).to_a.sample,
            location_rating: (1..5).to_a.sample,
            cleanliness_rating: (1..5).to_a.sample,
            property: property,
            user: user
        })
    end
    
end


u = User.first


# case 2 
p = Property.second

Reservation.create(user: u, property: p, checkin_date: Date.today - 5.days, checkout_date: Date.today - 2.days)

Reservation.create(user: u, property: p, checkin_date: Date.today + 4.days, checkout_date: Date.today + 9.days)

# case 3

p = Property.third

Reservation.create(user: u, property: p, checkin_date: Date.today - 2.days, checkout_date: Date.today + 4.days)

# case 4

p = Property.fourth

Reservation.create(user: u, property: p, checkin_date: Date.today + 6.days, checkout_date: Date.today + 10.days)

# case 5


p = Property.fifth

Reservation.create(user: u, property: p, checkin_date: Date.today - 2.days, checkout_date: Date.today + 2.days)

Reservation.create(user: u, property: p, checkin_date: Date.today + 6.days, checkout_date: Date.today + 10.days)