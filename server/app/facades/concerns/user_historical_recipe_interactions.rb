# Common behavior for UserRecipeHistory and UserRecipesHistory
#
# Basic methods generated:
#
# #recent_interactions, for which see below
# A #recently_ method for each member of ALLOWED_RELATIONSHIPS (e.g., #recently_selected)
module UserHistoricalRecipeInteractions
  extend ActiveSupport::Concern

  included do
    attr_writer :page, :per_page
    attr_accessor :user, :type

    delegate :uuid, to: :user, prefix: 'user'

    ALLOWED_RELATIONSHIPS = [
      'RATED',
      'SELECTED',
      'REJECTED'
    ]

    # Defines (e.g.) recently_rated, _hidden, etc.
    ALLOWED_RELATIONSHIPS.each do |type|
      define_method "recently_#{type.downcase}" do
        recent_interactions types:[type]
      end
    end
  end

  def initialize(user)
    @user = user
  end

  # Constructs one of several queries via options and partial methods
  def recent_interactions(types:ALLOWED_RELATIONSHIPS)
    type_query = type_query_for types

    all_rels = user
      .query_as(:user)
      .match("user-[rel:#{type_query}]->(recipe:`Graph::Recipe`)")

    recipe_restricted = restrict_by_recipe all_rels

    # Order by date and return rels
    recipe_restricted
      .order(rel: { event_date: :desc })
      .limit(per_page)
      .skip((page - 1) * per_page)
      .pluck(:rel)
  end

  # Apply pagination to recent_interactions Query (since baked in pagination is only for QueryProxy).
  #
  # Must be called prior to recent_interactions
  def paginate_with page:nil, per_page:nil
    @page = page if page
    @per_page = per_page if per_page
    self
  end

  def page
    @page ||= 1
  end

  def per_page
    @per_page ||= 40
  end

  protected

  # Whitelist relationships for querying and compose for Cypher
  def type_query_for types
    types &= ALLOWED_RELATIONSHIPS
    types.join('|')
  end

  # By default, no recipe restriction
  def restrict_by_recipe query
    query
  end
end
