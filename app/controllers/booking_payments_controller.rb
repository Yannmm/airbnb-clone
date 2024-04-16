class BookingPaymentsController < ApplicationController
    def create
        property = Property.find(booking_payments_params[:property_id])
        stripe_price = Stripe::Price.create({
            currency: 'usd',
            unit_amount: Money.from_amount(BigDecimal(booking_payments_params[:total_before_taxes])).cents,
            product_data: { name: property.name },
        })

        success_url = url_for(controller: 'booking_payments', action: 'success', only_path: false, booking_params: booking_payments_params.except(:stripeToken))

        stripe_session = Stripe::Checkout::Session.create({
            success_url: success_url,
            line_items: [
              {
                price: stripe_price.id,
                quantity: 1,
              },
            ],
            mode: 'payment',
          })

          redirect_to stripe_session.url, allow_other_host: true, status: 303
    end

    def success
        # Revisiting will this controller will lose booking_payments_params

        # Add reservation
        reservation = Reservation.create!(user_id: success_params[:user_id], property_id: success_params[:property_id], checkin_date: success_params[:checkin_date], checkout_date: success_params[:checkout_date]);

        # Add payment details offline

        payment = Payment.create!(
            reservation_id: reservation.id, 
            base_fare_cents: Money.from_amount(BigDecimal(success_params[:base_fare])).cents, 
            service_fee_cents: Money.from_amount(BigDecimal(success_params[:service_fee])).cents, 
            total_before_taxes_cents: Money.from_amount(BigDecimal(success_params[:total_before_taxes])).cents,
            unit_price_cents: Money.from_amount(BigDecimal(success_params[:unit_price])).cents, 
            )

        # TODO: redirect to all bookings page

        redirect_to root_path
    end


    private 
    def success_params
        params.require(:booking_params)
    end

    def booking_payments_params
        params.permit(:property_id, :user_id, :checkin_date, :checkout_date, :service_fee, :base_fare, :total_before_taxes, :stripeToken, :unit_price)
    end
end