json.extract! answer, :id, :content, :rating, :created_at, :updated_at
json.url answer_url(answer, format: :json)