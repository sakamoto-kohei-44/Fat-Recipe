class UsersController < ApplicationController

  def body_info
  end

  def save_goal
    # セッションに目標を保存
    session[:user_goal] = params[:goal]
    redirect_to users_gender_age_path, notice: '目標が正常に保存されました。'
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
      redirect_to users_height_weight_target_weight_path, notice: "性別と年齢が正常に保存されました。"
    else
      render :gender_age, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def height_weight_target_weight
  end

  def save_height_weight_target_weight
    # 必要なパラメータがすべて存在するか確認
    if user_params[:height].present? && user_params[:weight].present? && user_params[:target_weight].present?
      session[:height] = user_params[:height]
      session[:weight] = user_params[:weight]
      session[:target_weight] = user_params[:target_weight]
      redirect_to users_activity_level_path, notice: "正常に保存されました。"
    else
      render :height_weight_target_weight, alert: "保存できませんでした。入力内容を確認してください。"
    end
  end

  def activity_level
  end

  def save_activity_level
    # activity_levelパラメータが存在するか確認
    if user_params[:activity_level].present?
        session[:activity_level] = user_params[:activity_level]
        redirect_to users_allergies_path, notice: "活動レベルが正常に保存されました。"
    else
        render :activity_level, alert: "活動レベルの保存に失敗しました。選択してください。"
    end
  end

  def allergies
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

  def user_goal_params
    params.permit(:goal)
  end

  def user_params
    params.permit(:age, :gender, :goal, :email, :password, :name, :height, :weight, :activity_level, :target_weight, :authenticity_token, :commit)
  end
end
