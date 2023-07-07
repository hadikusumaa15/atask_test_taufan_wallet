require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      let(:user) { create(:user) }

      before do
        session[:access_token] = user.access_token
        allow_any_instance_of(User).to receive(:access_token_expired_date).and_return(Time.now + 1.day)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the login page' do
        get :index
        expect(response.status).to eq 403
      end
    end
  end
end
