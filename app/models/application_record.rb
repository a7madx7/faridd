class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # todo: make model validation to include references to other models on creation in all models ( i.e. drug.company is a must )
  scope :recent, -> { order(created_at: :desc) }
  # todo: update the logic based on the view count of the item
  scope :trending, -> { }
end
