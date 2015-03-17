module API
  class Recipes < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers

    resource :recipes do
      desc 'Index listing of recipes'
      params do
        use :pagination
      end
      get do
        present Graph::Recipe.all.paginate(
            page: params[:p],
            per_page: params[:per_page]
          )
      end

      params do
        requires :recipe_id, type: String, desc: 'Recipe id'
      end
      route_param :recipe_id do
        desc 'Information about a single recipe'
        get do
          render find_recipe
        end

        # recipes/:recipe_id/instruction
        desc 'Instructions for a single recipe'
        params do
          optional :user_id, type: String, desc: 'User id'
        end
        get 'instructions' do
          render RecipeInstructions.new(find_recipe), root: :instructions
          if user = find_user_facade
            render user, root: :user
          end
        end
      end
    end
  end
end
