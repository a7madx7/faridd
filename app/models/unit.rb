class Unit < ApplicationRecord
  belongs_to :drug_generic
  validates :name, presence: true, uniqueness: true

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end
  end
end
