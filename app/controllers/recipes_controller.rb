class RecipesController < ApplicationController
  require_dependency "#{Rails.root.join('app/services/spoonacular_service')}"

  def index
    # ユーザー情報を取得
    if current_user
      target_calories = current_user.target_calorie
    else
      target_calories = session[:target_calorie]
    end
    logger.debug("target_calories: #{target_calories}")
    response = SpoonacularService.generate_meal_plan(
      timeFrame: 'day',
      targetCalories: target_calories,
      cuisine: 'Italian'
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
