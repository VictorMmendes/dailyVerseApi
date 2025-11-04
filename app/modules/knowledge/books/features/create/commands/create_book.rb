module Knowledge
  module Books
    module Features
      module Create
        module Commands
          class CreateBook
            Book = Knowledge::Books::Book
            Success = Shared::Result::Success
            Failure = Shared::Result::Failure
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