class RecipesController < ApplicationController
  before_action :set_services
  def index
    if params[:calories].blank?
      flash.now[:alert] = t('.fail')
      render 'recipe_suggestions/index'
      nil
    else
      allergies = []
      if session[:allergy_item_ids].present?
        allergies = AllergyItem.where(id: session[:allergy_item_ids]).pluck(:name)
      end
      free_word = params[:free_word]
      disliked_foods = params[:disliked_foods]
      @recipe = @open_ai_service.generate_recipe(params[:calories], allergies, disliked_foods, free_word)
      @translated_recipe = @deepl_service.translate(@recipe, "JA")

      parse_recipes(@translated_recipe)
    end
  end

  def show
    recipe_id = params[:id]
    deepl_service = DeepLService.new
    @recipe_details = SpoonacularService.fetch_recipe_information(recipe_id)
    if @recipe_details.nil?
      flash.now[:alert] = t('.fail')
    else
      @translated_description = deepl_service.translate(@recipe_details["summary"], "JA")
    end
  end

  def search;end

  def search_results
    deepl_service = DeepLService.new
    translated_queries = translate_queries(params[:query], deepl_service)
    @recipes = search_and_transform_recipes(translated_queries, deepl_service)
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
    breakfast_start = translated_recipe.index("朝")
    lunch_start = translated_recipe.index("昼")
    dinner_start = translated_recipe.index("夕") || translated_recipe.index("夜")

    breakfast = extract_meal(translated_recipe, breakfast_start, lunch_start)
    lunch = extract_meal(translated_recipe, lunch_start, dinner_start)
    dinner = extract_meal(translated_recipe, dinner_start, translated_recipe.length)

    [breakfast, lunch, dinner]
  end

  def extract_meal(recipe_text, start_index, end_index)
    return nil unless start_index
    recipe_text[start_index...end_index].strip
  end

  def set_services
    @open_ai_service = OpenAiService.new
    @deepl_service = DeepLService.new
  end

  def translate_queries(query_string, deepl_service)
    query_string.split(/,\s*/).map do |query|
      deepl_service.translate(query, "EN")
    end.reject(&:blank?)
  end

  def search_and_transform_recipes(queries, deepl_service)
    queries.each_with_object([]) do |query, recipes|
      response = SpoonacularService.search(query: query)
      next if response["error"]
      response["results"].each do |recipe|
        translated_title = deepl_service.translate(recipe["title"])
        recipes << {
          id: recipe["id"],
          title: translated_title,
          image: recipe["image"]
        }
      end
    end
  end
end
