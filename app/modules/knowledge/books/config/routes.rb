# module: "knowledge/books" -> module: "knowledge/books/controllers"
scope path: "knowledge", module: "knowledge/books/controllers" do
  resources :books, only: [:index, :create, :show, :update, :destroy]
end