class DrugGeneric < ApplicationRecord
  belongs_to :drug
  belongs_to :generic
  has_one :unit

  def to_s
    "#{id} concentration: #{concentration}, unit_id: #{unit_id}"
  end
end
