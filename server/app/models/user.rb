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

  # Connection with Graph DB
  field :uuid, type: String

  field :roles, type: Array, default: ['registered']

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

  # Get the graph equivalent
  def graph_user
    if uuid
      Graph::User.find_by(uuid: uuid)
    else
      graph_user = Graph::User.find_or_create_by(user_id: id)
      self.uuid = graph_user.uuid
      save if persisted?
      graph_user
    end
  end

  def admin?
    roles.include?('admin')
  end

  def admin!
    roles << 'admin' unless admin?
    save if persisted?
  end

  def registered?
    roles.include?('registered')
  end

  def register!
    roles << 'register' unless registered?
    save if persisted?
  end

  def visitor?
    !(admin? || registered?)
  end

  class NullUser < User
    field :roles, type: Array, default: []
  end
end
