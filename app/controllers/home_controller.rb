class HomeController < ApplicationController
  before_action :authenticate_user

  def index
    status = current_user ? 200 : 403

    respond_to do |format|
      format.html { render :index, status: status }
      format.json { render json: {status: status} }
    end
  end
end
