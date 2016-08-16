json.extract! drug, :id, :name, :generic_id, :country_id, :price, :concentration, :unit, :category, :created_at, :updated_at
json.url drug_url(drug, format: :json)