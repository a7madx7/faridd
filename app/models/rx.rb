class Rx < ApplicationRecord
  belongs_to :patient
  belongs_to :user

  has_many :rx_drugs
  has_many :drugs, through: :rx_drugs

  has_one :diagnosis
end
