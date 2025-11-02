module Knowledge
  module Books
    module Queries
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

      class FindBook
        Book = Knowledge::Books::Book

        def self.call(id)
          new(id).call
        end

        def initialize(id)
          @id = id
        end

        def call
          book = Book.find_by(id: @id)
          if book
            Success.new(book)
          else
            Failure.new({ base: "Book not found" })
          end
        rescue ActiveRecord::RecordNotFound
          Failure.new({ base: "Book not found" })
        end
      end
    end
  end
end