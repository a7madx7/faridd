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
    Drug.where(price: price)

    # Parallel.each(where(''), in_processes: 12) do |d|
    #
    # end
  end

  alias_method :identical_drugs, :identical_drugs_by

  def picture
    if form
      form.picture(self)
    else
      'http://marshallan.org/wp-content/uploads/2015/02/drugs.jpg'
    end
  end
  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end
  end
end
