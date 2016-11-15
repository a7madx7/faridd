class Question < ApplicationRecord
  belongs_to :user

  has_many :likes
  validates :title, :content, presence: true, uniqueness: true
end
