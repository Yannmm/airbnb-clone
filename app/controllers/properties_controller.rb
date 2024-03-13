class PropertiesController < ApplicationController
    def show 
        @property = Property.includes(:reviews).find(params[:id])
        
        @overall_rating_counts = @property.reviews
        .pluck(:final_rating)
        .group_by { |e| e.round }
        .transform_values { |e| e.length.to_f / @property.reviews_count }

        @overall_rating_counts.default = 0
    end 
end