
class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @best_beers = Beer.bestBeers(3)
    @best_breweries = Brewery.bestBreweries(3)
    @best_styles = Style.bestStyles(3)
    @best_users = User.bestUsers(3)
    render :index
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    expire_fragment('ratingslist')
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
    redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    expire_fragment('ratingslist')
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end