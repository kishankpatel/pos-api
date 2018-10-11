json.extract! item, :id, :name, :price, :created_by, :created_at, :updated_at
json.url item_url(item, format: :json)
