# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

pictures = []

20.times do 
    pictures << Faker::LoremFlickr.image
end

user = User.create!({
    email: 'test1@gmail.com',
    password: '123456',
    name: Faker::Lorem.unique.sentence(word_count: 2),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
})


downloaded_image = URI.parse(pictures[0]).open
user.picture.attach(io: downloaded_image, filename: user.name)

19.times do |i|
    random_user = User.create!({
    email: "test#{i + 2}@gmail.com",
    password: '123456',
    name: Faker::Lorem.unique.sentence(word_count: 2),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
})

    downloaded_image = URI.parse(pictures[i + 1]).open
    random_user.picture.attach(io: downloaded_image, filename: user.name)
end

description = <<-DESCIRPTION
<div>
<h2  tabindex="-1">About this space</h2>
</div>
<div>
<div>Freshly remodeled Vintage A-Frame. Natural light, trees, with lots of room to enjoy a getaway with the family or friends. Just minutes to Lake Arrowhead, Lake Gregory, Arrowhead Village, and the quaint little town of Blue Jay.<br /><br />The Vintage Modern A-frame is part of the &ldquo;Amor Collective&rdquo;. The Amor Collective gives 10% of profits from your booking to Habitat for Humanity. Habitat for Humanity brings people together to build homes, communities and hope.</div>
</div>
<div>
<div>
<div>
<h3  tabindex="-1">The space</h3>
</div>
Modern, vintage and comfortable. Hang out on the mountain, near the Lakes in style! Spend some time sitting on the deck looking at the stars. You have the place to yourself!</div>
</div>
<div>
<div>
<div>
<h3  tabindex="-1">Guest access</h3>
</div>
The whole house is yours. 4 bedrooms, two bathrooms and a beautiful kitchen and deck for entertaining. We charge an additional $100 for any undisclosed guest.</div>
</div>
<div>
<div>
<div>
<h3  tabindex="-1">Other things to note</h3>
</div>
Our Vintage modern A frame has Central AC and heating and will keep you comfortable! Many places up the mountain do not have Air Conditioning. In the summer months it can be very hot. Ours will keep you cool and comfortable.</div>
</div>
DESCIRPTION

user_ids = User.all.pluck(:id)

10.times do |i|
    property = Property.create!({
        name: Faker::Lorem.unique.sentence(word_count: 3),
        description: description,
        headline: Faker::Lorem.unique.sentence(word_count: 6),
        address_1: Faker::Address.full_address,
        address_2: Faker::Address.street_name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
        bedroom_count: (1..5).to_a.sample,
        guest_count: (2..20).to_a.sample,
        bed_count: (4..10).to_a.sample,
        bathroom_count: (1..4).to_a.sample,
        price: Money::from_amount((50..100).to_a.sample, 'USD'),
    })

    property.images.attach(io: File.open("db/images/property_#{i + 1}.JPG"), filename: "#{property.name}.jpg")
    property.images.attach(io: File.open("db/images/property_#{i + 7}.JPG"), filename: "#{property.name}.jpg")
    property.images.attach(io: File.open("db/images/property_#{i + 2}.JPG"), filename: "#{property.name}.jpg")
    property.images.attach(io: File.open("db/images/property_#{i + 6}.JPG"), filename: "#{property.name}.jpg")
    property.images.attach(io: File.open("db/images/property_#{i + 3}.JPG"), filename: "#{property.name}.jpg")
    
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
            user_id: user_ids.sample
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