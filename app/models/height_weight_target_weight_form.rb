class HeightWeightTargetWeightForm
  include ActiveModel::Model

  attr_accessor :height, :weight, :target_weight
  validates :height, :weight, :target_weight, presence: true, numericality: { greater_than: 0 }
end