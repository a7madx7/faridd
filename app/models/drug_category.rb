class DrugCategory < ApplicationRecord
  belongs_to :drug
  belongs_to :category
end