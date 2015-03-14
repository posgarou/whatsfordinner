class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include Tokenable

  embeds_many :user_login_attempts

  field :name, type: String
  field :email, type: String

  # Omniauth info
  field :provider, type: String
  field :uid, type: String
  field :image_url, type: String
  field :oauth_token, type: String
  field :oauth_expires_at, type: Time

  # Will also expire the oauth_token (wipe it clean) if it is expired.
  #
  # Return value is truthy/falsey
  def oauth_token_expired?
    oauth_token.nil? || (if oauth_expires_at < Time.now
      expire_oauth_token!
    end)
  end

  def oauth_token_valid?
    !oauth_token_expired?
  end

  # Delete the recorded oauth_token and oauth_expires_at values
  def expire_oauth_token!
    self.oauth_token = nil
    self.oauth_expires_at = nil
    self.save
  end
end
