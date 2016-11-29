json.extract! listing, :id, :name, :description, :category, :price, :created_at, :updated_at
json.url listing_url(listing, format: :json)