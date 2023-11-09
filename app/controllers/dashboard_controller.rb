class DashboardController < ApplicationController
  def index
    if logged_in?
      @chart_data = current_user.weight_logs.pluck(:date, :weight)
    else
      weight = session[:weight]
      date = Date.today
      @chart_data = [weight, date]
    end
  end
end
