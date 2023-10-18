class RecipesController < ApplicationController
  require_dependency "#{Rails.root}/app/services/spoonacular_service"

  def index
    user = current_user || User.new(name: "Guest")
    cache_key = "meal_plan_for_user_#{user.id || 'guest'}"
    @meal_plan = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      SpoonacularService.generate_meal_plan
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
