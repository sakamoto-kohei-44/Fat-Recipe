require "sorcery"
class ApplicationController < ActionController::Base
  include Sorcery::Controller
  helper_method :logged_in?
  KG_TO_CAL = 7700

  def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end

  def current_user
    @current_user ||= user_class.find_by(id: session[:user_id])
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
