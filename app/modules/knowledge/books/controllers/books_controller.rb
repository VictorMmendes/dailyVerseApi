module Knowledge
  module Books
    class BooksController < ApplicationController

      def index
        @books = Book.all
        render json: @books # Exemplo
      end

      def create
        form = BookForm.new(book_params)
        if form.save
          render json: form.book, status: :created
        else
          render json: { errors: form.errors }, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :publication_date)
      end
    end
  end
end