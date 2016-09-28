class Company < ApplicationRecord
  has_many :drugs
  belongs_to :country

  validates :name, presence: true, length: (2..64)

  # todo: validate name against bad words in articles down here (strict validation)
end
