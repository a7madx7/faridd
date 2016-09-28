class Comment < ApplicationRecord
  belongs_to :user

  has_many :article_comments
  has_many :articles, through: :article_comments

  # todo: validate against bad words in comments
  validates :content, presence: true
end
