class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to login_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)  # トークンを使用して、関連するユーザーを検索
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?

    @user.skip_special_validation = true
    @user.password_confirmation = params[:user][:password_confirmation]
    new_password = params[:user][:password]
    if new_password.blank?
      flash.now[:danger] = t('.fail_password_change1')
      render :edit and return
    end
    # 新しいパスワードが有効な場合パスワードを更新
    if @user.change_password(new_password)
      redirect_to login_path, notice: t('.success_password_change')
    else
      flash.now[:danger] = t('.fail_password_change')
      render :edit, status: :unprocessable_entity
    end
  end
end
