class BasicScope
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def resolve
    if user.admin?
      scope.all
    end
  end
end
