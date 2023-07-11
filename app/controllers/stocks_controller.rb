class StocksController < ApplicationController
  before_action :authorize_user

  require 'uri'
  require 'net/http'

  def index
    @indices_list = LatestStockPrice.indices_list
    @stocks = WillPaginate::Collection.create(page, 10, selected_stocks.length) do |pager|
      start = (pager.current_page - 1) * pager.per_page
      pager.replace(selected_stocks[start, pager.per_page])
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        raise 'Insufficient balance' if (params[:price].to_f * params[:quantity].to_f) > source_wallet.current_balance

        records = []

        params[:quantity].to_i.times do
          records << {
            source_wallet: source_wallet,
            target_wallet: target_wallet,
            amount: params[:price],
            description: "Buy '#{params[:identifier]}' Stock"
          }
        end

        @transactions = Transaction.create(records)
        message = @transactions.pluck(:errors).compact.blank? ? {notice: 'Transaction success!'} : {alert: @transaction.errors.full_messages.join(', ')}

        redirect_back fallback_location: root_path, notice: message[:notice], alert: message[:alert]
      end
    rescue => e
      redirect_back fallback_location: root_path, alert: e.message
    end
  end

  private

  def page
    params[:page] || 1 rescue 1
  end

  def source_wallet
    current_user.wallet
  end

  def target_wallet
    wallet = current_user.stocks&.find_by(identifier: params[:identifier], indices: params[:indices])&.wallet
    wallet = Wallet.generate_new_stock_wallet(
      user: current_user, indices: params[:indices],
      identifier: params[:identifier]
    ) unless wallet.present?

    wallet
  end

  def selected_stocks
    begin
      return LatestStockPrice.price(indices: params[:indices], identifier: params[:identifier]) if params[:indices].present? && params[:identifier].present?
      return LatestStockPrice.price_all if params[:indices] == 'ALL'
      return LatestStockPrice.prices(indices: params[:indices]) if params[:indices].present?
      []
    rescue
      flash.alert = 'Stock Unavailable, please try again later.'
      []
    end
  end
end
