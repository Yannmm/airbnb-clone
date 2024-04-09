amenity_data = [
  {name: 'Air conditioning', icon: "amenity_icons/air_conditioning.svg"},
  {name: 'Balcony', icon: "amenity_icons/balcony.svg"},
  {name: 'Bed linen', icon: "amenity_icons/bed_linen.svg"},
  {name: 'Board games', icon: "amenity_icons/board_games.svg"},
  {name: 'Carbon monoxide alarm', icon: "amenity_icons/carbon_monoxide_alarm.svg"},
  {name: 'Coffee maker', icon: "amenity_icons/coffee_maker.svg"},
  {name: 'Cooker', icon: "amenity_icons/cooker.svg"},
  {name: 'Cooking basics', icon: "amenity_icons/cooking_basics.svg", description: 'Pots and pans, oil, salt and pepper'},
  {name: 'Cot', icon: "amenity_icons/cot.svg"},
  {name: 'Dedicated workspace', icon: "amenity_icons/dedicated_workspace.svg"},
  {name: 'Dining table', icon: "amenity_icons/dining_table.svg"},
  {name: 'Dishes and cutlery', icon: "amenity_icons/dishes_and_cutlery.svg", description: 'Bowls, chopsticks, plates, cups, etc.'},
  {name: 'Dishwasher', icon: "amenity_icons/dishwasher.svg"},
  {name: 'Dryer', icon: "amenity_icons/dryer.svg"},
  {name: 'Esssentials', icon: "amenity_icons/essentials.svg", description: 'Towels, bed sheets, soap and toilet paper'},
  {name: 'Fire extinguisher', icon: "amenity_icons/fire_extinguisher.svg"},
  {name: 'First aid kit', icon: "amenity_icons/first_aid_kit.svg"},
  {name: 'Free parking', icon: "amenity_icons/free_parking.svg"},
  {name: 'fridge', icon: "amenity_icons/fridge.svg"},
  {name: 'Garden', icon: "amenity_icons/garden.svg", description: 'An open space on the property usually covered in grass'},
  {name: 'Hair dryer', icon: "amenity_icons/hair_dryer.svg"},
  {name: 'Hangers', icon: "amenity_icons/hangers.svg"},
  {name: 'Heating', icon: "amenity_icons/heating.svg"},
  {name: 'Hot tub', icon: "amenity_icons/hot_tub.svg"},
  {name: 'Hot water', icon: "amenity_icons/hot_water.svg"},
  {name: 'Iron', icon: "amenity_icons/iron.svg"},
  {name: 'Kitchen', icon: "amenity_icons/kitchen.svg", description: 'Space where guests can cook their own meals'},
  {name: 'Lockbox', icon: "amenity_icons/lockbox.svg"},
  {name: 'Microwave', icon: "amenity_icons/microwave.svg"},
  {name: 'Mountain view', icon: "amenity_icons/mountain_view.svg"},
  {name: 'Oven', icon: "amenity_icons/oven.svg"},
  {name: 'Pool table', icon: "amenity_icons/pool_table.svg"},
  {name: 'Private entrance', icon: "amenity_icons/private_entrance.svg", description: 'Separate street or building entrance'},
  {name: 'Private pool', icon: "amenity_icons/private_pool.svg" },
  {name: 'Shampoo', icon: "amenity_icons/shampoo.svg"},
  {name: 'Smoke alarm', icon: "amenity_icons/smoke_alarm.svg"},
  {name: 'TV', icon: "amenity_icons/tv.svg"},
  {name: 'Washing machine', icon: "amenity_icons/washing_machine.svg"},
  {name: 'Wifi', icon: "amenity_icons/wifi.svg"},
]

amenity_data.each do |data|
    amenity = Amenity.create!(name: data[:name], description: data[:description], icon: data[:icon])
end

pictures = []

20.times do 
    pictures << Faker::LoremFlickr.image
end

user = User.create!({
    email: 'test1@gmail.com',
    password: '123456',

})

profile = Profile.create!(

    user_id: user.id,
    name: Faker::Lorem.unique.sentence(word_count: 2),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,

)

downloaded_image = URI.parse(pictures[0]).open
profile.picture.attach(io: downloaded_image, filename: profile.name)

19.times do |i|
    random_user = User.create!({
    email: "test#{i + 2}@gmail.com",
    password: '123456',
})

profile = Profile.create!(
 {
    user_id: random_user.id,
    name: Faker::Lorem.unique.sentence(word_count: 2),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
 }
)

    downloaded_image = URI.parse(pictures[i + 1]).open
    profile.picture.attach(io: downloaded_image, filename: profile.name)
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


    all_amenities = Amenity.all
    amenity_set = Set.new
    ((10...(all_amenities.count)).to_a.sample).times do 
        a = all_amenities.sample
        unless amenity_set.include?(a.id)
            property.amenities << a 
            amenity_set << a.id
        end
    end
    
    # (50..100).to_a.sample.times do 
    #     Review.create!({ 
    #         content: Faker::Lorem.paragraph(sentence_count: 10),
    #         communication_rating: (1..5).to_a.sample,
    #         accuracy_rating: (1..5).to_a.sample,
    #         checkin_rating: (1..5).to_a.sample,
    #         value_rating: (1..5).to_a.sample,
    #         location_rating: (1..5).to_a.sample,
    #         cleanliness_rating: (1..5).to_a.sample,
    #         property: property,
    #         user_id: user_ids.sample
    #     })
    # end
    
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