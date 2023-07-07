require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let!(:user) { create(:user, username: 'my_normal_username', password: 'password') }

    context 'with valid credentials' do
      it 'sets the access_token in session' do
        post :create, params: { username: 'my_normal_username', password: 'password' }
        expect(session[:access_token]).to eq(user.reload.access_token)
      end

      it 'redirects to the root path' do
        post :create, params: { username: 'my_normal_username', password: 'password' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not set the access_token in session' do
        post :create, params: { username: 'my_normal_username', password: 'wrong_password' }
        expect(session[:access_token]).to be_nil
      end

      it 'renders the login form' do
        post :create, params: { username: 'my_normal_username', password: 'wrong_password' }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    before do
      session[:access_token] = user.access_token
    end

    it 'clears the user_id from session' do
      delete :destroy
      expect(session[:access_token]).to be_nil
    end

    it 'redirects to the root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
