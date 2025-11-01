scope path: "scriptures", module: "scriptures/verses" do
  resources :verses, only: [ :index, :show, :create, :update, :destroy ]
end
