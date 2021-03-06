class Company < ApplicationRecord
  has_many :drugs
  has_many :likes
  belongs_to :country

  validates :name, presence: true, length: (2..128), uniqueness: true
  validates_numericality_of :reputation,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 10,
                            message: 'Reputation can only be a number between 0 and 10',
                            allow_nil: true,
                            allow_blank: true

  scope :popular, -> {
    Company.order(view_count: :desc)
  }

  # todo: validate name against bad words in articles down here (strict validation)
  class << self
    def search(q)
      where('name like :value', value: "%%#{q}")
    end

    def sponsored
      where('sponsored = true')
    end
  end

  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller&.current_user }
end
