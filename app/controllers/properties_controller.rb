class PropertiesController < ApplicationController

    before_action :set_property, only: [:description, :share, :ensemble, :repertoire]

    before_action :set_property_with_reviews, only: [:show, :repertoire]

    def show 
        @blocked_dates = @property.reservations.upcoming_reservations.pluck(:checkin_date, :checkout_date).map { |e| [e.first.strftime('%Y-%m-%d'), (e.last - 1.day).strftime('%Y-%m-%d')] }
    end 

    def description
    end

    def share
    end

    def ensemble
        @amenities = @property.amenities
    end

    def repertoire 
    end

    private 

    def set_property_with_reviews 
        @property = Property.includes(:reviews).find(params[:id])
        @overall_rating_counts = @property.reviews
        .pluck(:final_rating)
        .group_by { |e| e.round }
        .transform_values { |e| e.length.to_f / @property.reviews_count }

        @overall_rating_counts.default = 0
    end

    def set_property 
        @property = Property.find(params[:id])
    end
end