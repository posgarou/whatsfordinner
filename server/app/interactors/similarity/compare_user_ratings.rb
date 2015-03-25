module Similarity
  # TODO Interactor that, with a certain threshold of users, compares user ratings against the norm when there are enough users and gives a weighty ranking based on this
  class CompareUserRatings
    include Interactor
    include InteractorParameters

    def call
      context.user_similarity_factor = 0
    end
  end
end
