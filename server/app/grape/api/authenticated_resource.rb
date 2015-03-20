module API
  module AuthenticatedResource
    extend Grape::API::Helpers

    def ensure_valid_user
      Rails.logger.debug 'AuthenticatedResource#ensure_valid_user'
      user = current_user

      unless user.present? && !user.visitor?
        error!('401 Unauthorized', 401)
      end
    end

    def set_header_token
      Rails.logger.debug 'AuthenticatedResource#set_header_token'
      user = current_user

      # generates a new token if none are valid
      token = user.most_recent_token(headers['Client'] || 'wfdinner-app')

      header 'access-token', token.value
      header 'client', token.client
      header 'expiry', token.expiry
      header 'uid', token.uid
      header 'token-type', 'Bearer'
    end

    def authenticate!
      Rails.logger.debug 'AuthenticatedResource#authenticate!'
      ensure_valid_user
      set_header_token
    end

    def authenticate_without_tokens!
      Rails.logger.debug 'AuthenticatedResource#authenticate_without_tokens!'
      ensure_valid_user
    end
  end
end
