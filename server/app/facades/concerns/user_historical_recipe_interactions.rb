# Common behavior for UserRecipeHistory and UserRecipesHistory
#
# Basic methods generated:
#
# #recent_interactions, for which see below
# A #recently_ method for each member of ALLOWED_RELATIONSHIPS (e.g., #recently_selected)
#
# All of these methods accept named parameters of +limit+
# and +offset+ (the latter of which maps to Cypher SKIP).
module UserHistoricalRecipeInteractions
  extend ActiveSupport::Concern

  include Grape::Entity::DSL

  included do
    attr_accessor :user

    delegate :id, to: :user, prefix: 'user'

    ALLOWED_RELATIONSHIPS = [
      'rated',
      'selected'
    ]

    # Defines (e.g.) recently_rated, _hidden, etc.
    ALLOWED_RELATIONSHIPS.each do |type|
      define_method "recently_#{type}", -> (limit:nil, offset:nil) do
        optional_params = {limit:limit, offset:offset}.reject { |_k,v| v.nil? }
        recent_interactions types:[type], **optional_params
      end
    end
  end

  def initialize(user)
    @user = user
  end

  # Constructs one of several queries via options and partial methods
  def recent_interactions(types:ALLOWED_RELATIONSHIPS, limit:5, offset:0)
    type_query = type_query_for types

    all_rels = user
      .query_as(:user)
      .match("user-[rel:#{type_query}]->(recipe:`Graph::Recipe`)")

    recipe_restricted = restrict_by_recipe all_rels

    # Order by date, apply skip/limit, and return rels
    recipe_restricted
      .order(rel: { event_date: :desc })
      .skip(offset)
      .limit(limit)
      .pluck(:rel)
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
