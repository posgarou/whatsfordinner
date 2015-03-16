module API
  module Validations
    # Accepts a range (e.g., 1..40) and validates that the parameter is within that range (inclusively)
    class Range < Grape::Validations::Base
      def validate_param!(attr_name, params)
        unless @option.include?(params[attr_name])
          min, max = @option.first, @option.last
          raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be between #{min} and #{max}"
        end
      end
    end
  end
end
