class DrugGeneric < ApplicationRecord
  belongs_to :drug
  belongs_to :generic
end
