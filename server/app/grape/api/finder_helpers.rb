module API
  module FinderHelpers
    extend Grape::API::Helpers

    def find_user
      Graph::User.find_by(uuid: params[:user_id])
    end

    def find_user_facade
      UserFacade.from_uuid(params[:user_id])
    end

    def find_recipe
      Graph::Recipe.find(params[:recipe_id])
    end
  end
end
