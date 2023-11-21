class RecipesController < ApplicationController
  def index
    if params[:calories].present?
      open_ai_service = OpenAiService.new
      @recipe = open_ai_service.generate_recipe(params[:calories])
    else
      @recipe = nil
    end
  end
end
