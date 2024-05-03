# module Properties
class Properties::WishlistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_property_and_user, only: :update

    def update 
        if @property.wishlisted_by?(@user)
            @property.unwishlist(@user)
        else
            @property.wishlist(@user)
        end

        render partial: "properties/wishlists/item", locals: { property: @property }
    end

    private 
    def set_property_and_user
        @property = Property.find(params[:property_id])
        @user = current_user
    end
end

# end