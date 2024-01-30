Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/account_activation/:id/edit', to: 'account_activation#edit'
  resources :posts
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  # resources :account_activation, only: [:edit]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
