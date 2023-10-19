class SpoonacularService
  require 'httparty'
  BASE_URL = 'https://api.spoonacular.com'
  API_KEY = Rails.application.credentials.dig(:spoonacular, :api_key)

  DEFAULT_MIN_CARBS = 10
  DEFAULT_MAX_CARBS = 100

  TRANSLATOR_BASE_URL = 'https://api.cognitive.microsofttranslator.com'
  TRANSLATOR_API_KEY = Rails.application.credentials.dig(:microsoft_translator, :api_key)
  TRANSLATOR_REGION = Rails.application.credentials.dig(:microsoft_translator, :region)

  def self.generate_meal_plan(target_calories = nil, diet = nil, exclude = nil)
    cache_key = "meal_plan_#{target_calories}_#{diet}_#{exclude}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
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
      return {} unless response.success?
      response.parsed_response
    end
  end

  def self.fetch_multiple_recipe_information(ids)
    # 複数のレシピ情報を一度に取得するためのAPIエンドポイントは提供されていないかもしれません。
    # そのため、一つ一つのレシピ情報を順次取得して結果を配列に格納する方法を採用します。
    recipes_info = []

    ids.each do |id|
      recipe_info = fetch_recipe_information(id)
      recipes_info << recipe_info unless recipe_info.empty?
    end

    recipes_info
  end

  def self.fetch_recipe_information(id)
    url = "#{BASE_URL}/recipes/#{id}/information"
    response = HTTParty.get(url, query: { apiKey: API_KEY, includeNutrition: true })

    Rails.logger.info "Response code: #{response.code}"
    Rails.logger.info "Response body: #{response.body}"

    return {} unless response.success? # ここを変更して空のハッシュを返すように
    response.parsed_response
  end

  def self.fetch_multiple_recipe_information(ids)
    recipes_info = ids.map do |id|
      fetch_recipe_information(id)
    end
    recipes_info
  end

  def self.translate_text(text, from_language, to_language)
    url = "#{TRANSLATOR_BASE_URL}/translate"
    headers = {
      'Ocp-Apim-Subscription-Key' => TRANSLATOR_API_KEY,
      'Ocp-Apim-Subscription-Region' => TRANSLATOR_REGION,
      'Content-Type' => 'application/json'
    }
    params = {
      'api-version' => '3.0',
      'from' => from_language,
      'to' => to_language,
      'textType' => 'plain'
    }
    body = [{ 'Text' => text }].to_json

    response = HTTParty.post(url, headers: headers, query: params, body: body)

    Rails.logger.info "Response code: #{response.code}"
    Rails.logger.info "Response body: #{response.body}"

    return '' unless response.success?
    response.parsed_response.first['translations'].first['text']
  end
end
