class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :beers, -> { uniq }, through: :rating
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, -> { uniq }, through: :membership
  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }

  validates :password, format: { with: /.*\d.*[A-Z]|[A-Z].*\d.*/ }, length: {minimum: 4}

  def to_s
    self.username
  end
end