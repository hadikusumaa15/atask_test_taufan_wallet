class TransactionsController < ApplicationController
  before_action :authenticate_user

  def create
    @wallet = Wallet.find(params[:wallet_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.wallet = @wallet

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount)
  end
end
