class PropertiesController < ApplicationController
    def show 
        @property = Property.includes(:reviews).find(params[:id])
        
        @overall_rating_counts = @property.reviews
        .pluck(:final_rating)
        .group_by { |e| e.round }
        .transform_values { |e| e.length.to_f / @property.reviews_count }

        @overall_rating_counts.default = 0

        @blocked_dates = @property.reservations.upcoming_reservations.pluck(:checkin_date, :checkout_date).map { |e| [e.first.strftime('%Y-%m-%d'), (e.last - 1.day).strftime('%Y-%m-%d')] }
    end 
end