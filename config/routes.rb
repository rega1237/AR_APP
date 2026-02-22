Rails.application.routes.draw do
  namespace :admin do
    root to: "dashboard#index"
    get "dashboard/index"
    resources :clients do
      resources :menus, shallow: true do
        resources :categories, shallow: true do
          resources :dishes, shallow: true
        end
      end
    end
  end

  # Public-Facing Menus and AR Views
  namespace :public, path: "/v" do
    get "/:client_slug", to: "menus#show", as: :client_menu
    get "/:client_slug/d/:id", to: "dishes#show", as: :client_dish
  end

  # Sesiones de usuario (Admin)
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
