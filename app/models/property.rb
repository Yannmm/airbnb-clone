class Property < ApplicationRecord
    validates :name, :description, :address_1, :headline, :city, :state, :country, presence: true

    monetize :price_cents, allow_nil: true

    has_many_attached :images

    has_many :reviews, dependent: :destroy

    def update_average_final_rating
        avg = reviews.average(:final_rating)
        update_attribute(:average_final_rating, avg);
    end
end