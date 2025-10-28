# app/modules/knowledge/books/config/routes.rb
resources :books, only: [:index, :create, :show, :update, :destroy]