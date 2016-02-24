class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def to_s
    self.name
  end

  def self.bestStyles(n)
    Style.all.sort_by{ |s| -(s.average_rating||0) }.first(n)
  end
end
