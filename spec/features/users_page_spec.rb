require 'rails_helper'

describe "User" do
  describe "who has signed up" do
    before :each do
      FactoryGirl.create(:user)
    end

    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'Foobar1')
      click_button('Log in')

      expect(page).to have_content("Welcome back")
      expect(page).to have_content("Pekka")
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'wrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  describe "user who has ratings" do
      let(:user) {FactoryGirl.create :user}
      before :each do
        beer = FactoryGirl.create :beer
        FactoryGirl.create(:rating, beer: beer, user: user)
      end

    it "shows the number of ratings in user's page" do
      visit user_path(user)
      expect(page).to have_content "has 1 rating, with an average of 10.0"
      expect(page).to have_content 'anonymous'
    end

    it "deletes all ratings from database by clicking delete" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'Foobar1')
      click_button('Log in')
      visit user_path(user)
      click_on("delete")
      expect(page).to have_content "This user has not added any ratings!"
    end
  end

  describe "have rated some beers" do
    let(:user) {FactoryGirl.create :user}
    before :each do
      @brewery = FactoryGirl.create :brewery, name:"Sierra Nevada"
      other_brewery = FactoryGirl.create :brewery
      style1 = FactoryGirl.create :style
      style2 = FactoryGirl.create :style2
      create_beers_with_ratings(user, style1, other_brewery, 10, 20, 15)
      create_beers_with_ratings(user, style2, @brewery, 25, 20)
      create_beers_with_ratings(user, style2, other_brewery, 20, 23, 22)
    end

    it "the favorite style is shown at user's page" do
      visit user_path(user)
      expect(page).to have_content 'Favorite style IPA'
    end

    it "the favorite brewery is shown at user's page" do
      visit user_path(user)
      expect(page).to have_content 'Favorite brewery Sierra Nevada'
    end
  end
end
