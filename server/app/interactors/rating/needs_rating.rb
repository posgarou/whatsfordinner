# Determine which recipes a user has selected but not rated (and thus need review)
#
# USES: user
#
# MODIFIES: recipes_needing_rating
class Rating::NeedsRating
  include Interactor

  MODIFIES = %i(recipes_needing_rating)

  def call
    user = context.user
    ensure_present user

    # Much faster to construct a manual query here.
    # Select every recipe where a user has selected it
    # but not rated it, and where the user has not
    # marked it as not-made.
    context.recipes_needing_rating = user
      .query_as(:u)
      .match('u-[sel:SELECTED]->(rec:Recipe)')
      .where('NOT u-[:RATED]-rec')
      .pluck(:rec)
  end

  protected

  def ensure_present user
    context.fail!(error: 'User is required') unless user
  end
end
