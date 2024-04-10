class ReviewsController < ApplicationController
  before_action :set_reservation, only: [:new, :create]

  def show_more
    @review = Review.find(params[:id])
  end

  def new
    
  end

  def create
    #  @review = Review.new(review_params.merge(user_id: current_user.id, property_id: reservation.property_id))
    @review = current_user.reviews.build(**review_params, property_id: @reservation.property_id, reservation_id: @reservation.id)
    if @review.save
      redirect_to root_path, notice: "Review added successfully."
    else
      redirect_back fallback_location: root_path, alert: "Failed to add review."
    end
  end

  def index
  end

  private
  def set_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end

  def review_params 
    params.permit(
      :content, 
      :cleanliness_rating, 
      :accuracy_rating, 
      :checkin_rating, 
      :communication_rating, 
      :location_rating, 
      :value_rating
    )
  end

end
