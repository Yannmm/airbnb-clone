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

        def create
        end

        def edit 
            
        end

        def update 
            if @property.update(property_params)
                redirect_to root_path, notice: "Update property #{@property.id} successfully."
            else
                flash.now[:alert] = 'Failed to update property.'
                render :edit, status: :unprocessable_entity
            end
        end

        private 

        def set_user 
            @user = current_user
        end

        def set_property
            @property = current_user.properties.find(params[:id])
        end

        def property_params 
            params.require(:property).permit(:name, :headline, :address_1, :address_2, :city, :state, :country_code, :price, :guest_count, :bedroom_count, :bed_count, :bathroom_count)
        end
    end
end