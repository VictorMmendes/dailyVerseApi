module Knowledge
  module Books
    module Features
      module Create
        module Commands
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

          class CreateBook
            Book = Knowledge::Books::Book
            CreateBookForm = Knowledge::Books::Features::Create::Forms::CreateBookForm

            def self.call(params)
              new(params).call
            end

            def initialize(params)
              @form = CreateBookForm.new(params)
            end

            def call
              return Failure.new(@form.errors) unless @form.valid?
              book = Book.create!(@form.attributes)
              Success.new(book)

            rescue => e
              Failure.new({ base: "Erro na criação: #{e.message}" })
            end
          end
        end
      end
    end
  end
end