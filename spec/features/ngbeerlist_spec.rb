require 'rails_helper'

describe "ngBeerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    @brewery1 = FactoryGirl.create(:brewery, name:"Koff")
    @brewery2 = FactoryGirl.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js:true do
    visit ngbeerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "beers are in alphabetical order", js:true do
    visit ngbeerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lechte Weisse"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Nikolai"
  end

  it "beers are ordered by the alphabetical order of their styles", js:true do
    visit ngbeerlist_path
    click_link "style"

    expect(find('table').find('tr:nth-child(2)')).to have_content "Rauchbier"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Weizen"
    save_and_open_page
    expect(find('table').find('tr:nth-child(4)')).to have_content "Weizen"
  end

  it "beers are ordered by the alphabetical order of their breweries", js:true do
    visit ngbeerlist_path
    expect(page).to have_content("brewery")
    click_link "brewery"
    expect(find('table').find('tr:nth-child(2)')).to have_content "Koff"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Schlenkerla"
  end
end