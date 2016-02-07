class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  def club
    beer_club = BeerClub.find_by id: beer_club_id
    "#{beer_club.to_s}"
  end

  def member
    User.find_by id: user_id
  end
end
