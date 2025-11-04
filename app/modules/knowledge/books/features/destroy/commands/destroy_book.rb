module Knowledge
  module Books
    module Features
      module Destroy
        module Commands
          class DestroyBook
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
              @book = Book.find_by(id: @id)

              unless @book
                return Failure.new({ base: "Livro com ID #{@id} não encontrado." })
              end

              if @book.destroy
                Success.new(@book)
              else
                Failure.new(@book.errors)
              end
            rescue ActiveRecord::RecordNotDestroyed => e
              Failure.new({ base: "Falha ao destruir o livro: #{e.message}" })
            rescue => e
              Failure.new({ base: "Erro inesperado na destruição: #{e.message}" })
            end
          end
        end
      end
    end
  end
end