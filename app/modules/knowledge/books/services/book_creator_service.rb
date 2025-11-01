module Knowledge
  module Books
    class BookCreatorService
      BookForm = Knowledge::Books::BookForm
      # Passamos a dependência do Notifier no inicializador (bom para testes)
      # def initialize(params, notifier: SlackNotifier.new)
      def initialize(params)
        @params = params
        # @notifier = notifier
      end

      # O método público principal é, por convenção, chamado de `call`
      def call
        form = BookForm.new(@params)

        if form.save
          # Se o livro foi salvo com sucesso, notificamos
          # @notifier.notify("Novo livro criado: #{form.book.title}")
          form.book # Retorna o objeto criado em caso de sucesso
        else
          # Retorna false (ou o próprio form com erros) em caso de falha
          form
        end
      end
    end
  end
end