require 'rails_helper'

RSpec.describe ActivityLevelForm, type: :model do
  describe 'バリデーションが正しく設定されていること' do
    it 'アクティビティレベルがあれば有効であること' do
      form = ActivityLevelForm.new(activity_level: 'low')
      expect(form).to be_valid
    end

    it 'アクティビティレベルがなければ無効であること' do
      form = ActivityLevelForm.new(activity_level: nil)
      expect(form).not_to be_valid
    end
  end
end
