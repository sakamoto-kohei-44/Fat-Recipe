require 'rails_helper'

RSpec.describe WeightLog, type: :model do
  describe '関連付け' do
    it 'Userモデルとの関連付けが正しいこと' do
      should belong_to(:user)
    end
  end
end
