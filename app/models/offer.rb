class Offer < ApplicationRecord
  validates :amount, presence: true, length: (1..10), numericality: true
  validates :discount, presence: true, length: (0..3), numericality: true
end
