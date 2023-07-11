class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username], password: params[:password])

    if user
      user.generate_access_token
      session[:access_token] = user.access_token

      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Logged in successfully' }
        format.json { render json: { status: 'success', message: 'Logged in successfully' } }
      end
    else
      flash.alert = 'Invalid username or password'

      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: { status: 'error', message: 'Invalid username or password' }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:access_token] = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Logged out successfully' }
      format.json { render json: { status: 'success', message: 'Logged out successfully' } }
    end
  end
end
