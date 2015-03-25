module Similarity
  # This interactor is expected to be called regularly. No recipe similarities should be considered
  # "one and done". It is intentionally an iterative process.
  class UpdateRecipeSimilarities
    include Interactor
    include InteractorParameters

    attr_accessor :recipe

    MODIFIES = %i()

    def call
      ensure_presence_of :recipe
      self.recipe = context.recipe

      res = Similarity::DetermineCompositeRecipeSimilarity.(recipe: recipe)

      if res.success?
        similarity_profiles = res.similarity_profiles

        # Set minimum threshold, sort remaining similarities, and take
        # Graph::Recipe::MAXIMUM_SIMILARITIES of them.
        similarity_profiles = begin
          similarity_profiles
            .select { |prof| prof.composite_similarity_factor >= 0.75}
            .sort_by(&:composite_similarity_factor)
            .reverse!
            .slice(0...Graph::Recipe::MAXIMUM_SIMILARITIES)
        end

        delete_old_similarities!
        create_new_similarities! similarity_profiles
      else
        base_error = "Unable to update similarities for Recipe #{recipe.uuid}."
        base_error += "/n#{res.error}" if res.error
        context.fail!(error: base_error)
      end
    end

    def delete_old_similarities!
      recipe
        .query_as(:rec)
        .match('rec-[r:SIMILAR_TO]->(rec2:Recipe)')
        .delete(:r)
        .exec
    end

    def create_new_similarities! similarity_profiles
      similarity_profiles.each do |profile|
        Graph::SimilarTo.create(
          from_node: recipe,
          to_node: profile.recipe,
          strength: profile.composite_similarity_factor
        )
      end
    end
  end
end
