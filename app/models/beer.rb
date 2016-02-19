class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :users, -> { uniq }, through: :ratings

  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

end
