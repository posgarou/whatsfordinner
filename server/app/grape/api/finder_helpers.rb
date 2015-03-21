module API
  module FinderHelpers
    extend Grape::API::Helpers

    def find_user
      user = user_from_user_id_param

      error!('User not found', 404) unless user

      user
    end

    def find_user_facade
      if params[:user_id]
        UserFacade.from_graph_user(find_user)
      else
        UserFacade.from_user(current_user)
      end
    end

    def find_recipe
      recipe = Graph::Recipe.find(params[:recipe_id]) if params[:recipe_id]

      error!('Recipe not found', 404) unless recipe

      recipe
    end

    private

    def user_from_user_id_param
      Graph::User.find_by(uuid: params[:user_id]) if params[:user_id]
    end
  end
end
