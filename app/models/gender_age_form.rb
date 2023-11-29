class GenderAgeForm
  include ActiveModel::Model

  attr_accessor :gender, :age

  validates :gender, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
end
