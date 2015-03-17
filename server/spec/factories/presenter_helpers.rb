module API
  module PresenterHelpers
    extend Grape::API::Helpers

    # The docs say that present(foo) should automatically call #entity,
    # but I am not seeing that behavior.
    def render obj
      present obj.entity
    end

    def render_all collection
      present collection.map(&:entity)
    end
  end
end
