module Knowledge
  module Books
    module Controllers
      class BooksController < ApplicationController

        def index
          @books = Knowledge::Books::Models::Book.all
          render json: @books
        end

        def show
          @book = Knowledge::Books::Models::Book.find(params[:id])
          render json: @book
        end

        def create
          form = Knowledge::Books::Forms::BookForm.new(book_params)
          if form.save
            render json: form.book, status: :created
          else
            render json: { errors: form.errors }, status: :unprocessable_entity
          end
        end

        def update
          @book = Knowledge::Books::Models::Book.find(params[:id])
          form = Knowledge::Books::Forms::BookForm.new(book_params)

          if form.update(@book)
            render json: form.book
          else
            render json: { errors: form.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          @book = Knowledge::Books::Models::Book.find(params[:id])
          @book.destroy
          head :no_content
        end

        private

        def book_params
          params.require(:book).permit(:title, :author, :publication_date)
        end
      end
    end
  end
end