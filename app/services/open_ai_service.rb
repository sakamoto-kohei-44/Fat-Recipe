class OpenAiService
  def initialize
    @api_key = ENV.fetch('OPENAI_API_KEY', nil)
  end

  def generate_recipe(calories, allergies = [], disliked_foods = "", free_word = "")
    allergy_info = allergies.join(", ")
    prompt = "Please suggest three meal recipes for a day: one for the morning, one for midday, and one for the evening. " \
              "They should be suitable for a Japanese person who needs #{calories} kcal per day, " \
              "excluding any foods that cause these allergies: #{allergy_info}, and avoiding these disliked foods: #{disliked_foods}. " \
              "Additionally, consider this special request: #{free_word}. " \
              "Ensure each meal is clearly labeled as the morning meal, midday meal, and evening meal."
    uri = URI.parse("https://api.openai.com/v1/chat/completions")
    header = {
      'Content-Type': 'application/json',
      Authorization: "Bearer #{@api_key}"
    }
    body = {
      model: "gpt-4",
      messages: [
        {
          role: "system",
          content: "Please provide a helpful response."
        },
        {
          role: "user",
          content: prompt
        }
      ],
      max_tokens: 500
    }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    request = Net::HTTP::Post.new(uri, header)
    request.body = body

    response = http.request(request)
    parse_response(response)
  end

  private

  def parse_response(response)
    Rails.logger.info "API Response: #{response.body}"
    parsed_response = JSON.parse(response.body)
    if parsed_response['choices'] && parsed_response['choices'].first['message']
      parsed_response['choices'].first['message']['content'].strip
    else
      Rails.logger.error "API Error: #{parsed_response['error']}"
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Parsing Error: #{e.message}"
    nil
  end
end
