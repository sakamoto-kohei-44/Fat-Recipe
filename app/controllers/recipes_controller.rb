class RecipesController < ApplicationController
  require_dependency "#{Rails.root.join('app/services/spoonacular_service')}"

  def index
    # ユーザー情報を取得
    if current_user
      target_calorie = current_user.target_calorie
    else
      target_calorie = session[:target_calorie]
    end
    response = SpoonacularService.generate_meal_plan(
      timeFrame: 'day',
      targetCalories: target_calorie,
      cuisine: "japanese"
    )
    logger.debug(response)
    meals = response["meals"]
    @recipes_info = meals
    @meal_plan = response
    @meal_plan["meals"].each do |meal|
      # 翻訳処理
      translated_title = SpoonacularService.translate_text(
        text: meal["title"],
        from_language: "en",
        to_language: "ja"
      )
      meal["title"] = translated_title
    end
  end

  def show
    cache_key = "recipe_info_#{params[:id]}"
    @recipe = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      SpoonacularService.fetch_recipe_information(params[:id])
    end
  end

  def search
  end

  def search_results
    queries = params[:query].split(/,\s*/)
    @recipes = []
    queries.each do |query|
      translated_query = SpoonacularService.translate_text(
        text: query,
        from_language: "ja",
        to_language: "en"
      )
      response = SpoonacularService.search(query: translated_query)
      if response["error"]
        logger.error "Response body: #{response.body}"
      end
      response["results"].each do |recipe|
        @recipes << {
          id: recipe["id"],
          title: recipe["title"],
          image: recipe["image"]
        }
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
