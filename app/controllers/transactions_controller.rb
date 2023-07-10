class TransactionsController < ApplicationController
  before_action :authenticate_user

  def new
    @transaction = Transaction.new
    @wallets = Wallet.where.not(id: current_user.wallet&.id)
  end

  def create
    @transaction = Transaction.new(
      source_wallet: current_user.wallet,
      target_wallet: Wallet.find(transaction_params[:target_wallet]),
      amount: transaction_params[:amount],
      description: transaction_params[:description]
    )

    if @transaction.save
      redirect_to wallets_path, notice: 'Transaction success!'
    else
      byebug
      redirect_to wallets_path, alert: @transaction.errors.full_messages.join(', ')
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:source_wallet, :target_wallet, :amount, :description )
  end
end
