module Api 
    class WishlistsController < ApplicationController

        # protect_from_forgery with: null_session

        # Create, Read, Update, Delete

        def create
            # user_id, property_id
            # save to db
            # return response

            wishlist = Wishlist.create(wishlist_params)

            respond_to do |format|
                format.json do
                    render json: wishlist.to_json, status: :ok
                end
            end
        end

        def destroy
            # wishlist_id
            # remove from db
            # return response

            wishlist = Wishlist.find!(params[:id])
            wishlist.destroy

            respond_to do |format|
                format.json do
                    render status: 204
                end
            end
        end

        private 

        def wishlist_params 
            params.permit(:user_id, :property_id)
        end
    end
end