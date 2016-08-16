class Generic < ApplicationRecord
  validates :name, presence: true, length: (2..128), uniqueness: true
end
