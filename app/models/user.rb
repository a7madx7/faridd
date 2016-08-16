class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :country


  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_presence_of :username, :email, :first_name, :last_name, :profession

  def country=(val)
    if val.is_a? String
      Country.where(code: val.upcase).first
    else
      country = val
    end
  end
  # validate profession with a narrow group of values [pharmacist, physician, dentist, company]
end
