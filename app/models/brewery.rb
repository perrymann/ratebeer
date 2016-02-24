class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active: [nil, false]}

  validates :name, presence: true
  validates :year, numericality: { less_than_or_equal_to: Proc.new { Time.now.year } }

  def self.bestBreweries(n)
    Brewery.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
  end

  def to_s
    self.name
  end
end
