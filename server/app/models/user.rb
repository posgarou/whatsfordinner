class User
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :user_login_attempts

  field :name, type: String
  field :email, type: String

  # Omniauth info
  field :provider, type: String
  field :uid, type: String
  field :oauth_token, type: String
  field :oauth_expires_at, type: Time

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name ||= auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

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