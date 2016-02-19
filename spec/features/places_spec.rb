require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one are returned by the API, they are shown on the page" do
    places = [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Ukko Munkki", id: 2 )]
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(places)
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Ukko Munkki"

  end


  it "if no place is returned by the API, none is shown on the page" do
    places = []
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(places)
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"
    expect(places.size).to eq(0)
  end
end