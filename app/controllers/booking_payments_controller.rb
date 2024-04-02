class BookingPaymentsController < ApplicationController
    def create
        raise
    end

    private 
    def booking_payments_params
        params.permit(:property_id, :user_id, :checkin_date, :checkout_date, :sercie_fee, :base_fare, :total_before_taxes, :stripeToken)
    end

    def user
        user ||= User.find(booking_payments_params[:user_id])
    end

    def property
        property = Property.find(booking_payments_params[:property_id])
    end

    def stripe_customer 
        customer ||= if (user.stripe_customer_id.nil?)
            c = Stripe::Customer.create(
                name: user.name,
                email: user.email
            )
            user.update(stripe_customer_id: c.id)
            c
        else
            customer ||= Stripe::Customer.retrieve(user.stripe_customer_id)
        end
        
    end
end