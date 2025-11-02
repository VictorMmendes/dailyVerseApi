module Knowledge
  module Books
    class BooksController < ApplicationController
      # Shorthand definition
      Book = Knowledge::Books::Book
      CreateBook = Knowledge::Books::Commands::CreateBook
      UpdateBook = Knowledge::Books::Commands::UpdateBook

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
        result = CreateBook.call(permitted_params)

        if result.success?
          # O Command retorna o objeto criado
          render json: result.value, status: :created
        else
          # O Command retorna os erros de validação
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        # 1. Busca do registro (o Command só precisa do ID e dos novos dados)
        record = Book.find(params[:id])

        # 2. Controller chama o Command, passando o registro e os parâmetros
        result = UpdateBook.call(record, permitted_params)

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
