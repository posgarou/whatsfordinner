# By default, allow general access.
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    # Searching by id is a bit wonky in neo4j
    # You either have to use the below syntax or:
    #   `scope.where(neo_id: node.neo_id)`
    if scope.respond_to?(:match_to)
      scope.match_to(record.id).exists?
    else
      scope.where(id: record.id).exists?
    end
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

