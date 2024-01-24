class User < ApplicationRecord
  authenticates_with_sorcery!
  include Sorcery::Model
  mount_uploader :avatar, AvatarUploader
  before_validation :set_skip_special_validation
  before_create :set_default_timestamps

  attr_accessor :skip_special_validation

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: { scope: :deleted_at }, presence: true

  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }, unless: :skip_special_validation?
  validates :height, :weight, presence: true, numericality: { greater_than: 0 }, unless: :skip_special_validation?

  has_many :weight_logs, dependent: :destroy
  has_many :user_allergies, dependent: :destroy
  has_many :allergy_items, through: :user_allergies
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

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

  def set_default_timestamps
    self.created_at ||= Time.current
    self.updated_at ||= Time.current
  end

  def active_for_authentication?
    super && deleted_at.nil?
  end
end
