class Amenity < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    validates :icon, presence: true

    has_many :property_amenities, dependent: :destroy
    
    # might work 
    # has_many :properties, through: :property_amenities, dependent: :destroy
    # since :source can be inferred
    has_many :properties, through: :property_amenities, dependent: :destroy
end
