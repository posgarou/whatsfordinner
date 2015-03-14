module API
  module TokenAuthentication
    def current_user
      user = User.find(headers['uid'])
      (user.validate(headers['access-token'], headers['client']) && user) || nil
    end
  end
end
