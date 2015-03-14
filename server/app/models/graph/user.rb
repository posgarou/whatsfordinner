module Graph
  class User
    include Neo4j::ActiveNode

    # String since it's a Mongoid ID
    property :user_id, type: String

    # Specify a persistent id
    id_property :uuid, auto: :uuid

    def standard_user
      ::User.find(user_id)
    end
  end
end
