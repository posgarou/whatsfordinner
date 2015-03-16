module API
  class Recipes < Grape::API

    resource :recipes do
      desc 'Index listing of recipes'
      params do
        optional :p, type: Integer, default: 1, desc: 'Current page of paginated recipes. Defaults to 1.'
        optional :per_page, type: Integer, default: 20, range: 1..40, desc: 'Number to include per request. '
      end
      get do
        present Graph::Recipe.all.paginate(
            page: params[:p],
            per_page: params[:per_page]
          )
      end

      # params do
      #   required :recipe_id, type: String, desc: 'Id for a recipe'
      # end
      route_param :recipe_id do
        desc 'Information about a single recipe'
        get do
          present Graph::Recipe.find(params[:recipe_id]), with: Graph::Recipe::Entity
        end
      end
    end
  end
end
