class Category < ApplicationRecord
  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_category_id"
  has_many :sub_categories, :class_name => "Category", :foreign_key => "parent_category_id"

  has_many :drug_categories
  has_many :drugs, through: :drug_categories

  has_many :likes

  validates :name, presence: true, uniqueness: true, length: (2..128)
  validates :color, length: (0..64), allow_nil: true, allow_blank: true

  scope :cheap_drugs, -> (cat) {
    cat.drugs.where('price < 30')
  }
  scope :pricey_drugs, -> (cat) {
      cat.drugs.where('price > 30')
  }

  def drugs_in
    # search drugs inside a certain category
    Drug.joins(:categories).where(categories: { id: [1,2,3,4,5] }).where('drugs.name like ?', "%ant%")
  end
  # color label categories in the faridd eco system.
  # accessibility feature
  #todo: use to_s on the category model instead of name
  def to_s
    # case name
    #   when (name.length <= 3 or name =~ /\(/ or name =~ /-/)
    #     name.upcase
    #   else
    #     name
    # end
    if name =~ /"*/i
      name.gsub('"', '')
    # /\s&.*/i
    elsif name =~ /&/i # matches Pregnancy &lactation
      name.gsub(/&/, ' & ')
    # /[^\s]*&\s/i
    # /\s,.*/i
    elsif name =~ /,/i
      name.gsub(/,/i, ', ')
    end
    self.save
    name.upcase
  end

  def text_orientation
    name.just_latin? ? 'left floated left aligned' : 'right floated right aligned'
  end

  def created_about
    name.just_latin? ? "Created #{time_ago_in_words(created_at)}" : "تم إنشائها منذ #{created_at}"
  end

  def updated_about
    name.just_latin? ? "Updated #{time_ago_in_words(obj.updated_at)}" : "اَخر تعديل لها منذ #{time_ago_in_words(obj.updated_at)}"
  end

  def parent?
    drugs.count <= 0
  end
  # two way
  def active_popular
    # Category.order(:updated_at, :view_count)
  end
  def passive_popular
    # Category.order(updated_at: :asc, :view_count)
  end

  def color
    return 'teal' unless name
    name.downcase!
    if name['antimicrobial'] or name['cancer'] or name['hiv'] or name['aids'] or name['biotic'] or name['cephalo'] or name['quinolon'] or name['tetra'] or name['toxin'] or name['vaccine'] or name['combination'] or name['hepatitis'] or name['marcolides']
      'red'
    elsif name['vitamin'] or name['skin'] or name['supplement'] or name['complement'] or name['preparation'] or name['massage'] or name['care']
      'blue'
    elsif name['erect'] or name['aphrodisiac'] or name['delay'] or name['sex']
      'pink'
    elsif name['depres'] or name['psyc'] or name['leptic']
      'brown'
    elsif name['diuretic'] or name['ace'] or name['ca channel'] or name['beta block'] or name['hypertens'] or name['heart'] or name['failure']
      'orange'
    elsif name['inflammatory'] or name['pyretic'] or name['analgesic'] or name['anti-rheum'] or name['allerg']
      'violet'
    elsif name['cosmetic'] or name['accessory']
      'green'
    elsif name['vaginal'] or name['gargle'] or name['wash'] or name['paint']
      'yellow'
    elsif name['proton'] or name['cholesterol'] or name['h2'] or name['antacid']
      'black'
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
      # @most_popular_categories = Category.joins(:drugs).order('count "drugs"')
      # joins(:drug_categories).order('drug_categories.category_id = ?')
    end

    ### get the categories with the least number of drugs associated with it.
    def least_popular
      @least_popular_categories ||= all.sort { |a, b| a.drugs.count <=> b.drugs.count }
                                        .reject { |category| category.drugs.count < 2 }.first(20)

    end

    def pricey
      @pricey_categories ||= all.map { |cat| [cat.id, cat.drugs.sum(:price)] }
                                 .sort { |a, b| b[1] <=> a[1] }.first(20)

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
      }.first(20)
    end
  end

  #todo: if the category is 50 EGP cheap or any other predefined value
  #then we have to remove it and assign the drug to anoter category
  # some categories can have only one drug but the drug is very expensive
  # so this kind of category will be left alone
end
