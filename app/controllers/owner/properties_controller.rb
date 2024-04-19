module Owner 
    class PropertiesController < ApplicationController 
        before_action :authenticate_user!

        before_action :set_user

        before_action :set_property, only: [:edit, :update, :furnish]
        
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

        # def furnish

        #     amenity_ids = amenities_params[:amenity_ids].select { |e| e != "" }.collect { |e| e.to_i }

        #     # ids = @property.amenity_ids.push(amenity_ids).flatten
        #     # ids.uniq!

        #     @property.amenities.delete_all

        #     amenity_ids.each do |id|
        #         @property.property_amenities.create!(amenity_id: id)
        #     end

        #     redirect_to root_path, notice: "Update amenities of property #{@property.id} successfully."
        # end

        def furnish

            if @property.update(amenities_params)
                redirect_to root_path, notice: "Update amenities of property #{@property.id} successfully."
            else
                render :edit, status: unprocessable_entity
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

        def amenities_params
            params.require(:property).permit(amenity_ids: [])
        end
    end
end