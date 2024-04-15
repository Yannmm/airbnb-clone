module Owner 
    class ReservationsController < ApplicationController
        before_action :authenticate_user!

        before_action :set_user, only: [:index]

        def index
            @reservations = @user.properties.map(&:reservations).flatten
            # property_ids = @user.properties.pluck(:id)
            # @reservations = @user.reservations.where(property_id: property_ids)
        end

        private 
        def set_user 
            @user = current_user
        end
    end
end