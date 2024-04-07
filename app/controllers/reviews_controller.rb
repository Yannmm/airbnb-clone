class ReviewsController < ApplicationController
  def show_more
    @review = Review.find(params[:id])
  end

  def new
    @reservation = Reservation.find(params[:reservation_id])
  end

  def index
  end

  def create
  end

end
