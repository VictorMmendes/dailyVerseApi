# app/modules/shared/result.rb
module Shared
  module Result
    class Success
      attr_reader :value

      def initialize(value = nil)
        @value = value
      end

      def success?
        true
      end

      def failure?
        false
      end
    end

    class Failure
      attr_reader :errors

      def initialize(errors = {})
        @errors = errors
      end

      def success?
        false
      end

      def failure?
        true
      end
    end
  end
end