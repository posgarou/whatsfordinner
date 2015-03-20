module API
  class Auth < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers
    helpers AuthenticatedResource

    desc 'Handles application authorization via OmniAuth'
    namespace :auth do

      before do
        authenticate!
      end

      desc 'OmniAuth for Facebook'
      get 'validate_token' do
        if !current_user.visitor?
          present current_user, using: User::Entity
        else
          error!('401 Unauthorized', 401)
        end
      end

      desc 'Sign out'
      get 'sign_out' do

      end
    end
  end
end
