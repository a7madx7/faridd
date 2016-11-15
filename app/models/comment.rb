class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :formulation
  belongs_to :rx

  has_many :likes
  # todo: validate against bad words in comments
  validates :content, presence: true
end
