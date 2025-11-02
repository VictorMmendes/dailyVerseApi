module Knowledge
  module Books
    module Features
      module Update
        module Forms
          class UpdateBookForm
            include ActiveModel::Model
            include ActiveModel::Attributes

            attr_accessor :title, :author, :publication_date

            attribute :title, :string
            attribute :author, :string
            attribute :publication_date, :date

            validates :title, presence: true, length: { maximum: 255 }
            validates :author, presence: true
            validates :publication_date, presence: true

            def attributes
              {
                title: title,
                author: author,
                publication_date: publication_date,
              }.compact
            end
          end
        end
      end
    end
  end
end
