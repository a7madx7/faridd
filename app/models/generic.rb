class Generic < ApplicationRecord
  has_many :drug_generics
  has_many :drugs, through: :drug_generics

  validates :name, presence: true, length: (2..128), uniqueness: true

  # def invented_at
  #   invented_at.nil? ? 'Not yet known!' : invented_at
  # end
  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end
  end
end
