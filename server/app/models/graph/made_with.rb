module Graph
  # The relationship existing between a Recipe and an Ingredient.
  #
  # Includes information about quantity and units.
  class MadeWith
    include Neo4j::ActiveRel

    from_class Graph::Recipe
    to_class Graph::Ingredient
    type 'made_with'

    # These four properties are needed to:
    #
    # 1) Represent the complex possibilities for ingredient quantity.
    # 2) Allow for scaling ingredient quantity up/down
    #
    # Let me just explain via examples.
    #
    # "1 egg" -> quantity: 1, unit_quantity: nil, unit_type: nil
    #
    # With the default quantity_step of 0.5, it will (with scaling) always
    # show a multiple of 0.5 (1 egg, 1 1/2 eggs, etc.). (Assuming half an egg
    # is either a yolk or the whites, obviously.)  If we wanted to exclude the
    # possibility of half eggs, we would set quantity_step to 1.0.
    #
    # "15oz water" -> quantity: nil, unit_quantity 15, unit_type 'oz'
    #
    # "2 16oz steaks" -> quantity: 2, unit_quantity: 16, unit_type 'oz'
    #
    # Unit conversion is handled using the UnitWise gem.
    property :quantity, type: Float
    property :quantity_step, type: Float, default: 0.5
    property :unit_quantity, type: Float
    property :unit_type, type: String

    property :required, type: Boolean, default: true

    # Note to future self: to find a compatible metric unit for a non-metric unit of
    # measurement, you would use the data offered by derived_unit.yml and the
    # compatible_with function to find the compatible_unit in metric

    def render
      quantity_string = render_quantity
      [
        quantity_string,
        render_units(transform:quantity_string.present?),
        to_node.name,
        render_optionality
      ].compact.join(' ')
    end

    alias_method :to_s, :render

    # TODO Write a render_scaled function

    private

    # Render the quantity if present, keeping quantity_step in mind.
    #
    # Returns (1) a float, (2) an integer (if whole number), or (3) 'One' if == 1.
    #
    # Returns a string with the quantity, or nil if no quantity is specified.
    def render_quantity scale=1.0
      if quantity
        rounding_multiplier = 1/quantity_step
        scaled_quantity = (quantity * scale)
        transformed = ((scaled_quantity * rounding_multiplier).round / rounding_multiplier).prettify

        transformed == 1 ? 'One' : transformed
      end
    end

    # Render the unit if present with unit_type, or return nil if no unit is specified.
    #
    # TODO Use Unitwise's #round method. This will be really complex to implement, as you need to round and transform units (e.g., 400tsp to some other measurement), and the way you round will depend on the type of unit (e.g., 453mg to 450mg but 0.53cups to 0.5cups). Moreover, this will be inherently imperfect, as for some measurements--even with the same unit--sometimes you want very precise rounding and sometimes you want very liberal rounding.  You could, in the future, add something like the quantity_step property for handling unit rounding.
    def render_units scale=1.0, transform: true
      if unit_quantity && unit_type
        # :symbol normalizes to (e.g.) "10 °C"
        (Unitwise(unit_quantity, unit_type) * (transform ? scale : 1)).to_s(:symbol)
      end
    end

    def render_optionality
      '(optional)' unless required
    end
  end
end
