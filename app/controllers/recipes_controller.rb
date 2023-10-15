class RecipesController < ApplicationController
  require_dependency "#{Rails.root}/app/services/spoonacular_service"

  def index
    # current_userがnilの場合、デフォルトのユーザーオブジェクトを使用
    user = current_user || User.new(name: "Guest") # Guestユーザーを作成するなど、適切なデフォルトを設定

    # SpoonacularServiceを使用してレシピを取得
    @recipes = SpoonacularService.fetch_suitable_recipes(user)
  end

  def show
    @recipe = SpoonacularService.fetch_recipe_information(params[:id])
  end

  def search
  end

  def search_results
  end
end
