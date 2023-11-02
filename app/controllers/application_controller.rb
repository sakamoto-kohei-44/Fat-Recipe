require "sorcery"
class ApplicationController < ActionController::Base
  include Sorcery::Controller
  helper_method :logged_in?

  def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end
end
