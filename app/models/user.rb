class User < ApplicationRecord
  attr_accessor :skip_special_validation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :weight_logs
  has_many :recipes
  has_many :food_preferences
  has_many :allergies
  has_many :favorites

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }, unless: :skip_special_validation?
  validates :height, :weight, presence: true, numericality: { greater_than: 0 }, unless: :skip_special_validation?


  enum gender: { man: 0, woman: 1 }
  enum goal: { standard: 0, slim_muscle: 1 }

  private

  def skip_special_validation?
    skip_special_validation == true
  end
end
