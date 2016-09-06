class Category < ApplicationRecord
  has_many :drug_categories
  has_many :drugs, through: :drug_categories
end
