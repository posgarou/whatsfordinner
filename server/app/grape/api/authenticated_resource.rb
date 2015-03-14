module API
  module AuthenticatedResource
    before do
      if current_user
        token = user.current_token

        header 'access-token', token.value
        header 'client_id', token.client
        header 'expiry', token.expires_at
        header 'uid', token.uid
      end
    end
  end
end
