class Drug < ApplicationRecord
  has_many :drug_generics
  has_many :generics, through: :drug_generics

  has_many :drug_categories
  has_many :categories, through: :drug_categories

  has_many :rx_drugs
  has_many :rxs, through: :rx_drugs

  belongs_to :company

  belongs_to :country
  belongs_to :form

  validates :name, presence: true, uniqueness: true, length: (2..64)

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    def cheaper_than(price)
      where('price < ?', price)
    end

    def has_company
      Drug.joins(:companies)
    end

    def has_generics
      Drug.joins(:generics)
    end
  end

  # todo: set a default scope
  # scope :cheap, cheaper_than(30)

  def new_price
    if price < 10
      price + 2
    elsif price > 10 and price < 30

    else
      price
    end
  end

  def to_s
    "#{name.split(' ').map { |part| part.capitalize }.join(' ') } #{price} EGP"
  end


  def identical_drugs_by(attr = 'price')
    # self is a drug
    # .generics tells you each and every generic this drug has
    # a simple way is to search Drug where it has the same generics count
    # todo: learn querying in rails pretty damn good first!
    # Drug.all.map { |drug| drug.send(attr.to_sym) == send(attr.to_sym) ? drug : nil }.compact
    # Drug.joins(:drug_generics).where(attr.to_sym => attr)
    # get me all drugs that have the exact same relations to generics as this drug
    joins(:generics) & Drug.where('drug.generics = ?', attr)
  end
  alias_method :identical_drugs, :identical_drugs_by

  def look_alike_drugs

  end

  def same_category

  end

  def same_price

  end

  def same_company

  end

  def same_country

  end

  def same_dosage_form

  end

  def same_company_same_price

  end

  def same_country_same_price

  end

  def picture
    if form
      form.picture(self)
    else
      'http://marshallan.org/wp-content/uploads/2015/02/drugs.jpg'
    end
  end
end
