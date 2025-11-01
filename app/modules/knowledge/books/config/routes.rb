scope path: "knowledge", module: "knowledge/books" do
  resources :books, only: [:index, :create, :show, :update, :destroy]
end