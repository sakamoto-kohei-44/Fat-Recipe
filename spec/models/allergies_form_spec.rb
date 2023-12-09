require 'rails_helper'

RSpec.describe AllergiesForm, type: :model do
  describe 'バリデーション' do
    it 'アレルギー項目のIDがあれば有効であること' do
      form = AllergiesForm.new(allergy_item_ids: [1, 2, 3])
      expect(form).to be_valid
    end

    it 'アレルギー項目のIDがなければ無効であること' do
      form = AllergiesForm.new(allergy_item_ids: [])
      expect(form).not_to be_valid
    end

    it 'アレルギー項目のIDがnilの場合も無効であること' do
      form = AllergiesForm.new(allergy_item_ids: nil)
      expect(form).not_to be_valid
    end
  end
end
