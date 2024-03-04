class Property < ApplicationRecord
    validates :name, :description, :address_1, :headline, :city, :state, :country, presence: true

    monetize :price_cents, allow_nil: true

    has_many_attached :images

    has_many :reviews, dependent: :destroy

    has_many :wishlists, dependent: :destroy

    # source :users / :user are both OK
    # To use :wishlisted_users, you have to define :wishlists association first
    has_many :wishlisted_users, through: :wishlists, source: :user, dependent: :destroy

    has_many :reservations, dependent: :destroy

    has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy


    def update_average_final_rating
        avg = reviews.average(:final_rating)
        update_attribute(:average_final_rating, avg);
    end

    def wishlisted_by?(user = nil)
        return if user.nil?
        wishlisted_users.include?(user)
    end

    def find_wishlist(user)
        wishlists.find_by(user: user)
    end
end