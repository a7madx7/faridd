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
    rescue
      next
    end
  end
end

def form_seed
  puts 'Started seeding dosage forms...'
  begin
    ['amp', 'vial',
     'cap', 'tab', 'enteric coated tab', 'film coated tab', 'lozenges' , 'chew. tab', 'caplet', 'pilules', 'powder',
     'susp', 'emulsion', 'spray', 'syrup', 'tincture', 'decoction', 'infusion', 'bottle', 'elixir',
     'lotion','oil', 'serum', 'shampoo', 'lip stick', 'roll on',
     'granules', 'eff. granules', 'eff. tab',
     'spray', 'topical spray', 'neb. susp', 'oral spray',
     'turbohaler', 'evohaler', 'inhaled cap', 'novolet', 'inhaler', 'aerosol', 'discus',
     'drops', 'ear drops', 'eye drops', 'oral drops',
     'cream', 'ointment', 'gel', 'eye(ointment-gel)', 'cream gel', 'oral gel',
     'mouth wash (m.w.)', 'suppository',
     'vaginal suppository', 'vaginal cream', 'vaginal tab','vaginal douche', 'vaginal powder', 'vaginal gel',
     'rectal tube',
     'enema', 'soap', 'pack',
     'sachets',
     'patches', 'sheet', 'liniment',
     'pen', 'flexpen', 'prefilled pen', 'cartridges', 'carpule', 'syringe'].each do |df|
      begin
        Form.create(name: df)
      rescue Exception => ex
        puts "Error creating a dosage form: #{ex.message}"
        next
      end
    end
  rescue Exception => ex
    puts ex.message
  end
  puts 'Finished seeding dosage forms.'
end

def unit_seed
 puts 'Started seeding concentration units...'
 begin
   ['ml', 'mg', '%', 'ppm', 'g', 'kg', 'mcgm', 'pico gram', 'nano gram', 'miu', 'million', 'billion', 'u/ml', 'unit', 'i.u.'].each do |unit|
     begin
       Unit.create(name: unit)
     rescue Exception => ex
       puts "Error creating a concentration unit: #{ex.message}"
       next
     end
   end
 rescue Exception => ex
   puts ex.message
 end
  puts 'Done seeding concentration units.'
end

def country_seed
  puts 'Started seeding countries...'
  c = File.read(COUNTRIES_DB_FILE)
  country = ActiveSupport::JSON.decode(c)
  country.each do |k, v|
    begin
      Country.create(code: k.upcase, name: v)
    rescue Exception => ex
      puts "Error creating a country: #{ex.message}"
      next
    end
  end
  puts 'Finished seeding countries.'
end

def category_company_seed
  puts 'Started seeding categories and companies...'
  read(DRUG_DB_FILE) do |d|
    begin
      if d['category'].nil?
        Category.create(name: "A NOT LISTED CATEGORY")
      else
        newly_created_cat = Category.create(name: d['category'].downcase)
        # assign category id
        if d['parent_category']
         parent_cat_relation = Category.where(name: d['parent_category'].downcase)
         if parent_cat_relation.first.present?
            parent = Category.create(name: d['parent_category'].downcase)
            newly_created_cat.parent = parent
            newly_created_cat.save
         else # if the parent cat is already created
            newly_created_cat.parent = parent_cat_relation.first
            newly_created_cat.save
         end
        end
      end
    rescue Exception => ex
      puts "Error creating a category: #{ex.message}"
      next
    end

    begin
      if d['company'].nil?
        Company.create(name: "A NOT LISTED COMPANY OR IMPORTED", reputation: 0, country: Country.where(code: 'EG').first)
      else
        Company.create(name: d['company'].downcase, reputation: 3, country: Country.where(code: 'EG').first)
      end
    rescue Exception => ex
      puts "Error creating a company: #{ex.message}"
      next
    end
  end
  puts 'Finished seeding categories, companies.'
end

