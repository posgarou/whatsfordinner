# By default, on authorized resources only allow admin access.
class AuthorizedPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope < BasicScope
    def resolve
      if user.admin?
        scope
      else
        []
      end
    end
  end
end

