class TransactionsController < ApplicationController
  before_action :authorize_user

  def new
    @transaction = Transaction.new
    @target_wallets = Wallet.where.not(id: current_user.wallet&.id)
    @my_wallets = Wallet.where(id: my_wallet_ids)
  end

  def create
    @transaction = Transaction.new(
      source_wallet: Wallet.find(transaction_params[:source_wallet]),
      target_wallet: Wallet.find(transaction_params[:target_wallet]),
      amount: transaction_params[:amount],
      description: transaction_params[:description]
    )

    if @transaction.save
      redirect_back fallback_location: root_path, notice: 'Transaction success!'
    else
      redirect_back fallback_location: root_path, alert: @transaction.errors.full_messages.join(', ')
    end
  end

  private

  def my_wallet_ids
    return [current_user.wallet&.id, current_user.team&.wallet&.id] if current_user.is_team_admin

    [current_user.wallet&.id]
  end

  def transaction_params
    params.require(:transaction).permit(:source_wallet, :target_wallet, :amount, :description )
  end
end
