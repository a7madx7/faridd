class Rx < ApplicationRecord
  belongs_to :patient
  has_many :rx_drugs
  has_many :drugs, through: :rx_drugs
end
