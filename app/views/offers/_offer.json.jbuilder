json.extract! offer, :id, :drug_id, :user_id, :discount, :expiry, :amount, :created_at, :updated_at
json.url offer_url(offer, format: :json)