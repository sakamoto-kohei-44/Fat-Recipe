class SpoonacularService
  require 'httparty'
  BASE_URL = 'https://api.spoonacular.com'
  API_KEY = ENV.fetch('SPOONACULAR_API_KEY', nil)

  DEFAULT_MIN_CARBS = 10
  DEFAULT_MAX_CARBS = 100

  def self.generate_meal_plan(target_calories = nil, diet = nil, exclude = nil)
    cache_key = "meal_plan_#{target_calories}_#{diet}_#{exclude}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      url = "#{BASE_URL}/mealplanner/generate"

      params = {
        timeFrame: 'day',
        apiKey: API_KEY
      }
      params[:targetCalories] = target_calories if target_calories.present?
      params[:diet] = diet if diet.present?
      params[:exclude] = exclude if exclude.present?

      response = HTTParty.get(url, query: params)
      return {} unless response.success?
      response.parsed_response
    end
  end

  def self.fetch_recipe_information(id)
    url = "#{BASE_URL}/recipes/#{id}/information"
    response = HTTParty.get(url, query: { apiKey: API_KEY, includeNutrition: true })
    return {} unless response.success?
    response.parsed_response
  end

  def self.fetch_multiple_recipe_information(ids)
    recipes_info = ids.map do |id|
      fetch_recipe_information(id)
    end
    recipes_info
  end

  def self.search(query:)
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
