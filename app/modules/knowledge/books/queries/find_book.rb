module Knowledge
  module Books
    module Queries
      class FindBook
        Book = Knowledge::Books::Book
        Success = Shared::Result::Success
        Failure = Shared::Result::Failure

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