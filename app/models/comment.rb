class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :formulation
  belongs_to :rx

  has_many :likes
  # todo: validate against bad words in comments
  validates :content, presence: true

  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller&.current_user }
end
