class GoalForm
  include ActiveModel::Model

  attr_accessor :goal

  validates :goal, presence: true
end
