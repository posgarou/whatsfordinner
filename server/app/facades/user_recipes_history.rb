# Presents the history between a user and a given recipe.
#
# For methods included, see UserhistoricalRecipeInteractions
class UserRecipesHistory
  include UserHistoricalRecipeInteractions
  include Grape::Entity::DSL

  def self.interactions_for(user:, page:nil, per_page:nil)
    new(user)
      .paginate_with(
        page: page,
        per_page: per_page
      )
      .recent_interactions
  end

  entity :user_id, :recipe_id do
    expose :entries do |history, options|
      if options[:relation_types]
        history.recent_interactions relation_types
      else
        history.recent_interactions
      end
    end
  end
end
