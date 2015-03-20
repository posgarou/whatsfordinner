module API
  class Users < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers
    helpers AuthenticatedResource

    resource :users do
      # Note: no /users/ index route for now.

      params do
        requires :user_id, type: String, desc: 'User id'
      end
      # /users/:user_id
      route_param :user_id do
        desc 'User info'
        get do
          present find_user_facade
        end

        resource :recipes do
          before do
            authenticate!
          end

          # /users/:user_id/recipes/history
          resource :history do
            desc 'Recent recipe interactions for this user'
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
          end

          desc 'Get recipe suggestions'
          params do
            # Add here mealtime, difficulty, etc.
          end
          get 'concierge' do
            result = Concierge.(user: current_user)

            render_all result.suggestions, root: 'recipes'
          end

          desc 'Recent recipe interactions between this user and a given recipe'
          params do
            optional :recipe_id, 'Recipe id'
          end
          route_param :recipe_id do
            # /users/:user_id/recipes/:recipe_id
            params do
              use :pagination
            end
            get do
              render_all UserRecipeHistory.interactions_for(
                  user: find_user,
                  recipe: find_recipe,
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
