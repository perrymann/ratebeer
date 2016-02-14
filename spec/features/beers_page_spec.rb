require 'rails_helper'

describe "Beers page" do

  describe "when user is signed up" do
    before :each do
      FactoryGirl.create(:user)
    end

    it "shows the error message if beer does not have a name" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'Foobar1')
      click_button('Log in')
      visit new_beer_path
      click_button("Create Beer")
      expect(page).to have_content "Name can't be blank"
    end
  end
end