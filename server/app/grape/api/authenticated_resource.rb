module API
  module AuthenticatedResource
    extend Grape::API::Helpers

    def set_header_token
      user = current_user

      if user.present? && !user.visitor?
        # generates a new token if none are valid
        token = user.most_recent_token(headers['Client'] || 'wfdinner-app')

        header 'access-token', token.value
        header 'client', token.client
        header 'expiry', token.expiry
        header 'uid', token.uid
        header 'token-type', 'Bearer'
      else
        error!('401 Unauthorized', 401)
      end
    end

    alias_method :authenticate!, :set_header_token
  end
end
