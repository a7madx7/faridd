class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  belongs_to :country

  has_many :user_articles
  has_many :articles, through: :user_articles

  has_many :rxs
  has_many :questions

  # todo: enable paperclip here
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'

  
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_presence_of :username, :email, :first_name, :last_name, :profession
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_uniqueness_of :username, :email

  def country=(val)
    if val.is_a? String
      Country.where(code: val.upcase).first
    else
      country = val
    end
  end
  # validate profession with a narrow group of values [pharmacist, physician, dentist, company]

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end

  def picture
    if image_url
      image_url
    else
      'https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png'
    end
  end
  class << self
    def search(q)
      where('username like :value or email like :value', value: "%#{q}%")
    end
  end
end
