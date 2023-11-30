class UsersController < ApplicationController

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    if @user.save
      session[:user_id] = @user.id
      @weight_log = @user.weight_logs.create(weight: @user.weight, date: Time.zone.today)
      redirect_to dashboard_home_path, notice: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render new_user_path, status: :unprocessable_entity
    end
  end

  def body_info
    @goal_form = GoalForm.new
  end

  def goal
  end

  def save_goal
    @goal_form = GoalForm.new(goal: goal_params[:goal])
    if @goal_form.valid?
      session[:goal] = goal_params[:goal]
      redirect_to gender_age_users_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :body_info, status: :unprocessable_entity
    end
  end

  def gender_age
  end

  def save_gender_age
    @gender_age_form = GenderAgeForm.new(gender_age_params)
    if @gender_age_form.valid?
      session[:gender] = @gender_age_form.gender
      session[:age] = @gender_age_form.age
      redirect_to height_weight_target_weight_users_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :gender_age, status: :unprocessable_entity
    end
  end

  def height_weight_target_weight
  end

  def save_height_weight_target_weight
    @height_weight_form = HeightWeightTargetWeightForm.new(height_weight_target_weight_params)
    if @height_weight_form.valid?
      session[:height] = @height_weight_form.height
      session[:weight] = @height_weight_form.weight
      session[:target_weight] = @height_weight_form.target_weight
      redirect_to activity_level_users_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :height_weight_target_weight, status: :unprocessable_entity
    end
  end

  def activity_level
  end

  def save_activity_level
    @activity_level_form = ActivityLevelForm.new(activity_level_params)
    if @activity_level_form.valid?
      gender = session[:gender]
      age = session[:age].to_i
      height = session[:height].to_i
      weight = session[:weight].to_i
      bmr = calculate_bmr(gender, age, height, weight)
      tdee = calculate_tdee(bmr, activity_level_params[:activity_level])
      session[:bmr] = bmr
      session[:tdee] = tdee
      session[:activity_level] = activity_level_params[:activity_level]
      target_weight = session[:target_weight].to_i
      target_diff = (target_weight - weight)
      total_calorie = target_diff * KG_TO_CAL
      days_to_achieve = 90
      calorie_per_day = total_calorie / days_to_achieve
      target_calorie = tdee + calorie_per_day

      session[:target_calorie] = target_calorie
    user_data = {
      gender: session[:gender],
      age: session[:age],
      height: session[:height],
      target_calorie: target_calorie
    }
    session[:user_data] = user_data
      redirect_to allergies_users_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :activity_level, status: :unprocessable_entity
    end
  end

  def allergies
  end

  def save_allergies
    @allergies_form = AllergiesForm.new(allergies_params)
    if @allergies_form.valid?
      if allergies_params[:allergy_item_ids].include?("39")
        session[:allergy_item_ids] = ["39"]
      else
        session[:allergy_item_ids] = allergies_params[:allergy_item_ids]
      end
        session[:allergy_item_ids] = allergies_params[:allergy_item_ids]
      redirect_to confirmation_users_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :allergies, status: :unprocessable_entity
    end
  end

  def confirmation
    @user = User.new(session[:user_data])
    @goal = session[:goal]
    @gender_key = session[:gender]
    @age = session[:age]
    @height = session[:height]
    @weight = session[:weight]
    @target_weight = session[:target_weight]
    @activity_level_key = session[:activity_level]
    @allergy_names = AllergyItem.where(id: session[:allergy_item_ids]).pluck(:name).join(",") if session[:allergy_item_ids].present?
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
