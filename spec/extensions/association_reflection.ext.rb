# This adds the ability to return all information about an association
# in a single hash for ease of comparison
module ActiveRecord
  module Reflection
    class AssociationReflection
      def to_hash
        {
          :macro => @macro,
          :options => @options,
          :class_name => @class_name || @name.to_s.singularize.camelize
        }
      end
    end
  end
end