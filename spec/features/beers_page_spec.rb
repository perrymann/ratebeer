require 'rails_helper'

describe "Beers page" do
  it "shows the error message if beer does not have a name" do
    visit new_beer_path
    click_button("Create Beer")
    expect(page).to have_content "Name can't be blank"
  end

end