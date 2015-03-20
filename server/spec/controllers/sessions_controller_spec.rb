describe SessionsController, type: :controller do
  include OmniauthHelper

  shared_examples 'omniauth callbacks' do
    before do
      OmniAuth.config.mock_auth[strategy] = auth_hash
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[strategy]
    end

    it 'succeeds at #create' do
      get :create
      expect(response).to have_http_status(:success)
    end

    it 'sets the user session at #create' do
      get :create

      expect(session[:user_id]).not_to be_nil
    end

    it 'redirects to #failure if the interactor calls #fail!' do
      request.env["omniauth.auth"] = nil

      get :create


      expect(response).to redirect_to(action: :failure)
    end

    it 'handles errors successfully at #failure' do
      OmniAuth.config.mock_auth[strategy] = :invalid_credentials
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[strategy]

      get :failure

      expect(response).to have_http_status(:success)
    end

    it 'destroys the user session at #destroy' do
      get :destroy

      expect(session[:user_id]).to be_nil
    end
  end

  describe 'omniauth login' do
    context 'with google_oauth2' do
      let(:user) { FactoryGirl.build(:user, :google) }
      let(:strategy) { :google_oauth2 }

      it_behaves_like 'omniauth callbacks'
    end

    context 'with facebook' do
      let(:user) { FactoryGirl.build(:user, :facebook) }
      let(:strategy) { :facebook }

      it_behaves_like 'omniauth callbacks'
    end
  end
end
