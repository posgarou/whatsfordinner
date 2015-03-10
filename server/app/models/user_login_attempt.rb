class UserLoginAttempt
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
end