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

  validates :name, presence: true, uniqueness: true, length: (2..64)

  def to_s
    "#{name.split(' ').map { |part| part.capitalize }.join(' ') } #{price} EGP"
  end

  def identical_drugs(attr = 'generics')
    # self is a drug
    # generics tells you each and every generic this drug has
    # a simple way is to search Drug where it has the same generics count
    # todo: learn querying in rails pretty damn good first!
    # Drug.where('generics')
    Drug.where(attr.to_sym => send(attr)).all
  end
end
