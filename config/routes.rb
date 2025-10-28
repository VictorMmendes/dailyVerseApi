Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Use 'scope path:' para adicionar APENAS o prefixo na URL
  # sem afetar o nome do módulo (controller)
  scope path: 'api/v1' do
    # Load all modular route files from app/modules/**/config/routes.rb
    Dir[Rails.root.join('app/modules/**/config/routes.rb')].sort.each do |route_file|
      instance_eval(File.read(route_file), route_file)
    end
  end
end
