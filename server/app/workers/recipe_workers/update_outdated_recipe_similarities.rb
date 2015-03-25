module RecipeWorkers
  class UpdateOutdatedRecipeSimilarities
    include Sidekiq::Worker

    sidekiq_options :queue => :default

    def perform
      # First, check if there are any recipes that have no defined similarity runs
      no_similarity_runs = begin
        Graph::Recipe.all
          .query_as(:rec)
          .where('rec.similarities_updated_at IS NULL')
          .limit(1000)
          .pluck('rec.uuid')
      end

      if no_similarity_runs.any?
        no_similarity_runs.each do |needs_definition|
          RecipeWorkers::UpdateRecipeSimilarities.perform_async(needs_definition)
        end
      else
        # if they've all been run at least once, then rerun 100 of them
        need_updating = begin
          Graph::Recipe.all
            .query_as(:rec)
            .order(rec: { similarities_updated_at: :asc })
            .limit(100)
            .pluck('rec.uuid')
        end

        need_updating.each do |needs_updating|
          RecipeWorkers::UpdateRecipeSimilarities.perform_async(needs_updating)
        end
      end
    end
  end
end
