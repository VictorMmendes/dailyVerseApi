module Scriptures
  module Verses
    module Forms
        class VerseForm
        # Shorthand definition
        Verse = Scriptures::Verses::Models::Verse

          include ActiveModel::Model
          include ActiveModel::Attributes

          attribute :content, :string
          attribute :reference, :string

          validates :content, presence: true
          validates :reference, presence: true

          attr_reader :verse

          # Add validations here
          # validates :name, presence: true

          def save
            return false unless valid?
            @verse = Verse.new(attributes_for_model)
            if @verse.save
              true
            else
              @verse.errors.each { |error| errors.add(error.attribute, error.message) }
              false
            end
          end

            def update(verse)
              return false unless valid?
              if verse.update(attributes_for_model)
                @verse = verse
                true
              else
                verse.errors.each { |error| errors.add(error.attribute, error.message) }
                false
              end
            end

          private
            def attributes_for_model
              # Retorna um hash com os atributos do formulário que correspondem aos campos do modelo Book
              {
                content: content,
                reference: reference
              }.compact # .compact é útil para remover chaves com valor nil se os atributos forem opcionais
            end
        end
    end
  end
end
