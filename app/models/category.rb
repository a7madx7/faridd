class Category < ApplicationRecord
  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_category_id"
  has_many :sub_categories, :class_name => "Category", :foreign_key => "parent_category_id"

  has_many :drug_categories
  has_many :drugs, through: :drug_categories

  has_many :likes

  validates :name, presence: true, uniqueness: true, length: (2..128)
  validates :color, length: (0..64), allow_nil: true, allow_blank: true
  # scope :with_cheap_drugs, joins(:drugs) & Drug.cheap

  # color label categories in the faridd eco system.
  # accessibility feature
  def to_s
    name
  end

  def color
    return 'teal' unless name
    name.downcase!
    if name['antimicrobial'] or name['cancer'] or name['hiv'] or name['aids'] or name['antibiotic'] or name['cephalo'] or name['quinolone'] or name['tetra'] or name['toxin'] or name['vaccine'] or name['combination']
      'red'
    elsif name['vitamin'] or name['skin'] or name['supplement'] or name['complement'] or name['preparation'] or name['massage'] or name['care']
      'blue'
    elsif name['sexual'] or name['erect'] or name['aphrodisiac'] or name['delay']
      'pink'
    elsif name['depres'] or name['psyc'] or name['leptic']
      'brown'
    elsif name['diuretic'] or name['ace'] or name['ca channel'] or name['beta block'] or name['hypertens'] or name['heart'] or name['failure']
      'orange'
    elsif name['anti-inflammatory'] or name['anti-pyretic'] or name['analgesic'] or name['anti-rheum'] or name['allerg']
      'violet'
    elsif name['cosmetic'] or name['accessory']
      'green'
    elsif name['vaginal'] or name['gargle'] or name['wash'] or name['paint']
      'yellow'
    elsif name['proton'] or name['cholesterol'] or name['h2'] or name['antacid']
      'olive'
    elsif name['burn'] or name['sun']
      'grey'
    else
      'teal'
    end
  end

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    ### get the categories with the most number of drugs associated with it.
    def most_popular
      @most_popular_categories ||= all.sort { |a, b| b.drugs.count <=> a.drugs.count }.first(20)
      # joins(:drug_categories).order('drug_categories.category_id = ?')
    end

    ### get the categories with the least number of drugs associated with it.
    def least_popular
      @least_popular_categories ||= all.sort { |a, b| a.drugs.count <=> b.drugs.count }.first(20)
    end

    def pricey
      @pricey_categories ||= all.map { |cat| [cat.id, cat.drugs.sum(:price)] }
                                 .sort { |a, b| b[1] <=> a[1] }
                                 .first(10)
    end

    def cheap
      @cheap_categories ||= all.map { |cat|
        sum = cat.drugs.sum(:price)
        next if sum < 100
        [cat.id, sum]
      }
      .compact
      .sort { |a, b|
        a[1] <=> b[1]
      }.first(10)
    end
  end

  #todo: if the category is 50 EGP cheap or any other predefined value
  #then we have to remove it and assign the drug to anoter category
  # some categories can have only one drug but the drug is very expensive
  # so this kind of category will be left alone
end
