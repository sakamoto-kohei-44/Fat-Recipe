# PagesControllerはアプリケーション内の静的なページを扱うコントローラです。
# ホームページやダッシュボードなどの表示を制御します。
class PagesController < ApplicationController
  def home
    @resource = User.new
    @resource_name = :user
  end

  def dashboard
  end
end
