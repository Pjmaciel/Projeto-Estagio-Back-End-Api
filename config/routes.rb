Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  resources :visits, except: [:new, :edit]
  resources :formularies, except: [:new, :edit]
  resources :questions, except: [:new, :edit]
  resources :answers, except: [:new, :edit]

  post 'auth/login', to: 'auth#login'
  post 'auth/logout', to: 'auth#logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
