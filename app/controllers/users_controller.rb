class UsersController < ApplicationController

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # sessionから値を取り出す
    @user.goal = session[:goal]
    @user.gender = session[:gender]
    @user.age = session[:age]
    @user.height = session[:height]
    @user.weight = session[:weight]
    @user.target_weight = session[:target_weight]
    @user.activity_level = session[:activity_level]
    @user.allergy_item_ids = session[:allergy_item_ids]
    @user.tdee = session[:tdee]
    @user.bmr = session[:bmr]
    @user.target_calorie = session[:target_calorie]
    if @user.save!
      session[:user_id] = @user.id
      redirect_to dashboard_home_path
    else
      # エラーメッセージ表示
      messages = @user.errors.full_messages
      flash[:alert] = "登録に失敗しました。#{messages.join(",")}"
      redirect_to new_user_path
    end
  end

  def goal
  end

  def save_goal
    if goal_params[:goal].present?
      session[:goal] = params[:goal]
      redirect_to gender_age_users_path, notice: '目標が正常に保存されました。'
    else
      render :goal, alert: "保存できませんでした。入力内容を確認してください。"
    end
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
      # session値の取得
      gender = session[:gender]
      age = session[:age].to_i
      height = session[:height].to_i
      weight = session[:weight].to_i
      # bmrとtdeeを計算
      bmr = calculate_bmr(gender, age, height, weight)
      tdee = calculate_tdee(bmr, activity_level_params[:activity_level])
      # sessionに保存
      session[:bmr] = bmr
      session[:tdee] = tdee
      # activity_levelの保存
      session[:activity_level] = activity_level_params[:activity_level]
      # 目標カロリーの計算
      target_weight = session[:target_weight].to_i
      target_diff = (target_weight - weight)
      total_calorie = target_diff * KG_TO_CAL
      days_to_achieve = 90
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

  def edit_account
  end

  def update_account
  end

  private

  def set_skip_special_validation
  end

  def goal_params
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
