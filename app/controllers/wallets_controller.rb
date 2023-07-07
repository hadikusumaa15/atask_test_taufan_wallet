class WalletsController < ApplicationController
  def index
    @wallets = Wallet.all
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