require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  let!(:transaction) {create(:transaction)}
  let(:user) { transaction.target_wallet.walletable}

  before do
    session[:access_token] = user.access_token
  end

  describe 'GET index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns the indices_list' do
      get :index
      expect(assigns(:indices_list)).to eq(LatestStockPrice.indices_list)
    end
  end

  describe 'POST create' do
    it 'creates a new transaction' do
      expect do
        post :create, params: {
          price: 100,
          quantity: 1,
          identifier: 'NIFTY 50',
          indices: 'NIFTY TEST'
        }
      end.to change(Transaction, :count).by(1)
    end

    it 'flashes a success message' do
      post :create, params: {
        price: 100,
        quantity: 1,
        identifier: 'NIFTY 50',
        indices: 'NIFTY TEST'
      }
      expect(flash[:notice]).to eq('Transaction success!')
    end

    context 'when the transaction fails' do
      it 'does not create a new transaction' do
        expect do
          post :create, params: {
            price: user.wallet.balance + 100_000,
            quantity: 1,
            identifier: 'NIFTY 50',
            indices: 'NIFTY TEST'
          }
        end.not_to change(Transaction, :count)
      end

      it 'flashes an error message' do
        post :create, params: {
          price: user.wallet.balance + 100_000,
          quantity: 1,
          identifier: 'NIFTY 50',
          indices: 'NIFTY TEST'
        }
        expect(flash[:alert]).to eq('Insufficient balance')
      end
    end
  end
end
