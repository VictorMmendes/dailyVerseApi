module Knowledge
  module Books
    class BooksController < ApplicationController
      # Shorthand definition
      Book = Knowledge::Books::Book
      CreateBookCommand = Knowledge::Books::Features::Create::Commands::CreateBookCommand
      UpdateBookCommand = Knowledge::Books::Features::Update::Commands::UpdateBookCommand

      def index
        records = Book.all
        render json: records
      end

      def show
        record = Book.find(params[:id])
        render json: record
      end

      # --- Ações de Escrita (Commands) ---
      def create
        # 1. Controller chama o Command, passando os parâmetros permitidos.
        # O Command é responsável por criar o Form, validar e salvar.
        result = CreateBookCommand.call(permitted_params)

        if result.success?
          # O Command retorna o objeto criado
          render json: result.value, status: :created
        else
          # O Command retorna os erros de validação
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        # 2. Controller chama o Command, passando o registro e os parâmetros
        result = UpdateBookCommand.call(params[:id], permitted_params)

        if result.success?
          render json: result.value
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        # A lógica de destroy é simples e pode permanecer aqui,
        # ou ser movida para um Command se houver regras de negócio complexas.
        record = Book.find(params[:id])
        record.destroy
        head :no_content
      end

      private

      def permitted_params
        params.require(:book).permit(:title, :author, :publication_date)
      end
    end
  end
end