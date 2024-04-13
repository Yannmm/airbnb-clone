class EmailsController < ApplicationController 
    def edit
    end

    def update
        if current_user.update(user_params)
            redirect_to root_path, notice: 'Email updated successfully.'
        else
            redirect_to root_path, alert: 'Fail to edit email.'
        end
    end

    private 

    def user_params
        params.require(:user).permit(:email)
    end
end