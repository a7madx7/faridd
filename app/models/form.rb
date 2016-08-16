class Form < ApplicationRecord
  has_many :drugs

  validates :name, uniqueness: true
end
