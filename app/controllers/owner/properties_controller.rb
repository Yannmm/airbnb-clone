module Owner 
    class PropertiesController < ApplicationController 
        before_action :authenticate_user!

        before_action :set_user

        before_action :set_property, only: [:edit, :update]
        
        def index 
            @properties = @user.properties
        end

        def new 
        end

        def edit 
            
        end

        def update 
        end

        private 

        def set_user 
            @user = current_user
        end

        def set_property
            @property = current_user.properties.find(params[:id])
        end
    end
end