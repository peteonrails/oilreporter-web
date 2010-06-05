class UserSessionsController < ApplicationController
  def new
    add_crumb "admin", '/admin'
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:fancy] = "Login successful!"
      redirect_back_or_default admin_home_url
    else
      flash[:error] = "Login failed, please try again."
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:fancy] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end