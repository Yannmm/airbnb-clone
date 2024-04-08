class ReviewsController < ApplicationController
  def show_more
    @review = Review.find(params[:id])
  end

  def new
    @reservation = Reservation.find(params[:reservation_id])
  end

  def create

  end

  def index
  end

  private
  def review_params 
    params.permit(
      :reservation_id, 
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
