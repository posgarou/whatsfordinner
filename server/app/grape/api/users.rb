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

        # Every path under /users is authenticated
        before do
          authenticate!
        end

        desc 'User info'
        get do
          present find_user_facade
        end

        resource :recipes do
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
            optional :meal_time, type: String, desc: 'Limit to this mealtime'
            optional :difficulty, type: String, desc: 'Limit to at or below this difficulty'
          end
          get 'concierge' do
            result = Concierge.call(
              user: current_user,
              meal_time: params[:meal_time],
              difficulty: params[:difficulty]
            )

            render_all result.suggestions, root: 'recipes'
          end

          desc 'Get recipes the user has selected in the past but not rated'
          get 'needs_rating' do
            result = Rating::NeedsRating.call(user: current_user.graph_user)

            if result.success?
              render_all result.recipes_needing_rating
            else
              error!(res.error, 400)
            end
          end

          desc 'Recent recipe interactions between this user and a given recipe'
          params do
            requires :recipe_id, type: String, desc: 'Recipe id'
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
