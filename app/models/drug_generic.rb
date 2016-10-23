class DrugGeneric < ApplicationRecord
  belongs_to :drug
  belongs_to :generic
  has_one :unit
end
