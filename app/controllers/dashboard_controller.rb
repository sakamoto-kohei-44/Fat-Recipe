class DashboardController < ApplicationController
  def index
    if logged_in?
      @chart_data = current_user.weight_logs.pluck(:date, :weight)  # ログインユーザーのweight_logsから体重と日付を取得
      @chart_data.map! do |data|
        [data[0].strftime("%Y/%m/%d"), data[1]]  # グラフに表示するためのデータ構造
      end
    else
      session[:weight]
      date = Time.zone.today
      value = session[:weight]
      @chart_data = [[date, value]]
    end
  end
end
