class Country < ApplicationRecord
  has_many :users

  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
end
