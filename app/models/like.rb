class Like < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  belongs_to :drug
  belongs_to :formulation
  belongs_to :comment
  belongs_to :article
  belongs_to :category
  belongs_to :company
  belongs_to :diagnosis
  belongs_to :generic
  belongs_to :question
end
