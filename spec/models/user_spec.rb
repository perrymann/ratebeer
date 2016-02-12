require 'rails_helper'

  describe User, type: :model do
    it "has the username set correctly" do
      user = User.new username:"Pekka"

      expect(user.username).to eq("Pekka")
    end

    it "is not saved without password" do
      user = User.create username:"Pekka"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved with a proper password" do
      expect(user.password).to match(/.*\d.*[A-Z]|[A-Z].*\d.*/)
      expect(user.password_confirmation).to match(/.*\d.*[A-Z]|[A-Z].*\d.*/)
      expect (user.password.length) >= 4
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "with a proper password and two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)
      expect(user.favorite_beer).to eq(best)
    end

    def create_beer_with_rating(user, score)
      beer = FactoryGirl.create :beer
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end

    def create_beers_with_ratings(user, *scores)
      scores.each do |x|
        create_beer_with_rating(user, x)
      end
    end
  end



end