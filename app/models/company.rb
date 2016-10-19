class Company < ApplicationRecord
  has_many :drugs
  belongs_to :country

  validates :name, presence: true, length: (2..64)

  # todo: validate name against bad words in articles down here (strict validation)
  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    def sponsored
      where('sponsored = true')
    end
  end
end
