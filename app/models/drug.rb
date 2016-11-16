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
  scope :cheap, -> { order(price: :asc) }
  scope :pricey, -> { order(price: :desc) }

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

    def look_alike_drugs

    end

  end

  # todo: set a default scope
  # scope :cheap, cheaper_than(30)
  def identical_drugs_by(attr = 'price')
    # self is a drug
    # .generics tells you each and every generic this drug has
    # a simple way is to search Drug where it has the same generics count
    # todo: learn querying in rails pretty damn good first!
    # Drug.all.map { |drug| drug.send(attr.to_sym) == send(attr.to_sym) ? drug : nil }.compact
    # Drug.joins(:drug_generics).where(attr.to_sym => attr)
    # get me all drugs that have the exact same relations to generics as this drug
    g = generics.map do |generic|
      Drug.joins(:drug_generics).where('drug_generics.generic_id = :value', value: generic.id)
    end
    # todo: enable logging here to see what actually happens
    # logger g
    # Drug.joins(:drug_generics, :generics).order('drug_generics_drugs_join.generic_id')
    # Drug.joins(posts: [:comments])
    # SELECT "users".*
    # FROM "users"
    # INNER JOIN "posts" ON "posts"."user_id" = "users"."id"
    # INNER JOIN "comments" "comments_posts"
    #   ON "comments_posts"."post_id" = "posts"."id"
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
        prefix, separator_match, name = name.to_s.partition('_')
        where("#{name} = :value", value: args.first.to_s)
      end
    end
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
