class SpoonacularService
  require 'httparty'
  BASE_URL = 'https://api.spoonacular.com'
  API_KEY = Rails.application.credentials.dig(:spoonacular, :api_key)

  DEFAULT_MIN_CARBS = 10
  DEFAULT_MAX_CARBS = 100

  def self.generate_meal_plan(target_calories = nil, diet = nil, exclude = nil)
    url = "#{BASE_URL}/mealplanner/generate"

    # オプションのパラメータを設定
    params = {
      timeFrame: 'day',
      apiKey: API_KEY
    }
    params[:targetCalories] = target_calories if target_calories.present?
    params[:diet] = diet if diet.present?
    params[:exclude] = exclude if exclude.present?

    response = HTTParty.get(url, query: params)

    Rails.logger.info "Response code: #{response.code}"
    Rails.logger.info "Response body: #{response.body}"
    return {} unless response.success?
    response.parsed_response
  end

  def self.fetch_recipe_information(id)
    url = "https://api.spoonacular.com/recipes/#{id}/information"
    response = HTTParty.get(url, query: { apiKey: API_KEY, includeNutrition: true })

    Rails.logger.info "Response code: #{response.code}"
    Rails.logger.info "Response body: #{response.body}"

    return [] unless response.success?
    response.parsed_response
  end
end
