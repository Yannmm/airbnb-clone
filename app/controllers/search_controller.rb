class SearchController < ApplicationController
    def index 
        @map_api_key = ENV["GOOGLE_MAP_API_KEY"]
        if empty_params?
            redirect_to root_path
            return
        end
        
        @properties = Property.all

        if search_params[:country_code].present? 
            @properties = @properties.where(country_code: search_params[:country_code])
        end

        if search_params[:checkin_date].present? && search_params[:checkout_date].present?
            @properties = @properties.unreserved(search_params[:checkin_date], search_params[:checkout_date])
        end
    end

    private 
    def empty_params?
        search_params[:country_code].blank? && search_params[:checkin_date].blank? && search_params[:checkout_date].blank?
    end

    def search_params
        params.permit(:country_code, :checkin_date, :checkout_date)
    end
end