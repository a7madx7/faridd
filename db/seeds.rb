# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DRUG_DB_FILE = "#{Rails.root}/db/db.json"
COUNTRIES_DB_FILE = "#{Rails.root}/db/countries.json"

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
def drug_seed
  File.readlines(DRUG_DB_FILE).each do |d|
    # d is a drug line
    d = ActiveSupport::JSON.decode(d)
    Drug.where(name: d['name'].downcase).first_or_create do |h|
      h.name = d['name']

      h.country = Country.where(code: 'eg').first_or_create
      h.company = Company.where(name: d['company']).first_or_create

      h.form = Form.where(name: d['form']).first_or_create
      h.price = d['price'].to_s.to_f

      d['active_ingredient'].each { |ac|  h.generics << Generic.where(name: ac).first_or_create }
    end
  end
end
# seed(DRUG_DB_FILE, 'active_ingredient')
form_seed
country_seed
drug_seed
# seed(COUNTRIES_DB_FILE, nil)