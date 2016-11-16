class Diagnosis < ApplicationRecord
  has_many :likes
  validates :name, presence: true, uniqueness: true

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end
  end
end
