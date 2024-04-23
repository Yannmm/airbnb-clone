class Property < ApplicationRecord
    validates :name, :description, :address_1, :headline, :city, :state, :country_code, :price, presence: true

    monetize :price_cents, allow_nil: true

    has_many_attached :images

    has_many :reviews, -> { order('updated_at DESC') }, dependent: :destroy

    has_many :wishlists, dependent: :destroy

    # source :users / :user are both OK
    # To use :wishlisted_users, you have to define :wishlists association first
    has_many :wishlisted_users, through: :wishlists, source: :user, dependent: :destroy

    has_many :reservations, -> { order('checkin_date ASC') }, dependent: :destroy

    has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy

    has_many :property_amenities, dependent: :destroy

    has_many :payments, through: :reservations

    # might work 
    # has_many :amenities, through: :property_amenities, dependent: :destroy
    # since :source can be inferred
    has_many :amenities, through: :property_amenities, dependent: :destroy

    belongs_to :user

    has_rich_text :description

    def self.with_reservations_overlap(checkin_date, checkout_date)
        where(id: Reservation.overlapping_reservations(checkin_date, checkout_date).pluck(:property_id))
    end


    def update_average_final_rating
        avg = reviews.average(:final_rating)
        update_attribute(:average_final_rating, avg);
    end

    def average_cleanliness_rating = reviews.average(:cleanliness_rating)&.round(1)

    def average_accuracy_rating = reviews.average(:accuracy_rating)&.round(1)

    def average_checkin_rating = reviews.average(:checkin_rating)&.round(1)

    def average_communication_rating = reviews.average(:communication_rating)&.round(1)

    def average_location_rating = reviews.average(:location_rating)&.round(1)

    def average_value_rating = reviews.average(:value_rating)&.round(1)

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