class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.age = session[:age]
    @user.height = session[:height]
    @user.weight = session[:weight]
    if @user.valid?
      logger.debug("validation passed")
    else
      logger.debug("validation failed")
      logger.debug(@user.errors.full_messages)
    end
    if @user.save!
      redirect_to login_path
    else
      # エラーメッセージ表示
      messages = @user.errors.full_messages
      flash[:alert] = "登録に失敗しました。#{messages.join(",")}"
      redirect_to new_user_path
    end
  end
  # 定数
  KG_TO_CAL = 7700 # 1kg増加に必要なカロリー

  def body_info
  end

  def save_goal
    session[:user_goal] = params[:goal]
    redirect_to gender_age_users_path, notice: '目標が正常に保存されました。'
  end

  def gender_age
  end

  def save_gender_age
    if gender_age_params[:gender].present? && gender_age_params[:age].present?
      session[:gender] = gender_age_params[:gender]
      session[:age] = gender_age_params[:age]
      redirect_to height_weight_target_weight_users_path, notice: "性別と年齢が正常に保存されました。"
    else
      render :gender_age, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def height_weight_target_weight
  end

  def save_height_weight_target_weight
    if height_weight_target_weight_params[:height].present? && height_weight_target_weight_params[:weight].present? && height_weight_target_weight_params[:target_weight].present?
      session[:height] = height_weight_target_weight_params[:height]
      session[:weight] = height_weight_target_weight_params[:weight]
      session[:target_weight] = height_weight_target_weight_params[:target_weight]
      redirect_to activity_level_users_path, notice: "正常に保存されました。"
    else
      render :height_weight_target_weight, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def activity_level
  end

  def save_activity_level
    if activity_level_params[:activity_level].present?
      session[:activity_level] = activity_level_params[:activity_level]

      # 基礎代謝(BMR)とTDEEの計算
      gender = session[:gender]
      age = session[:age].to_i
      height = session[:height].to_i
      weight = session[:weight].to_i
      activity_level = session[:activity_level]

      bmr = calculate_bmr(gender, age, height, weight)
      tdee = calculate_tdee(bmr, activity_level)

      session[:bmr] = bmr
      session[:tdee] = tdee

      # 目標カロリーの計算
      target_weight = session[:target_weight].to_i
      target_diff = (target_weight - weight)
      total_calorie = target_diff * KG_TO_CAL
      days_to_achieve = 60 # 例として30日で達成するとする
      calorie_per_day = total_calorie / days_to_achieve
      target_calorie = tdee + calorie_per_day

      session[:target_calorie] = target_calorie
      # ユーザー属性をマージ
    user_data = {
      gender: session[:gender],
      age: session[:age],
      height: session[:height],
      target_calorie: target_calorie
    }

    # セッション保存
    session[:user_data] = user_data
      redirect_to allergies_users_path, notice: "活動レベルが正常に保存されました。"
    else
      render :activity_level, alert: "活動レベルの保存に失敗しました。選択してください。"
    end
  end

  def allergies
  end

  def save_allergies
    if allergies_params[:allergy_item_ids]&.reject(&:blank?).present?
      # アレルギーなしのIDをチェック (例として1を使用)
      if allergies_params[:allergy_item_ids].include?("39")
        session[:allergy_item_ids] = ["39"]
      else
        session[:allergy_item_ids] = allergies_params[:allergy_item_ids]
      end
      redirect_to dashboard_home_path, notice: "アレルギー項目が正常に保存されました。"
    else
      render :allergies, alert: "アレルギー項目を選択してください。"
    end
  end

  def edit_profile
  end

  def update_profile
  end

  def edit_account
  end

  def update_account
  end

  def show
  end

  private

  def set_skip_special_validation
    # 空メソッド
  end

  def calculate_bmr(gender, age, height, weight)
    if gender == "man"
      bmr = 66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)
    else
      bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
    end
    bmr
  end

  def calculate_tdee(bmr, activity_level)
    case activity_level
    when "低い","low"
      tdee = bmr * 1.2
    when "普通","moderate"
      tdee = bmr * 1.55
    when "高い","high"
      tdee = bmr * 1.9
    end
    tdee
  end

  def calculate_macros(tdee, weight)
    protein_per_kg = 1.5  # これは1.5g〜2.0gの間で調整可能
    protein_calories = protein_per_kg * weight * 4  # タンパク質1gあたり4kcal
    fat_calories = tdee * 0.25  # 25%の脂質、これも20〜35%の間で調整可能
    carb_calories = tdee - (protein_calories + fat_calories)
    {
      protein: protein_calories / 4,  # タンパク質のg数
      fat: fat_calories / 9,  # 脂質のg数（1gの脂質は9kcal）
      carbs: carb_calories / 4  # 炭水化物のg数
    }
  end

  def user_goal_params
    params.permit(:goal)
  end

  def gender_age_params
    params.permit(:gender, :age)
  end

  def height_weight_target_weight_params
    params.permit(:height, :weight, :target_weight)
  end

  def activity_level_params
    params.permit(:activity_level)
  end

  def allergies_params
    params.permit(allergy_item_ids: [])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
