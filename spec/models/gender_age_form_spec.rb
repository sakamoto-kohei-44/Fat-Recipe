require 'rails_helper'

RSpec.describe GenderAgeForm, type: :model do
  describe 'バリデーション' do
    it '性別と年齢があれば有効であること' do
      form = GenderAgeForm.new(gender: 'male', age: 25)
      expect(form).to be_valid
    end

    it '性別がなければ無効であること' do
      form = GenderAgeForm.new(gender: nil, age: 25)
      expect(form).not_to be_valid
    end

    it '年齢がなければ無効であること' do
      form = GenderAgeForm.new(gender: 'male', age: nil)
      expect(form).not_to be_valid
    end

    it '年齢が整数でなければ無効であること' do
      form = GenderAgeForm.new(gender: 'male', age: 'twenty')
      expect(form).not_to be_valid
    end

    it '年齢が数値でなければ無効であること' do
      form = GenderAgeForm.new(gender: 'male', age: 25.5)
      expect(form).not_to be_valid
    end
  end
end
