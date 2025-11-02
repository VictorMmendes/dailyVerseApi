scope path: "knowledge", module: "knowledge/books" do
  resources :books, only: [:index, :show, :create, :update, :destroy]
end
# namespace :books do
#   # Cria as 5 rotas CRUD básicas (index, show, create, update, destroy)
#   resources :books, only: [:index, :show, :create, :update, :destroy]
#
#   # Adiciona a rota customizada que discutimos para o Command:
#   # collection do
#   #   post :archive_old
#   # end
# end
