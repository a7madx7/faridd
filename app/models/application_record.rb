class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(column = 'name', term)
    if term
      @results = self.where("#{column.to_s} like ?", "%#{term}%")
    else
      return false
    end
  end
end
