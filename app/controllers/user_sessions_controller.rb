class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      user = User.find(session[:user_id])
      session[:goal] = user.goal
      session[:gender] = user.gender
      session[:age] = user.age
      session[:height] = user.height
      session[:weight] = user.weight
      session[:target_weight] = user.target_weight
      session[:activity_level] = user.activity_level
      session[:allergy_item_ids] = user.allergy_item_ids
      session[:bmr] = user.bmr
      session[:tdee] = user.tdee
      session[:target_calorie] = user.target_calorie
      redirect_back_or_to dashboard_home_path, notice: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    reset_session
    redirect_to root_path, notice: t('.success')
  end
end