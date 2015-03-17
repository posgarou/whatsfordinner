module API
  class Users < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers

    resource :users do
      # Note: no /users/ index route for now.

      params do
        requires :user_id, type: String, desc: 'Id for a user.'
      end
      # /users/:user_id
      route_param :user_id do
        desc 'Generation user info.'
        get do
          present find_user_facade
        end

        # /users/:user_id/history
        resource :history do
          desc 'Recent recipe interactions for this user.'
          params do
            use :pagination
          end
          get do
            render_all UserRecipesHistory.interactions_for(
              user: find_user,
              page: params[:p],
              per_page: params[:per_page]
            )
          end

          desc 'Recent recipe interactions between this user and a given recipe.'
          params do
            use :pagination
            requires :recipe_id, 'Id for the recipe to lookup.'
          end
          route_param :recipe_id do
            get do
              render_all UserRecipeHistory.interactions_for(
                user: Graph::User.find_by(uuid: params[:user_id]),
                recipe: Recipe.find(params[:recipe_id]),
                page: params[:p],
                per_page: params[:per_page]
              )
            end
          end
        end
      end
    end
  end
end
