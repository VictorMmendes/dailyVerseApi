module Knowledge
  module Books
    module Queries
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

      class ListBooks
        Book = Knowledge::Books::Book

        def self.call(params)
          new(params).call
        end

        def initialize(params)
          @params = params
          @scope = Book.all
        end

        def call
          begin
            apply_filters
            apply_sorting
            apply_pagination

            Success.new(@scope)
          rescue => e
            Failure.new({ base: "Erro ao listar livros: #{e.message}" })
          end
        end

        private

        def apply_filters
          if @params[:author].present?
            @scope = @scope.where(author: @params[:author])
          end

          if @params[:search_term].present?
            @scope = @scope.where("title LIKE ?", "%#{@params[:search_term]}%")
          end
        end

        def apply_sorting
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
