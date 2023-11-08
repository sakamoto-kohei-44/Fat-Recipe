class DashboardController < ApplicationController
  def index
    @user = current_user
    # ユーザーの体重記録を取得
    @weight_logs = @user.weight_logs
    # グラフ用データを作成
    @weight_data = @weight_logs.pluck(:date, :weight)
  end
end
