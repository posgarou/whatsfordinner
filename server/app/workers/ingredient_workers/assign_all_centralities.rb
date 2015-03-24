module IngredientWorkers
  class AssignAllCentralities
    include Sidekiq::Worker

    sidekiq_options :queue => :default

    def perform
      uuids = Graph::Ingredient.all.query_as(:ing).pluck('ing.uuid')

      uuids.each do |uuid|
        IngredientWorkers::AssignCentrality.perform_async(uuid)
      end
    end
  end
end
