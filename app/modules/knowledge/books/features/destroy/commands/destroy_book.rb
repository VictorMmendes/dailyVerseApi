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

            # Método de classe para facilitar a chamada no Controller
            # Recebe apenas o ID do registro que será deletado
            def self.call(id)
              new(id).call
            end

            # Inicializa o Command com o ID
            def initialize(id)
              @id = id
            end

            # Executa a lógica de destruição
            def call
              # 1. Encontra o registro
              # Usamos find_by para evitar uma exceção RecordNotFound,
              # mas find também é válido se você quer que o erro seja tratado no 'rescue'
              @book = Book.find_by(id: @id)

              # 2. Checa se o livro existe
              unless @book
                return Failure.new({ base: "Livro com ID #{@id} não encontrado." })
              end

              # 3. Executa a destruição
              # Usamos destroy! para lançar uma exceção em caso de falha de validação/dependência
              if @book.destroy
                # Retorna sucesso e o objeto que foi destruído
                Success.new(@book)
              else
                # Retorna erros de validação do Model (caso haja callbacks 'before_destroy' com validação)
                # Ou caso o 'destroy' sem '!' falhe por outro motivo.
                Failure.new(@book.errors)
              end
            rescue ActiveRecord::RecordNotDestroyed => e
              # Captura erros de restrição (ex: dependências de chave estrangeira)
              # Geralmente, este erro captura falhas onde 'destroy' falha silenciosamente e você precisa de mais detalhes
              Failure.new({ base: "Falha ao destruir o livro: #{e.message}" })
            rescue => e
              # Captura exceções inesperadas (como falha na conexão com o banco)
              Failure.new({ base: "Erro inesperado na destruição: #{e.message}" })
            end
          end
        end
      end
    end
  end
end