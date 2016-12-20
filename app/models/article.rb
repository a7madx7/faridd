class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories

  has_many :user_articles
  has_many :users, through: :user_articles

  has_many :comments
  has_many :likes

  validates :title, presence: true, length: (3..128)
  validates :content, presence: true, length: (16..1024)

  scope :popular, -> {
    Article.order(view_count: :desc)
  }

  class << self

  end
  # todo: validate against bad words in articles down here (soft validation not hard)
  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller&.current_user }
end
