
class PlacesController < ApplicationController
  def index
  end

  def show
    @last = BeermappingApi.places_in(session[:last_search]).find { |place| params[:id] == place.id }
   end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_search] = params[:city]

      render :index
    end
  end
end