module Knowledge
  module Books
    class BooksController < ApplicationController
      # Shorthand definition
      Book = Knowledge::Books::Book # Ainda necessário se você referenciar o modelo diretamente em algum lugar
      CreateBook = Knowledge::Books::Features::Create::Commands::CreateBook
      UpdateBook = Knowledge::Books::Features::Update::Commands::UpdateBook
      # DestroyBook = Knowledge::Books::Features::Destroy::Commands::DestroyBook
      ListBooks = Knowledge::Books::Queries::ListBooks
      FindBook = Knowledge::Books::Queries::FindBook

      def index
        result = ListBooks.call(params)
        render_operation_result(result) # success_status default é :ok
      end

      def show
        result = FindBook.call(params[:id])
        # Para show, se não encontrar, o status deve ser :not_found
        render_operation_result(result, failure_status: :not_found)
      end

      # --- Ações de Escrita (Commands) ---
      def create
        result = CreateBook.call(permitted_params)
        render_operation_result(result, success_status: :created)
      end

      def update
        result = UpdateBook.call(params[:id], permitted_params)
        render_operation_result(result) # success_status default é :ok
      end

      def destroy
        # result = DestroyBook.call(params[:id])
        # if result.success?
        #   head :no_content # Destroy com sucesso normalmente retorna 204 No Content
        # else
        #   render_operation_result(result) # Em caso de falha, usar o helper padrão
        # end
      end

      private

      def permitted_params
        params.require(:book).permit(:title, :author, :publication_date)
      end
    end
  end
end