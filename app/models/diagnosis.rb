class Diagnosis < ApplicationRecord
  has_many :likes
  validates :name, presence: true, uniqueness: true
end
