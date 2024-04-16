class BookingsController < ApplicationController

    before_action :authenticate_user!

    SERVICE_FEE = 0.18

    def new 

        @property = Property.find(booking_params[:property_id])


        # number of nights
        @checkin_date = Date.parse(booking_params[:checkin_date])
        @checkout_date = Date.parse(booking_params[:checkout_date])

        @night_count = (@checkout_date - @checkin_date).to_i

        # base fare         
        @base_fare = @night_count * @property.price;

        # service fee        
        @service_fee = @base_fare * SERVICE_FEE;

        # total amount
        @total_before_taxes = @base_fare + @service_fee 

        @unit_price = @property.price
    end

    private 

    def booking_params 
        params.permit(:checkin_date, :checkout_date, :property_id)
    end
end