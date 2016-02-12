require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "creates and saves a beer if it has name and style" do
    beer = Beer.create name:"Bisse", style:"Pale ale"
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "does not create a beer if it does not have a name" do
    beer = Beer.create style:"Pale ale"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "does not create a beer if it does not have a style" do
    beer = Beer.create name:"Bisse"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
