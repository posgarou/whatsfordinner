module RecipeWorkers
  class AssignAllRecipeRatingVariance
    include Sidekiq::Worker

    sidekiq_options :queue => :default

    def perform
      # If a very large number of recipes are added, this will need to be broken down into batches

      uuids = Graph::Recipe.all.query_as(:rec).pluck('rec.uuid')

      uuids.each do |uuid|
        RecipeWorkers::AssignRecipeRatingVariance.perform_async(uuid)
      end
    end
  end
end
