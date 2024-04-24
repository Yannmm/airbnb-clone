class HomeController < ApplicationController
  def index
    @properties = Property.order(updated_at: :desc)
  end

end
