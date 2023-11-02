class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end