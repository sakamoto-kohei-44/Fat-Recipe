class DeepLService
  def initialize
    @api_key = ENV.fetch('DEEPL_API_KEY', nil)
  end

  def translate(text, target_lang = 'JA')
    uri = URI.parse('https://api-free.deepl.com/v2/translate')
    params = {
      auth_key: @api_key,
      text: text,
      target_lang: target_lang
    }
    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Post.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      translated_text = JSON.parse(response.body)['translations'][0]['text']
      Rails.logger.info "Received translation from DeepL: #{translated_text}"
      translated_text
    else
      Rails.logger.error "DeepL API Error: #{response.code} - #{response.body}"
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Parsing Error: #{e.message}"
    nil
  end
end
