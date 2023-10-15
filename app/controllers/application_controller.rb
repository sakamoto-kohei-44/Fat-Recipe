class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    dashboard_home_path  # あるいは希望のパスを指定します
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
