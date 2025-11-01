module Scriptures
  module Verses
    module Services
      class VerseCreatorService
        VerseForm = Scriptures::Verses::Forms::VerseForm
        # Passamos a dependência do Notifier no inicializador (bom para testes)
        # def initialize(params, notifier: SlackNotifier.new)
        def initialize(params)
          @params = params
          # @notifier = notifier
        end

        # O método público principal é, por convenção, chamado de `call`
        def call
          form = VerseForm.new(@params)

          if form.save
            # Se o versículo foi salvo com sucesso, notificamos
            # @notifier.notify("Novo versículo criado: #{form.verse.content}")
            form.verse # Retorna o objeto criado em caso de sucesso
          else
            # Retorna false (ou o próprio form com erros) em caso de falha
            form
          end
        end
      end
    end
  end
end