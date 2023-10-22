class RecipesController < ApplicationController
  require_dependency "#{Rails.root}/app/services/spoonacular_service"

  def index
    # セッションからユーザー情報を取得
    user_calorie = session[:target_calorie]
    response = SpoonacularService.generate_meal_plan(
      timeFrame: 'day',
      targetCalories: user_calorie
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
  end
end
