class ProfilesController < ApplicationController 
    before_action :authenticate_user!

    before_action :load_profile, only: [:edit, :update]

    def edit
        
    end

    def update
        if @profile.update(profile_params)
            redirect_to root_path, notice: 'Profile updated successfully.'
        else
            # TODO: why flash does not work?
            redirect_to root_path, alert: 'Fail to edit profile.'
        end
    end

    private

    def load_profile
        @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :country_code, :address_1, :address_2, :city, :state, :zip_code)
    end
end