# Joins together information from User and Graph::User
class UserFacade
  include Grape::Entity::DSL

  attr_accessor :user, :graph_user

  delegate :uuid, to: :graph_user

  # Accepts a UUID and generates a facade based on the User/GraphUser associated therewith
  def self.from_uuid uuid
    graph_user = Graph::User.find_by(uuid: uuid)
    user = graph_user.standard_user

    new(user, graph_user)
  end

  def initialize(user, graph_user)
    self.user = user
    self.graph_user = graph_user
  end

  entity :uuid
end
