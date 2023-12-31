class TeamsController < ApplicationController
  before_action :authorize_user

  def index
    @wallet = current_user.team.wallet
    @transactions = Transaction.wallet_all_transactions(wallet: @wallet).paginate(page: params[:page], per_page: 10).order('created_at DESC')

    respond_to do |format|
      format.json { render json: { wallet: @wallet, transactions: @transactions } }
      format.html { render :index }
    end
  end
end
