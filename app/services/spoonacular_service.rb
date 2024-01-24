class SpoonacularService
  require 'httparty'
  BASE_URL = 'https://api.spoonacular.com'
  API_KEY = ENV.fetch('SPOONACULAR_API_KEY', nil)

  DEFAULT_MIN_CARBS = 10
  DEFAULT_MAX_CARBS = 100

  def self.fetch_recipe_information(id)  # 指定されたIDのレシピの詳細情報を取得
    url = "#{BASE_URL}/recipes/#{id}/information"
    response = HTTParty.get(url, query: { apiKey: API_KEY, includeNutrition: true })
    return {} unless response.success?
    response.parsed_response
  end

  def self.fetch_multiple_recipe_information(ids)  # 複数のレシピIDに対して詳細情報を一度に取得
    recipes_info = ids.map do |id|
      fetch_recipe_information(id)
    end
    recipes_info
  end

  def self.search(query:)  # 指定されたクエリに基づいてレシピを検索
    url = "#{BASE_URL}/recipes/complexSearch"
    params = {
      query: query,
      apiKey: API_KEY,
      addRecipeInformation: true,
      number: 8
    }
    response = HTTParty.get(url, query: params)
    response.parsed_response
  end
end
