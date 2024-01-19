class RegistrationService
  KG_TO_CAL = 7700

  def initialize(activity_level_form, session)
    @activity_level_form = activity_level_form
    @session = session
  end

  def process_registration
    gender = @session[:gender]
    age = @session[:age].to_i
    height = @session[:height].to_i
    weight = @session[:weight].to_i
    bmr = calculate_bmr(gender, age, height, weight)
    tdee = calculate_tdee(bmr, @activity_level_form.activity_level)

    @session[:bmr] = bmr
    @session[:tdee] = tdee
    @session[:activity_level] = User.activity_levels[@activity_level_form.activity_level]

    target_weight = @session[:target_weight].to_i
    weight_diff = target_weight - weight
    total_calorie_diff = weight_diff * KG_TO_CAL
    days_to_achieve = 90
    daily_calorie_change = total_calorie_diff / days_to_achieve
    target_calorie = tdee + daily_calorie_change
    @session[:target_calorie] = target_calorie
    case @session[:goal]
    when "standard"
      process_standard_body(target_weight, weight_diff)
    when "slim_muscle"
      process_slim_muscle(target_weight, weight_diff)
    end
  end

  private

  def process_standard_body(target_weight, weight_diff)
    # 標準体型の場合の日々のカロリー目標を設定
    # 現在の体重を維持するためのカロリー量
    daily_calorie_target = @session[:tdee] + 200
    @session[:target_calorie] = daily_calorie_target
  end

  def process_slim_muscle(target_weight, weight_diff)
    # 細マッチョの場合の計算
    # 例: TDEEより少し多めのカロリー摂取、高タンパク質の食事計画
    increased_calorie_target = @session[:tdee] + 400
    @session[:target_calorie] = increased_calorie_target
  end

  def calculate_bmr(gender, age, height, weight)
    if gender == "man"
      66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)
    else
      655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
    end
  end

  def calculate_tdee(bmr, activity_level)
    case activity_level
    when "低い", "low"
      tdee = bmr * 1.2
    when "普通", "moderate"
      tdee = bmr * 1.55
    when "高い", "high"
      tdee = bmr * 1.9
    end
    tdee
  end
end
