class PasswordsController < ApplicationController 
    before_action :authenticate_user!

    before_action :set_user, only: [:edit, :update]

    def edit
    end

    def update
        if @user.update_with_password(user_params)
            redirect_to root_path, notice: 'Password updated successfully.'
        else
            flash.now[:alert] = 'Oops, something wrong happened.'
            render :edit, status: :unprocessable_entity
        end
    end

    private 

    def user_params
        params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def set_user 
        @user = current_user
    end
end