class User < ApplicationRecord
  authenticates_with_sorcery!
  include Sorcery::Model
  mount_uploader :avatar, AvatarUploader

  attr_accessor :skip_special_validation

  before_validation :set_skip_special_validation
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, presence: true

  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }, unless: :skip_special_validation?
  validates :height, :weight, presence: true, numericality: { greater_than: 0 }, unless: :skip_special_validation?

  has_many :weight_logs, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :food_preferences, dependent: :destroy
  has_many :allergies, dependent: :destroy

  enum gender: { man: 0, woman: 1 }
  enum goal: { standard: 0, slim_muscle: 1 }
  enum activity_level: { low: 0, moderate: 1, high: 2 }

  private

  def skip_special_validation?
    skip_special_validation == true
  end

  def set_skip_special_validation
    self.skip_special_validation = true if new_record? && password.present? && email.present?
  end
end
