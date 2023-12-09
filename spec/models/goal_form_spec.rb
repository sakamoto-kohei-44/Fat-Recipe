require 'rails_helper'

RSpec.describe GoalForm, type: :model do
  describe 'バリデーション' do
    it '目標があれば有効であること' do
      form = GoalForm.new(goal: '標準体重を目指す')
      expect(form).to be_valid
    end

    it '目標がなければ無効であること' do
      form = GoalForm.new(goal: nil)
      expect(form).not_to be_valid
    end
  end
end
