# app/modules/knowledge/books/commands/create_book.rb
module Knowledge
  module Books
    class CreateBook
      # Define internal Success and Failure classes to encapsulate command results.
      # This addresses the NameError by providing the missing constants.
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

      # ... existing code ...
      def self.call(params)
        new(params).call
      end

      def initialize(params)
        @form = Books::BookForm.new(params)
      end

      def call
        return Failure.new(@form.errors) unless @form.valid?

        # O Command orquestra a persistência
        book = Books::Book.create!(@form.attributes)

        # Retorna sucesso e o valor (o livro criado)
        Success.new(book)
      rescue => e
        Failure.new({ base: "Erro na criação: #{e.message}" })
      end
    end
  end
end