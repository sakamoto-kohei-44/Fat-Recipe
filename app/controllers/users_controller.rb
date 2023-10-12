class UsersController < ApplicationController

  def body_info
  end

  def save_goal
    session[:user_goal] = params[:goal]
    redirect_to gender_age_users_path, notice: '目標が正常に保存されました。'
  end

  def create
    @user = User.new(user_params)
    @user.goal = session[:user_goal]
    if @user.save
      session.delete(:user_goal)
      redirect_to root_path, notice: 'ユーザー情報が正常に保存されました。'
    else
      render :new
    end
  end

  def gender_age
  end

  def save_gender_age
    if user_params
      session[:gender] = user_params[:gender]
      session[:age] = user_params[:age]
      redirect_to height_weight_target_weight_users_path, notice: "性別と年齢が正常に保存されました。"
    else
      render :gender_age, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def height_weight_target_weight
  end

  def save_height_weight_target_weight
    if user_params[:height].present? && user_params[:weight].present? && user_params[:target_weight].present?
      session[:height] = user_params[:height]
      session[:weight] = user_params[:weight]
      session[:target_weight] = user_params[:target_weight]
      redirect_to activity_level_users_path, notice: "正常に保存されました。"
    else
      render :height_weight_target_weight, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def activity_level
  end

  def save_activity_level
    if user_params[:activity_level].present?
      session[:activity_level] = user_params[:activity_level]
      # 基礎代謝（BMR）とTDEEの計算
      gender = session[:gender]
      age = session[:age].to_i
      height = session[:height].to_i
      weight = session[:weight].to_i

      activity_level = session[:activity_level]
      bmr = calculate_bmr(gender, age, height, weight)
      tdee = calculate_tdee(bmr, activity_level)
      session[:bmr] = bmr
      session[:tdee] = tdee

      tdee = calculate_tdee(bmr, activity_level)
      macros = calculate_macros(tdee, weight)
      session[:protein] = macros[:protein]
      session[:fat] = macros[:fat]
      session[:carbs] = macros[:carbs]

      redirect_to allergies_users_path, notice: "活動レベルが正常に保存されました。"
    else
      render :activity_level, alert: "活動レベルの保存に失敗しました。選択してください。"
    end
  end

  def allergies
  end

  def save_allergies
    if user_params[:allergy_item_ids]&.reject(&:blank?).present?
      session[:allergy_item_ids] = user_params[:allergy_item_ids]
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
    when "ほとんど活動しない", "low"
      tdee = bmr * 1.2
    when "中程度の活動", "moderate"
      tdee = bmr * 1.55
    when "激しい活動", "high"
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

  def user_params
    params.permit(:age, :gender, :goal, :email, :password, :name, :height, :weight, :activity_level, :target_weight, :authenticity_token, :commit, allergy_item_ids: [])
  end
end

