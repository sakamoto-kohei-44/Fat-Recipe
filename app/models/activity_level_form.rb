class ActivityLevelForm
  include ActiveModel::Model

  attr_accessor :activity_level
  validates :activity_level, presence: true
end