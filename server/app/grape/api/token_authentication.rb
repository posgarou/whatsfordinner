module API
  module TokenAuthentication
    def current_user
      # NB: Mongoid config has been set to not raise errors on no document found
      user = User.find(headers['uid'])
      if user && user.validate(headers['access-token'], headers['client'])
        user
      else
        User::NullUser.new
      end
    end
  end
end
