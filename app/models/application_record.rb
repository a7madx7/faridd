class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
