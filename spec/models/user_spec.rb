require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(username: 'username_x') }
  let(:valid_user) { create(:user) }

  describe 'validations' do
    context 'when valid attributes' do
      it 'is valid' do
        user = User.new(username: 'my_username', access_token: '999777', password: 'my_password')

        expect(user).to be_valid
      end
    end

    context 'when password is invalid' do
      it 'is invalid' do
        user = User.new(username: 'my_username', access_token: '999777')

        expect(user).to be_invalid
        expect(user.errors.messages[:password]).to include "can't be blank"
        expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
      end
    end

    context 'when username is invalid' do
      it 'is invalid' do
        user_2 = User.new(username: valid_user.username)
        user_3 = User.new(username: nil)

        expect(user_2).to be_invalid
        expect(user_3).to be_invalid
        expect(user_2.errors.messages[:username]).to include "has already been taken"
        expect(user_3.errors.messages[:username]).to include "can't be blank"
        expect(user_3.errors.messages[:username]).to include "is too short (minimum is 6 characters)"
      end
    end
  end

  describe 'associations' do
    it 'has one wallet' do
      wallet = create(:wallet, walletable: valid_user)

      expect(valid_user.wallet).to eq(wallet)
    end
  end
end
