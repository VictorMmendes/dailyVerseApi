module Knowledge
  module Books
    class BooksController < ApplicationController
      # shorthands
      Book = Knowledge::Books::Book
      BookForm = Knowledge::Books::BookForm
      BookCreatorService = Knowledge::Books::BookCreatorService

        def index
          @books = Book.all
          render json: @books
        end

        def show
          @book = Book.find(params[:id])
          render json: @book
        end

        def create
          # O controller não sabe sobre Slack. Ele apenas chama o serviço.
          creator = BookCreatorService.new(book_params)
          result = creator.call

          if result.is_a?(Book)
            render json: result, status: :created
          else # Se o resultado for o form, ele tem os erros
            render json: { errors: result.errors }, status: :unprocessable_entity
          end
        end

        def update
          @book = Book.find(params[:id])
          form = BookForm.new(book_params)

          if form.update(@book)
            render json: form.book
          else
            render json: { errors: form.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          @book = Book.find(params[:id])
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