module API
  class Auth < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers
    helpers AuthenticatedResource

    desc 'Handles application authorization via OmniAuth'
    namespace :auth do

      desc 'OmniAuth for Facebook'
      get 'validate_token' do
        authenticate!

        render current_user, root: :data
      end

      desc 'Sign out'
      delete 'sign_out' do
        authenticate_without_tokens!

        if current_user
          current_user.expire_all_tokens!
        end
      end
    end
  end
end
