module Shared
  module Result
    class Failure
      attr_reader :errors

      def initialize(errors)
        @errors = errors
      end

      def success?
        false
      end

      def failure?
        true
      end
    end

    class Success
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def success?
        true
      end

        def failure?
        false
      end
    end
  end
end
