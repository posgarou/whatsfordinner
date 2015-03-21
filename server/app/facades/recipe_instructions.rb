# Presents recipe info for instruction display.
# If a user is assigned to it, it will tailor the information to the user.
class RecipeInstructions
  include Grape::Entity::DSL

  attr_accessor :recipe

  delegate :title,
    :description,
    :prep_time,
    :cooking_time,
    to: :recipe

  def initialize(recipe)
    self.recipe = recipe
  end

  #################################
  #      TRANSFORMED VALUES       #
  #################################

  def timeframe_display_text
    pretty_time total_time
  end

  def timeframe_breakdown_text
    [
      ("#{ pretty_time(prep_time) } prep" if prep_time),
      ("#{ pretty_time(cooking_time) } cooking" if cooking_time)
    ].compact.join(' and ')
  end

  # The #to_a is required for now due to a strange bug where,
  # when a query is called with #order, calling
  # #first and #last on the QueryProxy obj returns the same object.
  def tags
    [*recipe.tags]
  end

  def steps
    [*recipe.steps_in_order]
  end

  def quantified_ingredients
    [*recipe.ingredients_rels]
  end

  def current_amount
    recipe.serves
  end

  def total_time
    (cooking_time || 0) + (prep_time || 0)
  end

  def difficulty
    recipe.difficulty.try(:titlecase) || 'Unspecified'
  end

  #################################
  #          UTILITY              #
  #################################

  # Use chronic_duration to translate seconds to prettier format.
  # E.g., 1h 50m.
  def pretty_time t
    ChronicDuration.output(t, format: :short)
  end

  #################################
  #           ENTITY              #
  #################################

  entity do
    # ATTRIBUTES
    expose :title
    expose :description

    expose :serves do
      expose :current_amount, as: :currentAmount
    end

    expose :timeframe do
      expose :timeframe_display_text, as: :displayText
      expose :timeframe_breakdown_text, as: :breakdownText
    end

    expose :cuisines
    expose :mealtimes
    expose :difficulty
    expose :serveWith

    expose :tags, using: Graph::Tag::Entity
    expose :quantified_ingredients, using: Graph::MadeWith::Entity, as: :ingredients
    expose :steps
  end

  #################################
  #          STUBBED              #
  #################################

  def cuisines
    []
  end

  def mealtimes
    {name: 'breakfast'}
  end

  def serveWith
    []
  end
end
