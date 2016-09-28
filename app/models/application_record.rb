class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # todo: make model validation to include references to other models on creation in all models ( i.e. drug.company is a must )

  def self.search(column = 'name', term)
    if term
      if column == 'name'
        @results = self.where('name like ?', "%#{term}%")
      else
        @results = self.where('username like ?', "%#{term}%")
      end
    else
      return false
    end
  end
end
