class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  # tehty moduuli tiedostoon rating_average.rb
  #def average_rating
  #  self.ratings.average(:score)
  #end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

end
