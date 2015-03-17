module API
  class Recipes < Grape::API
    helpers SharedParams

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
        requires :recipe_id, type: String, desc: 'Id for recipe to lookup.'
      end
      route_param :recipe_id do
        desc 'Information about a single recipe'
        get do
          present Graph::Recipe.find(params[:recipe_id]), with: Graph::Recipe::Entity
        end
      end
    end
  end
end
