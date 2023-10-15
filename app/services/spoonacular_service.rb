class SpoonacularService
  require 'httparty'
  BASE_URL = 'https://api.spoonacular.com/recipes/findByNutrients'
  API_KEY = Rails.application.credentials.dig(:spoonacular, :api_key)

  DEFAULT_MIN_CARBS = 10
  DEFAULT_MAX_CARBS = 100

  def self.fetch_suitable_recipes(user)
    # ユーザーの炭水化物の設定値が存在しないので、デフォルトの値を使用する
    min_carbs = DEFAULT_MIN_CARBS
    max_carbs = DEFAULT_MAX_CARBS

    url = BASE_URL
    response = HTTParty.get(url, query: { minCarbs: min_carbs, maxCarbs: max_carbs, apiKey: API_KEY })
    Rails.logger.info "Response code: #{response.code}"
    Rails.logger.info "Response body: #{response.body}"
    return [] unless response.success?
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
