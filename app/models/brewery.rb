class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  # tehty moduuli tiedostoon rating_average.rb
  #def average_rating
  #  self.ratings.average(:score)
  #end

end
