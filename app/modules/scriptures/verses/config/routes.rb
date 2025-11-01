# module: "scriptures/verses" -> module: "scriptures/verses/controllers"
scope path: "scriptures", module: "scriptures/verses/controllers" do
  resources :verses, only: [ :index, :show, :create, :update, :destroy ]
end
