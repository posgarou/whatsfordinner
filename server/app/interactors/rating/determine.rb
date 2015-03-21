module Rating
  # USES: user, recipe
  #
  # MODIFIES: rating
  #
  # rating is an integer value or nil
  class Determine
    include Interactor

    MODIFIES = %i(rating)

    def call
      @user = context.user
      context.fail!(error: 'User is required') unless @user

      @recipe = context.recipe
      context.fail!(error: 'Recipe is required') unless @recipe

      context.rating = find_rating
    end

    def find_rating
      @user.rated_recipes.first_rel_to(@recipe).try(:rating)
    end
  end
end
