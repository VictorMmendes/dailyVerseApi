module Knowledge
  module Books
    class BooksController < ApplicationController
      # Shorthand definition
      # Models
      Book = Knowledge::Books::Book
      # Commands
      CreateBook = Knowledge::Books::Features::Create::Commands::CreateBook
      UpdateBook = Knowledge::Books::Features::Update::Commands::UpdateBook
      DestroyBook = Knowledge::Books::Features::Destroy::Commands::DestroyBook
      # Queries
      ListBooks = Knowledge::Books::Queries::ListBooks
      FindBook = Knowledge::Books::Queries::FindBook

      def index
        result = ListBooks.call(params)
        render_operation_result(result)
      end

      def show
        result = FindBook.call(params[:id])
        render_operation_result(result, failure_status: :not_found)
      end

      def create
        result = CreateBook.call(permitted_params)
        render_operation_result(result, success_status: :created)
      end

      def update
        result = UpdateBook.call(params[:id], permitted_params)
        render_operation_result(result)
      end

      def destroy
        result = DestroyBook.call(params[:id])
        render_operation_result(result)
      end

      private

      def permitted_params
        params.require(:book).permit(:title, :author, :publication_date)
      end
    end
  end
end