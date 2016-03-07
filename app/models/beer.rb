class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :users, -> { uniq }, through: :ratings

  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

  def self.bestBeers(n)
    Beer.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
  end

end
