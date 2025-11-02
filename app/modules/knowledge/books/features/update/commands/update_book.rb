module Knowledge
  module Books
    module Features
      module Update
        module Commands
          class UpdateBook
            Book = Knowledge::Books::Book
            UpdateBookForm = Knowledge::Books::Features::Update::Forms::UpdateBookForm # Ajustamos o nome do Form

            # Método de classe para facilitar a chamada no Controller
            # Recebe o registro que será atualizado e os novos parâmetros
            def self.call(id, params)
              new(id, params).call
            end

            # Inicializa o Command com o registro a ser atualizado e os dados
            def initialize(id, params)
              @book = Book.find(id)
              # O Form é inicializado com os novos parâmetros para validação
              @form = UpdateBookForm.new(params)
            end

            # Executa a lógica de atualização
            def call
              # 1. Checa a validade dos novos dados usando o Form Object
              # O Form Object é responsável por garantir que o input é seguro e válido.
              return ::Shared::Result::Failure.new(@form.errors) unless @form.valid?

              # 2. Executa a atualização no registro de domínio
              # Usamos os atributos validados do Form Object para atualizar o Book
              if @book.update(@form.attributes)
                # Retorna sucesso e o objeto atualizado
                ::Shared::Result::Success.new(@book)
              else
                # Retorna erros de validação do Model (ex: restrição do banco de dados)
                ::Shared::Result::Failure.new(@book.errors)
              end
            rescue => e
              # Captura exceções inesperadas
              ::Shared::Result::Failure.new({ base: "Erro na atualização: #{e.message}" })
            end
          end
        end
      end
    end
  end
end
