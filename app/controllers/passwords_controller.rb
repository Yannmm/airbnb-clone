class PasswordsController < ApplicationController 
    before_action :authenticate_user!

    before_action :set_user, only: [:edit, :update]

    def edit
    end

    def update
        if @user.update_with_password(user_params)
            redirect_to root_path, notice: 'Password updated successfully.'
        else
            # redirect_to edit_password_path, alert: 'Fail to edit Password.'
            render :edit, status: :unprocessable_entity
        end
    end

    private 

    def user_params
        # TODO: how to double check password?
        params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def set_user 
        @user = current_user
    end
end