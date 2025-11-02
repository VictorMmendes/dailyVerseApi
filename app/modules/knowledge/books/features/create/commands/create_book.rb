module Knowledge
  module Books
    module Features
      module Create
        module Commands
          class CreateBook
            # --------------------------------------------------------------------
            # 1. Classes de Resultado Aninhadas (Padrão Result Object)
            #    (Essas classes devem ser definidas no nível mais alto ou serem extraídas
            #     para um módulo Shared/Result para evitar duplicação em cada Command)
            # --------------------------------------------------------------------

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

            # --------------------------------------------------------------------
            # 2. Referências de Classes (Mapeamento explícito de dependências)
            # --------------------------------------------------------------------

            # O Command precisa de referências explícitas às classes que ele usa,
            # sem assumir que estão no mesmo namespace (quebrado pela profundidade).
            Book = Knowledge::Books::Book
            BookForm = Knowledge::Books::Forms::CreateBookForm # Ajustamos o nome do Form

            # --------------------------------------------------------------------
            # 3. Métodos do Command (Lógica de Orquestração)
            # --------------------------------------------------------------------

            def self.call(params)
              # Cria uma nova instância e chama o método de instância #call
              new(params).call
            end

            def initialize(params)
              # Instancia o Form Object específico para este Command
              @form = BookForm.new(params)
            end

            def call
              # PASSO 1: Validação do Input (Form Object)
              return Failure.new(@form.errors) unless @form.valid?

              # PASSO 2: Execução da Lógica de Negócio e Persistência
              # Usa os atributos validados do Form para criar o registro
              book = Book.create!(@form.attributes)

              # PASSO 3: Retorno de Sucesso
              Success.new(book)

            rescue => e
              # Captura e trata exceções inesperadas
              # Logar o erro aqui seria uma boa prática
              Failure.new({ base: "Erro na criação: #{e.message}" })
            end
          end
        end
      end
    end
  end
end