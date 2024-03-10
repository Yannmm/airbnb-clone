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

    has_rich_text :description


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

    def available_dates
        next_reservation = reservations.upcoming_reservations.first
        current_reservation = reservations.current_reservations.first

        
        if next_reservation.nil? && current_reservation.nil?
            # Next -> nil, current -> nil
            # TODO: what is this `..`?
            Date.tomorrow..Date.tomorrow + 30.days
        elsif !next_reservation.nil? && current_reservation.nil?
            # Next -> available, current -> nil
            Date.tomorrow..next_reservation.checkin_date
        elsif next_reservation.nil? && !current_reservation.nil?
            # Next -> nil, current -> available
            current_reservation.checkout_date..current_reservation.checkout_date + 30.days
        else
            # Next -> available, current -> available
            current_reservation.checkout_date..next_reservation.checkin_date
        end

        

        

        
    end
end