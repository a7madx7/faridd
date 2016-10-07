# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DRUG_DB_FILE = "#{Rails.root}/db/db.json"
COUNTRIES_DB_FILE = "#{Rails.root}/db/countries.json"

def read(file)
  File.readlines(file).each do |d|
    decoded_json_line = ActiveSupport::JSON.decode(d)
    begin
      yield(decoded_json_line) if block_given?
      next
    rescue
      # ignored
    end
  end
end
def form_seed
  ['amp', 'vial',
   'cap', 'tab', 'enteric coated tab', 'powder',
   'susp', 'emulsion', 'spray', 'syrup',
   'drops', 'ear drops', 'eye drops',
   'cream', 'ointment', 'gel', 'eye(ointment-gel)',
   'mouth wash'].each do |df|
      Form.create(name: df)
    end
end
def country_seed
    c = File.read(COUNTRIES_DB_FILE)
    country = ActiveSupport::JSON.decode(c)
    country.each { |k, v| Country.create(code: k.upcase, name: v) }
end
def companies_seed
  read(DRUG_DB_FILE) do |d|
    Company.first_or_create!(name: d['company'], reputation: 3, country_id: 70)
  end
end
def categories_seed
  read(DRUG_DB_FILE) do |d|
    Category.create!(name: d['category'].downcase)
  end
end
def drug_seed
 read(DRUG_DB_FILE) do |d|
   Drug.where(name: d['name'].downcase).first_or_create do |h|
     h.name = d['name']

     h.country = Country.where(code: 'eg').first_or_create
     h.company = Company.where(name: d['company']).first_or_create
     h.categories << Category.where(name: d['category'].downcase).first_or_create
     h.form = Form.where('name like ?', "%#{d['form']}%").first_or_create
     h.contents = d['contents']
     h.price = d['price'].to_s.to_f

     d['active_ingredient'].each { |ac|  h.generics << Generic.where(name: ac).first_or_create }
   end
 end
end

def user_seed
  User.first_or_create(username: 'a7madx7', password: '123testing', password_confirmation: '123testing', email: 'ahmad.hamdi.emara@gmail.com',
                       country_id: 70, first_name: 'Ahmad', last_name: 'Emara', profession: 'Pharmacist', gender: 'male')
  User.first_or_create(username: 'aug', password: '123testing', password_confirmation: '123testing', email: 'aug@gmail.com',
                       country_id: 70, first_name: 'Ahmad', last_name: 'El Gewaily', profession: 'Pharmacist', gender: 'male')
  User.first_or_create(username: 'guest', password: '123testing', password_confirmation: '123testing', email: 'guest@localhost.com',
                       country_id: 70, first_name: 'Guest', last_name: 'User', profession: 'Physician', gender: 'female')
end

user_seed
form_seed
country_seed
companies_seed
categories_seed
drug_seed
