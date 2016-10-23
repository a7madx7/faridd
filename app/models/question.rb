class Question < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true, uniqueness: true
end
