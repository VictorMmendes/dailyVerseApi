module Knowledge
  module Books
    module Features
      module Create
        module Forms
          class Failure
            attr_reader :errors

            def initialize(errors)
              @errors = errors
            end

            def success?
              false
            end

            def failure?
              true
            end
          end

          class Success
            attr_reader :value

            def initialize(value)
              @value = value
            end

            def success?
              true
            end

            def failure?
              false
            end
          end

          class CreateBookForm
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