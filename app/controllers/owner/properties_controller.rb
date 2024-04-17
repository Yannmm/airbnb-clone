module Owner 
    class PropertiesController < ApplicationController 
        before_action :authenticate_user!

        before_action :set_user

        before_action :set_property, only: [:edit, :update, :update_amenities]
        
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

        def update_amenities
            amenity_ids = amenities_params[:property].select { |k, v| v.to_i > 0 }.to_h.collect { |k, v| k.to_i }
            ids = @property.amenity_ids.push(amenity_ids).flatten.uniq!

            @property.amenities.delete_all

            ids.each do |id|
                @property.property_amenities.create(amenity_id: id)
            end


            


            redirect_to root_path, notice: "Update amenities of property #{@property.id} successfully."
        end

        private 

        def set_user 
            @user = current_user
        end

        def set_property
            @property = current_user.properties.find(params[:id])
            @amenity_ids = @property.amenity_ids

        end

        def property_params 
            params.require(:property).permit(:name, :headline, :address_1, :address_2, :city, :state, :country_code, :price, :guest_count, :bedroom_count, :bed_count, :bathroom_count)
        end

        def amenities_params
            params.permit(property: {})
        end
    end
end