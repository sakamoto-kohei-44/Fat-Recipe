class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[edit update]

  def show;end

  def edits
    @user = User.find(current_user.id)
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :gender, :age, :goal, :height, :weight, :target_weight, :activity_level, :avatar, :avatar_cache)
  end
end
