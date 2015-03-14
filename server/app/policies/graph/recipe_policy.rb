module Graph
  class RecipePolicy < AuthorizedPolicy
    class Scope < BasicScope
      def resolve
        if user.admin?
          scope.all
        else
          scope.all
        end
      end
    end
  end
end
