module API
  class Recipes < Grape::API
    helpers SharedParams
    helpers FinderHelpers
    helpers PresenterHelpers
    helpers AuthenticatedResource

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
        before do
          authenticate!
        end

        desc 'Information about a single recipe'
        get do
          render find_recipe
        end

        # recipes/:recipe_id/instructions
        desc 'Instructions for a single recipe'
        get 'instructions' do
          render RecipeInstructions.new(find_recipe), root: :instructions
          if user = find_user_facade
            render user, root: :user
          end
        end

        params do
          optional :rejectedIds, type: Array, desc: 'Other recipes that have been rejected'
        end
        desc 'Should be called when a recipe has been selected'
        put 'select' do
          res = RecordRecipeSelectionAndRejections.(
            user: current_user,
            selectionId: params[:recipe_id],
            rejectionIds: params[:rejectedIds])

          if res.success?
            { success: true}
          else
            error!(res.error, 400)
          end
        end

        params do
          requires :rating, type: Integer, desc: 'Rating for a recipe (1=love, 0=meh, -1=dislike)'
        end
        desc 'Set the current user\'s rating for a recipe. Replaces current rating (if any).'
        post :rate do

        end

        params do
          requires :event_date, type: DateTime, desc: 'DateTime the original selection took place (in Unix time).'
        end
        desc 'Confirm that a selected recipe was made'
        put 'confirmSelection' do
          res = Selection::Confirmation.call(
            user: current_user.graph_user,
            recipe: find_recipe,
            event_date: params[:event_date],
            was_made: true
          )
          present res.success?
        end

        params do
          requires :event_date, type: DateTime, desc: 'DateTime the original selection took place (in Unix time).'
        end
        desc 'Confirm that a selected recipe was NOT made'
        put 'refuteSelection' do
          Selection::Confirmation.call(
            user: current_user,
            recipe: find_recipe,
            event_date: event_date,
            was_made: false
          )
        end
      end
    end
  end
end
