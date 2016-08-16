class Drug < ApplicationRecord
  has_many :drug_generics
  has_many :generics, through: :drug_generics

  belongs_to :company

  belongs_to :country
  belongs_to :form
end
