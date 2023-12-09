require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Recipe.search' do
    before do
      FactoryBot.create(:recipe, title: 'かぼちゃのピザ')
      FactoryBot.create(:recipe, title: 'BLTピザ')

      stub_request(:get, /api.spoonacular.com/)
        .to_return(status: 200, body: { results: [{ title: 'かぼちゃのピザ' }, { title: 'BLTピザ' }] }.to_json)
    end

    it 'returns recipes based on the Spoonacular API response' do
      results = Recipe.search('ピザ')
      expect(results.count).to eq(2)
      expect(results.first.title).to include('ピザ')
      expect(results.second.title).to include('ピザ')
    end
  end
end
