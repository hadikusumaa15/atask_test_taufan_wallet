class TransactionsController < ApplicationController
  before_action :authorize_user

  def new
    @my_wallets = Wallet.where(id: my_wallet_ids)
    @target_wallets = Wallet.where.not(id: current_user.wallet&.id)
    @transaction = Transaction.new

    respond_to do |format|
      format.json { render json: { target_wallets: @target_wallets, my_wallets: @my_wallets } }
      format.html { render :new }
    end
  end

  def create
    @transaction = Transaction.new(
      target_wallet: Wallet.find(transaction_params[:target_wallet]),
      source_wallet: Wallet.find(transaction_params[:source_wallet]),
      description: transaction_params[:description]
      amount: transaction_params[:amount],
    )

    if @transaction.save
      respond_to do |format|
        format.json { render json: { message: 'Transaction success!' } }
        format.html { redirect_back fallback_location: root_path,notice: 'Transaction success!' }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @transaction.errors.full_messages.join(', ') }, status: :unprocessable_entity }
        format.html { redirect_back fallback_location: root_path, alert: @transaction.errors.full_messages.join(', ') }
      end
    end
  end

  private

  def my_wallet_ids
    return [current_user.wallet&.id, current_user.team&.wallet&.id] if current_user.is_team_admin

    [current_user.wallet&.id]
  end

  def transaction_params
    params.require(:transaction).permit(:source_wallet, :target_wallet, :amount, :description)
  end
end
