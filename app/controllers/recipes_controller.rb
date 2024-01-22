class RecipesController < ApplicationController
  before_action :set_services
  # カロリー数値が空ではないかチェック
  def index
    if params[:calories].blank?
      flash.now[:alert] = t('.fail')
      render 'recipe_suggestions/index'
      nil
    else
      allergies = []
      if session[:allergy_item_ids].present?
        allergies = AllergyItem.where(id: session[:allergy_item_ids]).pluck(:name)  # AllergyItem モデルからIDに該当するアレルギー項目を検索し、その名前を配列で取得
      end
      free_word = params[:free_word]
      disliked_foods = params[:disliked_foods]
      @recipe = @open_ai_service.generate_recipe(params[:calories], allergies, disliked_foods, free_word)
      @translated_recipe = @deepl_service.translate(@recipe, "JA")

      parse_recipes(@translated_recipe)  # 朝食、昼食、夕食の各セクションを抽出
    end
  end

  def show
    recipe_id = params[:id]
    deepl_service = DeepLService.new
    @recipe_details = SpoonacularService.fetch_recipe_information(recipe_id)  # IDのレシピの詳細情報を取得
    if @recipe_details.nil?
      flash.now[:alert] = t('.fail')
    else
      @translated_description = deepl_service.translate(@recipe_details["summary"], "JA")  # 日本語に翻訳
    end
  end

  def search;end

  def search_results
    deepl_service = DeepLService.new
    translated_queries = translate_queries(params[:query], deepl_service)  # ユーザーが入力した検索クエリを英語に翻訳
    @recipes = search_and_transform_recipes(translated_queries, deepl_service)  # 翻訳されたクエリに基づいてレシピを検索し結果を変換
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
    breakfast_start = translated_recipe.index("朝")  # 各単語のインデックスで検索
    lunch_start = translated_recipe.index("昼")
    dinner_start = translated_recipe.index("夕") || translated_recipe.index("夜")

    breakfast = extract_meal(translated_recipe, breakfast_start, lunch_start)  # レシピのテキストから朝食、昼食、夕食の各部分を抽出しローカル変数に格納
    lunch = extract_meal(translated_recipe, lunch_start, dinner_start)
    dinner = extract_meal(translated_recipe, dinner_start, translated_recipe.length)

    [breakfast, lunch, dinner]
  end

  def extract_meal(recipe_text, start_index, end_index)  # start_index と end_index の間のテキストを抽出し見つからなければnilを返す
    return nil unless start_index
    recipe_text[start_index...end_index].strip
  end

  def set_services
    @open_ai_service = OpenAiService.new  # APIサービスを利用する準備
    @deepl_service = DeepLService.new
  end

  def translate_queries(query_string, deepl_service)
    query_string.split(/,\s*/).map do |query|  # クエリ文字列を個別の検索語に分割
      deepl_service.translate(query, "EN")  # 各クエリに対して英語に翻訳
    end.reject(&:blank?)
  end

  def search_and_transform_recipes(queries, deepl_service)
    queries.each_with_object([]) do |query, recipes|
      response = SpoonacularService.search(query: query)  # 各翻訳されたクエリに基づいてレシピを検索
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
