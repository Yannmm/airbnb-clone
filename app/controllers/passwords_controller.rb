class PasswordsController < ApplicationController 
    def edit
    end

    def update
        if current_user.update(user_params)
            redirect_to root_path, notice: 'Password updated successfully.'
        else
            redirect_to root_path, alert: 'Fail to edit Password.'
        end
    end

    private 

    def user_params
        # TODO: how to double check password?
        params.require(:user).permit(:password)
    end
end