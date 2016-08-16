json.extract! company, :id, :name, :drug_id, :country_id, :reputation, :created_at, :updated_at
json.url company_url(company, format: :json)