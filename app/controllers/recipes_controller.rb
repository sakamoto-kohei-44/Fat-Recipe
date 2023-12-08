class RecipesController < ApplicationController
  def index
    if params[:calories].present?
      open_ai_service = OpenAiService.new
      deepl_service = DeepLService.new
      allergies = AllergyItem.where(id: session[:allergy_item_ids]).pluck(:name) if session[:allergy_item_ids].present?
      disliked_foods = params[:disliked_foods]
      @recipe = open_ai_service.generate_recipe(params[:calories], allergies, disliked_foods)
      @translated_recipe = deepl_service.translate(@recipe, "JA")

      parse_recipes(@translated_recipe)
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

  private

  def parse_recipes(translated_recipe)
    @breakfast, @lunch, @dinner = extract_meals(translated_recipe)
  end

  def extract_meals(translated_recipe)
    breakfast = extract_meal(translated_recipe, "朝食")
    lunch = extract_meal(translated_recipe, "昼食")
    dinner = extract_meal(translated_recipe, "夕食")
    [breakfast, lunch, dinner]
  end

  def extract_meal(recipe_text, meal_type)
    start_index = recipe_text.index(meal_type)
    return "" unless start_index

    end_index = recipe_text.index("\n\n", start_index)
    end_index ||= recipe_text.length

    recipe_text[start_index...end_index].strip
  end
end
