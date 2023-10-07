class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :weight_logs
  has_many :recipes
  has_many :food_preferences
  has_many :allergies
  has_many :favorites

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :height, :weight, presence: true, numericality: { greater_than: 0 }

  enum gender: { man: 0, woman: 1 }
  enum goal: { standard: 0, slim_muscle: 1 }
end
