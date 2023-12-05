class RecipesController < ApplicationController
  def index
    if params[:calories].present?
      open_ai_service = OpenAiService.new
      deepl_service = DeepLService.new
      allergies = AllergyItem.where(id: session[:allergy_item_ids]).pluck(:name) if session[:allergy_item_ids].present?
      disliked_foods = params[:disliked_foods]
      @recipe = open_ai_service.generate_recipe(params[:calories], allergies, disliked_foods)
      @translated_recipe = deepl_service.translate(@recipe, "JA")

      recipe_parts = @translated_recipe.split("\n\n")
      @breakfast = recipe_parts[0] if recipe_parts.length.positive?
      @lunch = recipe_parts[1] if recipe_parts.length > 1
      @dinner = recipe_parts[2] if recipe_parts.length > 2
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
