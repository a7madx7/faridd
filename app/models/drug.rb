class Drug < ApplicationRecord
  has_many :drug_generics
  has_many :generics, through: :drug_generics

  has_many :drug_categories
  has_many :categories, through: :drug_categories

  has_many :rx_drugs
  has_many :rxs, through: :rx_drugs

  has_many :likes

  belongs_to :company

  belongs_to :country
  belongs_to :form

  validates :name, presence: true, uniqueness: true, length: (2..64)
  # to always show the drugs of the user's country
  # default_scope { same_country }

  scope :cheap, -> { order(price: :asc) }
  scope :pricey, -> { order(price: :desc) }
  scope :popular, -> {
    Drug.order(view_count: :desc)
  }

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    def cheaper_than(price)
      where('price < ?', price)
    end

    def has_company
      Drug.joins(:company).where.not('companies.name like ?', '%unknown%')
    end

    def has_generics
      Drug.joins(:generics)
    end

    def look_alike_drugs

    end

  end

  def ==(other)
    (self.generics.count == other.generics.count) and (self.generics.ids == other.generics.ids)
  end
  # todo: set a default scope
  # scope :cheap, cheaper_than(30)
  def identical_drugs_by(attr = 'price')
    g = generics
    # Drug.joins(:generics).where('drug_generics.generic_id in (:gs) and drug_generics.concentration = :con', gs: g.ids, con: concentration).each.reject { |d| d != self}
    Drug.joins(:generics).where('drug_generics.generic_id in (:gs)', gs: g.ids).each.reject { |d| d != self }
  end

  alias_method :identical_drugs, :identical_drugs_by

  def to_s
    "#{name.split(' ').map { |part| part.capitalize }.join(' ') } #{price} EGP"
  end

  def description
    categories.first.name
  end
  def method_missing(name, *args, &block)
    unless block_given?
      if name =~ /^same/
        _, _, name = name.to_s.partition('_')
        where("#{name} = :value", value: args.first.to_s)
      end
    end
  end

  def same_company_same_price
    same_company.same_price
  end

  def same_country_same_price
      same_country.same_price
  end

  def same_company
    where('company_id = :company', company: company.id)
  end
  def same_price
    where('price = :p', p: price)
  end
  def same_country
    where('country_id = :c', c: country.id)
  end

  def picture
      if form
        form.picture(self)
      else
        'http://marshallan.org/wp-content/uploads/2015/02/drugs.jpg'
      end
  end

  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller&.current_user }
end
