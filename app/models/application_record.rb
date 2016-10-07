class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # todo: make model validation to include references to other models on creation in all models ( i.e. drug.company is a must )
end
