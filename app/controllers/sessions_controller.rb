class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username], password: params[:password])

    if user
      user.generate_access_token
      session[:access_token] = user.access_token
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash.alert = 'Invalid username or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:access_token] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
