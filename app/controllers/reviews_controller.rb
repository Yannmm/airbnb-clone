class ReviewsController < ApplicationController
  def show_more
    @review = Review.find(params[:id])
  end

  def new
    @reservation = Reservation.find(params[:reservation_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path, notice: "Review added successfully."
    else
      redirect_back fallback_location: root_path, alert: "Failed to add review."
    end
  end

  def index
  end

  private
  def review_params 
    params.permit(
      :property_id,
      :user_id, 
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
