json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :count_beers
  json.url brewery_url(brewery, format: :json)
end
