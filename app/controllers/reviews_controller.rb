class ReviewsController < ApplicationController
  def show_more
    @review = Review.find(params[:id])
  end
end
