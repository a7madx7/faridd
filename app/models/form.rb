class Form < ApplicationRecord
  has_many :drugs

  validates :name, presence: true, uniqueness: true
end
