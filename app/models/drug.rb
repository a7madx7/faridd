class Drug < ApplicationRecord
  has_many :drug_generics
  has_many :generics, through: :drug_generics

  has_many :drug_categories
  has_many :categories, through: :drug_categories

  has_many :rx_drugs
  has_many :rxs, through: :rx_drugs

  belongs_to :company

  belongs_to :country
  belongs_to :form

  def to_s
    "#{name.split(' ').map { |part| part.capitalize }.join(' ') } #{price}"
  end
end
