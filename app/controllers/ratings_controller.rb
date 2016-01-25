
class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index # voidaan jättää pois myös, (renderöi näkymätemplaten /app/views/ratings/index.html) eli samannimisen näkymän
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end