module Knowledge
  module Books
    module Queries
      class ListBooks
        Book = Knowledge::Books::Book

        # Argumentos: os parâmetros de filtro e paginação (e.g., params do Controller)
        def self.call(params)
          new(params).call
        end

        def initialize(params)
          @params = params
          @scope = Book.all
        end

        def call
          # As queries geralmente não falham devido a validação de input
          # (isso é responsabilidade do controller ou de um form object para queries),
          # mas podem falhar por erros internos (DB, lógica inesperada).
          begin
            # Encapsula toda a lógica de filtros e ordenação
            apply_filters
            apply_sorting
            apply_pagination

            # Retorna a relação final do Active Record encapsulada em um objeto Success
            ::Shared::Result::Success.new(@scope)
          rescue => e
            # Captura e trata exceções inesperadas
            # Logar o erro aqui seria uma boa prática
            ::Shared::Result::Failure.new({ base: "Erro ao listar livros: #{e.message}" })
          end
        end

        private

        def apply_filters
          # Exemplo de filtro por gênero (usando o parâmetro 'genre' da URL)
          if @params[:genre].present?
            @scope = @scope.where(genre: @params[:genre])
          end

          # Exemplo de filtro de busca por título
          if @params[:search_term].present?
            @scope = @scope.where("title LIKE ?", "%#{@params[:search_term]}%")
          end

          # Se a lógica de filtro for muito complexa, você pode delegar
          # a filtros específicos ou Scopes do Active Record.
        end

        def apply_sorting
          # Exemplo de ordenação padrão ou por parâmetro
          sort_column = @params[:sort] || 'title'
          sort_direction = @params[:direction] || 'asc'
          @scope = @scope.order(sort_column => sort_direction)
        end

        def apply_pagination
          # Adiciona paginação (exemplo com a gem Kaminari ou WillPaginate)
          # @scope = @scope.page(@params[:page]).per(@params[:per_page])
        end
      end
    end
  end
end
