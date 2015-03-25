module Similarity
  class DetermineCompositeRecipeSimilarity
    include Interactor
    include InteractorParameters

    attr_accessor :recipe

    MODIFIES = %i(similarity_profiles)

    def call
      ensure_presence_of :recipe
      self.recipe = context.recipe

      possibles = Similarity::FindRecipesToCompare.(recipe: recipe).possible_similarities

      # Construct a similarity profile for each recipe/possible pair
      context.similarity_profiles = possibles.map { |possible| similarity_profile_for possible }
    end

    protected

    def similarity_profile_for possible
      similarity_profile = Hashie::Mash.new
      similarity_profile.recipe = possible

      res = Similarity::GatherComparisonData.(recipes: [recipe, possible])

      similarity_profile.cuisine_similarity_factor = res.cuisine_similarity_factor
      similarity_profile.ingredient_similarity_factor = res.ingredient_similarity_factor
      similarity_profile.group_similarity_factor = res.group_similarity_factor
      similarity_profile.tag_similarity_factor = res.tag_similarity_factor
      similarity_profile.user_similarity_factor = res.user_similarity_factor

      similarity_profile.composite_similarity_factor = construct_composite similarity_profile

      similarity_profile
    end

    def construct_composite similarity_profile
      # This algorithm will likely become more complex in the future
      similarity_profile.cuisine_similarity_factor + similarity_profile.ingredient_similarity_factor + similarity_profile.group_similarity_factor + similarity_profile.tag_similarity_factor + similarity_profile.user_similarity_factor
    end
  end
end
