class Category < ApplicationRecord
  has_many :drug_categories
  has_many :drugs, through: :drug_categories

  validates :name, presence: true, uniqueness: true, length: (2..128)
  validates :color, length: (0..64), allow_nil: true, allow_blank: true
  # scope :with_cheap_drugs, joins(:drugs) & Drug.cheap

  # color label categories in the faridd eco system.
  # accessibility feature
  def to_s
    name
  end

  def color
    if name['antimicrobial'] or name['cancer'] or name['hiv'] or name['antibiotic']
      'red'
    elsif name['vitamin'] or name['skin'] or name['supplement'] or name['complement'] or name['preparation']
      'blue'
    elsif name['diuretic'] or name['ace'] or name['ca channel'] or name['beta block'] or name['hypertens']
      'orange'
    elsif name['anti-inflammatory'] or name['anti-pyretic'] or name['analgesics']
      'grey'
    elsif name['cosmetic']
      'green'
    else
      'teal'
    end
  end

end
