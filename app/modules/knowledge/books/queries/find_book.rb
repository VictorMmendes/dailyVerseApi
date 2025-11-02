module Knowledge
  module Books
    module Queries
      class FindBook
        # A dependência de dados é o Model (Active Record)
        Book = Knowledge::Books::Book

        # Usa o padrão .call para ser facilmente executável
        # Argumentos: o ID do livro a ser buscado (e.g., params[:id])
        def self.call(id)
          new(id).call
        end

        def initialize(id)
          @id = id
        end

        def call
          book = Book.find_by(id: @id) # Ou Book.find(id) e tratar o RecordNotFound
          if book
            ::Shared::Result::Success.new(book) # Reutilizando a classe Success
          else
            ::Shared::Result::Failure.new({ base: "Book not found" }) # Reutilizando a classe Failure
          end
        rescue ActiveRecord::RecordNotFound
          ::Shared::Result::Failure.new({ base: "Book not found" })
        end
      end
    end
  end
end