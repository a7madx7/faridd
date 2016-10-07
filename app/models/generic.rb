class Generic < ApplicationRecord
  has_many :drug_generics
  has_many :drugs, through: :drug_generics

  validates :name, presence: true, length: (2..128), uniqueness: true

  # scope :same, same_as(drug)


  # def invented_at
  #   invented_at.nil? ? 'Not yet known!' : invented_at
  # end
  def to_s
   name
  end

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    def same_as(drug)
      where('generic_id = ?', drug.generics)
    end
  end
end
