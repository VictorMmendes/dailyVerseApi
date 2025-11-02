scope path: "knowledge", module: "knowledge/books" do
  resources :books, only: [:index, :show, :create, :update, :destroy]
end