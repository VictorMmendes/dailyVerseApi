module Knowledge
  module Books
    module Features
      module Update
        module Commands
          class UpdateBook
            Book = Knowledge::Books::Book
            Success = Shared::Result::Success
            Failure = Shared::Result::Failure
            UpdateBookForm = Knowledge::Books::Features::Update::Forms::UpdateBookForm

            def self.call(id, params)
              new(id, params).call
            end

            def initialize(id, params)
              @book = Book.find(id)
              @form = UpdateBookForm.new(params)
            end

            def call
              return Failure.new(@form.errors) unless @form.valid?

              if @book.update(@form.attributes)
                Success.new(@book)
              else
                Failure.new(@book.errors)
              end
            rescue => e
              Failure.new({ base: "Erro na atualização: #{e.message}" })
            end
          end
        end
      end
    end
  end
end
