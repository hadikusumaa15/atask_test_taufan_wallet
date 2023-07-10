class ApplicationController < ActionController::Base
  def authenticate_user
    begin
      @current_user = User.find_active_user(access_token: session[:access_token])
    rescue StandardError => e
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def authorize_user
    authenticate_user
    redirect_to home_path unless @current_user
  end

  def current_user
    @current_user
  end
end
