module Owner 
    class ReservationsController < ApplicationController
        before_action :authenticate_user!

        before_action :set_user, only: [:index]

        def index
            @reservations = @user.reservations
        end

        private 
        def set_user 
            @user = current_user
        end
    end
end