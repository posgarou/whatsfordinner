class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include Grape::Entity::DSL

  include Tokenable

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
      graph_user = Graph::User.find_by(uuid: uuid)
      if graph_user
        return graph_user
      else
        Rails.logger.warn "User #{self.id} found with no longer existing graph user via uuid."
      end

      graph_user = Graph::User.find_by(user_id: id)
      if graph_user
        Rails.logger.warn "Found graph user for #{self.id} via user id property."
        return graph_user
      else
        Rails.logger.error "Could not find graph user for #{self.id} via uuid or user id property, even though User model has record of previous Graph::User."
      end
    end

    # Default for new, also if previous searches ultimately failed
    graph_user = Graph::User.find_or_create_by(user_id: id)
    self.uuid = graph_user.uuid
    save if persisted?
    graph_user
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

  entity :name, :email, :provider, :uid, :image_url, :roles do
    expose :uuid_or_create, as: :id

    private

    # This will generate a Graph::User if one is not defined and send back the uuid
    def uuid_or_create
      object.uuid || object.graph_user.uuid
    end
  end
end
