module Scriptures
  module Verses
    module Forms
        class VerseForm
        # Shorthand definition
        Verse = Scriptures::Verses::Models::Verse

          include ActiveModel::Model
          include ActiveModel::Attributes


          attr_reader :record

          # Add validations here
          # validates :name, presence: true

          def save
            return false unless valid?
            @record = Verse.new(attributes_for_model)
            if @record.save
              true
            else
              @record.errors.each { |error| errors.add(error.attribute, error.message) }
              false
            end
          end

            def update(record)
              return false unless valid?
              if record.update(attributes_for_model)
                @record = record
                true
              else
                record.errors.each { |error| errors.add(error.attribute, error.message) }
                false
              end
            end

          private
            def attributes_for_model
              # Retorna um hash com os atributos do formulário que correspondem aos campos do modelo Book
              {
                content: content,
                reference: reference,
              }.compact # .compact é útil para remover chaves com valor nil se os atributos forem opcionais
            end
        end
    end
  end
end
