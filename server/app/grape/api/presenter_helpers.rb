module API
  module PresenterHelpers
    extend Grape::API::Helpers

    # The docs say that present(foo) should automatically call #entity,
    # but I am not seeing that behavior.
    def render obj, root:nil
      if root
        present root, obj.entity
      else
        present obj.entity
      end
    end

    def render_all collection, root:nil
      if root
        present root, collection.map(&:entity)
      else
        present collection.map(&:entity)
      end
    end
  end
end
