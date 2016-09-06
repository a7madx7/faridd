json.extract! patient, :id, :first_name, :last_name, :age, :birth_day, :patient_history, :created_at, :updated_at
json.url patient_url(patient, format: :json)