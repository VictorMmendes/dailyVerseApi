module Knowledge
  module Books
    module Features
      module Destroy
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

          class DestroyBook
            Book = Knowledge::Books::Book

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