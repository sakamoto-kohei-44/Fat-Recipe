class DashboardController < ApplicationController
  def index
    if logged_in?
      @chart_data = current_user.weight_logs.pluck(:date, :weight)
      @chart_data = current_user.weight_logs.pluck(:date, :weight)
      @chart_data.map! do |data|
        [data[0].strftime("%Y/%m/%d"), data[1]]
      end
    else
      weight = session[:weight]
      date = Date.today
      value = session[:weight]
      @chart_data = [[date, value]]
    end
  end
end
