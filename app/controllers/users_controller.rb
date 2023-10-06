class UsersController < ApplicationController
  def body_info
    @user = User.find(params[:id]) # idはURLのパラメーターから取得することを想定しています
    if @user.update(user_params)
      # 成功した場合の処理
      redirect_to some_path, notice: "体の情報を更新しました"
    else
      # 失敗した場合の処理
      render 'users/body_info'
    end
  end

  def gender_age
  end

  def height_weight_goal
  end

  def activity_level
  end

  def allergies
  end

  def edit_profile
  end

  def edit_account
  end
end
