# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DRUG_DB_FILE = "#{Rails.root}/db/db.json"
COUNTRIES_DB_FILE = "#{Rails.root}/db/countries.json"

def seed(source_file, key)
  File.readlines(source_file).each do |d|
    d = ActiveSupport::JSON.decode(d)
    if key
      d[key].each do |name|
        begin
          Generic.create(name: name)
        end
      end
    else
      d.each do |code, name|
        Country.create(code: code, name: name)
      end
    end
  end
end

# seed(DRUG_DB_FILE, 'active_ingredient')
seed(COUNTRIES_DB_FILE, nil)