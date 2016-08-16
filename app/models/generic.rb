class Generic < ApplicationRecord
  has_many :drug_generics
  has_many :drugs, through: :drug_generics

  validates :name, presence: true, length: (2..128), uniqueness: true
end
