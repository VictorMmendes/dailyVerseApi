module Knowledge
  module Books
    class UpdateBook
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

      # Método de classe para facilitar a chamada no Controller
      # Recebe o registro que será atualizado e os novos parâmetros
      def self.call(book, params)
        new(book, params).call
      end

      # Inicializa o Command com o registro a ser atualizado e os dados
      def initialize(book, params)
        @book = book
        # O Form é inicializado com os novos parâmetros para validação
        @form = BookForm.new(params)
      end

      # Executa a lógica de atualização
      def call
        # 1. Checa a validade dos novos dados usando o Form Object
        # O Form Object é responsável por garantir que o input é seguro e válido.
        return Failure.new(@form.errors) unless @form.valid?

        # 2. Executa a atualização no registro de domínio
        # Usamos os atributos validados do Form Object para atualizar o Book
        if @book.update(@form.attributes)
          # Retorna sucesso e o objeto atualizado
          Success.new(@book)
        else
          # Retorna erros de validação do Model (ex: restrição do banco de dados)
          Failure.new(@book.errors)
        end
      rescue => e
        # Captura exceções inesperadas
        Failure.new({ base: "Erro na atualização: #{e.message}" })
      end
    end
  end
end