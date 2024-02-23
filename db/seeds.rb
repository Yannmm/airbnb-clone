# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Property.create!({
    name: 'Sample Property',
    description: 'this is very good place to stay',
    headline: 'A mountaineering-view bedroom',
    address_1: 'Hongxing Rd, #305',
    address_2: 'Shuangliu Dist',
    city: 'Chengdu',
    state: 'State',
    country: 'China',
})

property = Property.create!({
    name: 'Good Property',
    description: 'I love this place, man.',
    headline: 'A lake side wooden house',
    address_1: 'Tianfu Airplane, #3333',
    address_2: 'Qingyang Dist',
    city: 'Zhengzhou',
    state: 'State',
    country: 'India',
})
