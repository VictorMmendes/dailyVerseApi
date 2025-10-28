module Knowledge
  module Books
    class BookForm
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :title, :string
      attribute :author, :string
      attribute :publication_date, :date

      validates :title, presence: true
      validates :author, presence: true

      attr_reader :book

      def save
        return false unless valid?
        @book = Book.new(title: title, author: author, publication_date: publication_date)
        if @book.save
          true
        else
          @book.errors.each { |error| errors.add(error.attribute, error.message) }
          false
        end
      end
    end
  end
end# Este arquivo conterá as rotas para o módulo Knowledge::Books
# Não precisa de Rails.application.routes.draw aqui
resources :books, only: [:index, :create, :show, :update, :destroy]
# ... outras rotas para books ...