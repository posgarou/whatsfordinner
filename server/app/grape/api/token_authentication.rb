module API
  module TokenAuthentication
    def current_user
      # NB: Mongoid config has been set to not raise errors on no document found

      uid = headers['Uid']
      return @user if @user

      user = User.find_by(uid: uid) if uid

      if !user.visitor? && user.validate(headers['Access-Token'], headers['Client'])
        @user = user
      else
        @user = User::NullUser.new
      end
    end
  end
end
