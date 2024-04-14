module Owner 
    class PropertiesController < ApplicationController 
        before_action :authenticate_user!

        before_action :set_user
        
        def index 
            @properties = @user.properties
        end

        def new 
        end

        private 

        def set_user 
            @user = current_user
        end


    end
end