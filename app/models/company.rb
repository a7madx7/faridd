class Company < ApplicationRecord
  has_many :drugs
  belongs_to :country
end
