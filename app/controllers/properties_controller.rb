class PropertiesController < ApplicationController
    def show 
        @property = Property.find(params[:id])
        
        @overall_rating_counts = @property.reviews
        .pluck(:final_rating)
        .group_by { |e| e.round }
        .transform_values { |e| e.length.to_f / @property.reviews_count }
    end 
end