def drug_seed
  puts 'Started seeding drugs...'
  read(DRUG_DB_FILE) do |d|
   # d is a decoded json line representing a drug object
    begin
      unless d['name'].nil?
        drug = Drug.where(name: d['name'].downcase).first_or_create! do |drug|
          drug.name = d['name'].downcase

          drug.country = Country.where(code: 'EG').first
          unless d['company'].nil?
            drug.company = Company.where(name: d['company'].downcase).first
          end
          unless d['category'].nil?
            drug.categories << Category.where(name: d['category'].downcase).first
          end
          unless d['form'].nil?
            drug.form = Form.where('name like ?', "%#{d['form']}%").first
          end
          unless d['contents'].nil?
            drug.contents = d['contents'].to_f
          end
          unless d['price'].nil?
            drug.price = d['price'].to_s.to_f
          end
          # Start seeding the generics to the drugs.
          begin
            # d is a single decoded json line
            unless d['active_ingredient'].nil?
              d['active_ingredient'].each do |ac|
                begin
                  g = Generic.where(name: ac['name'].downcase).first_or_create

                  # add the wiki stuff to each and every generic you've got.
                  require 'wikipedia'
                  unless g.wikipedia_page_url
                    Wikipedia.find(g.name).tap do |page|
                      g.wikipedia_page_url = page.fullurl
                      g.wikipedia_image_urls = page.image_urls
                      g.wikipedia_links = page.links
                      g.wikipedia_extlinks = page.extlinks
                      g.wikipedia_summary = page.summary

                      g.save
                    end
                  end

                  drug.generics << g

                rescue Exception => ex
                  puts "Generic loading inside drug error: #{ex.message}"
                  next
                ensure

                end
              end
            end
          rescue Exception => err
            puts "Error loading whole generics: #{err.message}"
            next
          end
        end

        # find the drug that has the same drug id as the current one
        # loop through its generics
        # assign a unit and concentration value to them
        begin
         unless d['active_ingredient'].nil?
           d['active_ingredient'].each do |ai|
             DrugGeneric.where(drug_id: drug.id).first.tap do |medicine|
               begin
                 unit = Unit.where(name: ai['unit'].downcase).first_or_create
                 medicine.unit_id = unit.id
               rescue Exception => ex
                 puts "Error while assigning unit id to the drug generic object: #{ex.message}"
                 puts "DrugGeneric Object: #{medicine.to_s}"
                 puts "ai: #{ai.to_s}"
                 puts "unit: #{ai['unit']}"
                 raise
               end

               begin
                 # todo: bug -> assigns wrong concentration to the wrong generic
                 medicine.concentration = ai['concentration']
               rescue Exception => ex
                 puts puts "Error while assigning concentration to the drug generic object: #{ex.message}"
               end

               medicine.save
             end
           end
         end
        rescue Exception => ex
          puts "Error updating DrugGeneric unit and concentration: #{ex.message}"
          break
        end
      end
    rescue Exception => ex
      puts "Error while creating the drug object: #{ex.message}"
      next
    end
   # puts "Created #{drug}"
  end
  puts 'Finished seeding drugs.'
end

def user_seed
  puts 'Started seeding users...'
 begin
   User.create!(username: 'a7madx7', password: '123testing', password_confirmation: '123testing', email: 'ahmad.hamdi.emara@gmail.com',
                        country_id: 70, first_name: 'Ahmad', last_name: 'Emara', profession: 'Pharmacist', gender: 'male')
   User.create!(username: 'aug', password: '123testing', password_confirmation: '123testing', email: 'aug@gmail.com',
                        country_id: 70, first_name: 'Ahmad', last_name: 'El Gewaily', profession: 'Pharmacist', gender: 'male')
   User.create!(username: 'guest', password: '123testing', password_confirmation: '123testing', email: 'guest@gmail.com',
                        country_id: 70, first_name: 'Guest', last_name: 'User', profession: 'Physician', gender: 'female')
   User.create!(username: 'physician', password: '123testing', password_confirmation: '123testing', email: 'physician@gmail.com',
                        country_id: 70, first_name: 'Deyaa', last_name: 'Hamdi', profession: 'Physician', gender: 'male')
   User.create!(username: 'student', password: '123testing', password_confirmation: '123testing', email: 'student@gmail.com',
                        country_id: 70, first_name: 'sondos', last_name: 'farid', profession: 'Physician', gender: 'female')
   User.create!(username: 'company', password: '123testing', password_confirmation: '123testing', email: 'company@gmail.com',
                        country_id: 70, first_name: 'United', last_name: 'Pharma', profession: 'company', gender: 'male')
 rescue Exception => ex
   puts "User seeding error: #{ex.message}"
 end
  puts 'Finished seeding users.'
end

def diagnoses_seed
  puts 'Started seeding diagnoses...'
  10.times do |n|
    begin
      Diagnosis.create!(name: "Diagnosis number #{n + 1}")
    rescue Exception => ex
      puts "Error creating a diagnosis: #{ex.message}"
    end
  end
  puts 'Finished seeding diagnoses.'
end

def articles_seed
  puts 'Started seeding articles...'
  Article.all.each { |article| article.destroy; article.save }

  66.times do |n|
    begin
      a = Article.create!(title: "Title number #{n + 1} for this article",
                         content: "This should be the content of article number #{n + 1}",
                         user_id: Random.rand(1..6))

      begin
        a.categories << Category.first
      rescue
      end
    rescue Exception => ex
      puts "Article seeding error: #{ex.message}"
      next
    end
  end
  puts 'Finished seeding articles.'
end

def question_seed
  puts 'Started seeding questions...'
  999.times do |n|
    begin
      Question.create!(title: "#{n + 1} How can I become a pharmacist?",
                               content: "#{n + 1} I wish to be a successful pharmacist in the future, how can I do that?",
                               rating: 5,
                               user_id:  Random.rand(1..6))
    rescue Exception => ex
      puts ex.message
      next
    end
  end
  puts 'Finished seeding questions.'
end

# user_seed
# country_seed
# form_seed
# unit_seed

# category_company_seed

# diagnoses_seed
articles_seed
# question_seed

# drug_seed
