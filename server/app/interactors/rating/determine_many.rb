module Rating
  # USES: user, recipes
  #
  # MODIFIES: ratings
  #
  # rating is a hash of recipe => rating (which is an integer or nil)
  class DetermineMany
    include Interactor

    MODIFIES = %i(ratings)

    def call
      user = context.user
      context.fail!(error: 'User is required') unless user

      context.fail!(error: 'Recipes is required') unless context.recipes

      context.ratings = (context.recipes.map do |recipe|
        res = Rating::Determine.(user: user, recipe: recipe)

        if res.success?
          [recipe, res.rating]
        else
          context.fail!(error: res.error)
        end
      end).to_h
    end
  end
end
