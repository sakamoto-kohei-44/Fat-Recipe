require 'rails_helper'

RSpec.describe HeightWeightTargetWeightForm, type: :model do
  describe 'バリデーション' do
    it '身長、体重、目標体重があれば有効であること' do
      form = HeightWeightTargetWeightForm.new(height: 170, weight: 60, target_weight: 65)
      expect(form).to be_valid
    end

    it '身長がなければ無効であること' do
      form = HeightWeightTargetWeightForm.new(height: nil, weight: 60, target_weight: 65)
      expect(form).not_to be_valid
    end

    it '体重がなければ無効であること' do
      form = HeightWeightTargetWeightForm.new(height: 170, weight: nil, target_weight: 65)
      expect(form).not_to be_valid
    end

    it '目標体重がなければ無効であること' do
      form = HeightWeightTargetWeightForm.new(height: 170, weight: 60, target_weight: nil)
      expect(form).not_to be_valid
    end

    it '身長、体重、目標体重が0より小さい場合無効であること' do
      form = HeightWeightTargetWeightForm.new(height: -1, weight: -1, target_weight: -1)
      expect(form).not_to be_valid
    end

    it '身長、体重、目標体重が数値でなければ無効であること' do
      form = HeightWeightTargetWeightForm.new(height: '一七〇', weight: '六〇', target_weight: '六五')
      expect(form).not_to be_valid
    end
  end
end
