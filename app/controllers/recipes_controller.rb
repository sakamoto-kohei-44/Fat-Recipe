class RecipesController < ApplicationController
  def index
    if params[:calories].present?
      open_ai_service = OpenAiService.new
      deepl_service = DeepLService.new
      @recipe = open_ai_service.generate_recipe(params[:calories])
      @translated_recipe = deepl_service.translate(@recipe, "JA")
    end
  end

  def search
  end

  def search_results
    deepl_service = DeepLService.new
    queries = params[:query].split(/,\s*/)
    @recipes = []

    queries.each do |query|
      translated_query = deepl_service.translate(query, "EN")
      next if translated_query.blank?

      response = SpoonacularService.search(query: translated_query)
      if response["error"]
        logger.error "Response body: #{response.body}"
      else
        response["results"].each do |recipe|
          @recipes << {
            id: recipe["id"],
            title: recipe["title"],
            image: recipe["image"]
          }
        end
      end
    end
    render :search_results
  end

  def autocomplete
    query = params[:query]
    response = SpoonacularService.autocomplete(query: query, number: 10)
    render json: response
  end
end
