require "sorcery"
class ApplicationController < ActionController::Base
  include Sorcery::Controller
  helper_method :logged_in?

  def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end

  def current_user
    @current_user ||= user_class.find_by(id: session[:user_id])
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
end
