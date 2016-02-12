require 'rails_helper'

  describe "Ratings" do
    before :each do
      user = FactoryGirl.create(:user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, beer: beer, user: user)
    end

    describe "when ratings exist" do
      it "shows the number of ratings" do
        visit ratings_path
        expect(page).to have_content "List of ratings"
        expect(page).to have_content "1 rating in total"
      end
    end


  end