module Knowledge
  module Books
    module Features
      module Update
        module Forms
          class UpdateBookForm
            # Inclui ActiveModel::Model para obter funcionalidades de:
            # - Inicialização (initialize(params))
            # - Validação (valid?, errors)
            # - Atributos (attr_accessor)
            include ActiveModel::Model

            # Inclui ActiveModel::Attributes para definir os tipos (opcional, mas recomendado)
            include ActiveModel::Attributes

            # ------------------------------------------------------------------
            # 1. ATRIBUTOS (O que esperamos receber e validar)
            # ------------------------------------------------------------------

            # Use attr_accessor para definir os campos que o form aceitará.
            attr_accessor :title, :author, :publication_date

            # Opcional: Para definir o tipo explicitamente (útil para RBS)
            attribute :title, :string
            attribute :author, :string
            attribute :publication_date, :date

            # ------------------------------------------------------------------
            # 2. VALIDAÇÕES (Regras de validação do input)
            # ------------------------------------------------------------------

            # Use ActiveModel::Validations (incluído via ActiveModel::Model)
            validates :title, presence: true, length: { maximum: 255 }
            validates :author, presence: true
            validates :publication_date, presence: true

            # ------------------------------------------------------------------
            # 3. MÉTODOS DE AJUDA
            # ------------------------------------------------------------------

            # Método para retornar apenas os atributos que serão passados para o Model
            # Isso atua como um DTO de saída, garantindo que apenas campos válidos/necessários sejam usados.
            def attributes
              {
                title: title,
                author: author,
                publication_date: publication_date,
              }.compact # Remove chaves com valor nil (bom para updates parciais)
            end

            # Exemplo de normalização de dados antes da validação ou uso
            # def title=(value)
            #   @title = value.to_s.strip
            # end

          end
        end
      end
    end
  end
end