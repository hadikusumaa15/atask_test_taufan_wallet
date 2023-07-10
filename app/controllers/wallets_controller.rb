class WalletsController < ApplicationController
  before_action :authorize_user

  def index
    @wallet = current_user.wallet
    @transactions = Transaction.wallet_all_transactions(wallet: @wallet).paginate(:page => params[:page], per_page: 10).order('created_at DESC')
  end

  def show
    @wallet = Wallet.find(params[:id])
  end

  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render json: @wallet, status: :created
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def update
    @wallet = Wallet.find(params[:id])

    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet = Wallet.find(params[:id])
    @wallet.destroy

    render json: { message: "Wallet deleted" }
  end

  private

  def wallet_params
    params.require(:wallet).permit(:balance)
  end
end