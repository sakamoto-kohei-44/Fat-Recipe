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
end
