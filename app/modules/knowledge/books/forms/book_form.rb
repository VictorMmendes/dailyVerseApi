module Knowledge
  module Books
    module Forms
      class BookForm
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :title, :string
        attribute :author, :string
        attribute :publication_date, :date

        validates :title, presence: true
        validates :author, presence: true

        attr_reader :book

        def update(book)
          return false unless valid?
          if book.update(title: title, author: author, publication_date: publication_date)
            @book = book
            true
          else
            book.errors.each { |error| errors.add(error.attribute, error.message) }
            false
          end
        end

        def save
          return false unless valid?
          @book = Knowledge::Books::Models::Book.new(title: title, author: author, publication_date: publication_date)
          if @book.save
            true
          else
            @book.errors.each { |error| errors.add(error.attribute, error.message) }
            false
          end
        end
      end
    end
  end
end