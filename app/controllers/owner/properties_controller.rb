module Owner 
    class PropertiesController < ApplicationController 
        before_action :authenticate_user!

        before_action :set_user

        before_action :set_property, only: [:edit, :update, :furnish, :detach, :attach, :destroy]
        
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

        def destroy
            if @property.destroy 
                redirect_to owner_properties_path, notice: 'Delete property successfully.'
            else 
                render :edit, status: unprocessable_entity
            end
        end

        def furnish
            if @property.update(amenities_params)
                redirect_to edit_owner_property_path, notice: "Update amenities of property #{@property.id} successfully."
            else
                render :edit, status: unprocessable_entity
            end
        end

        def detach
            image = @property.images.find(image_params[:image_id])
            if image.purge
                redirect_to edit_owner_property_path, notice: "Remove image of property #{@property.id} successfully."
            else
                render :edit, status: unprocessable_entity
            end
        end

        def attach
            if params[:property][:images].present?
                @property.images.attach(params[:property][:images])

                redirect_to edit_owner_property_path, notice: 'Image(s) uploaded.'
            else
                redirect_to edit_owner_property_path, alert: 'No images to upload.'
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

        def image_params
            params.permit(:image_id)
        end
    end
end