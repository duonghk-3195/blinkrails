Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi|ja/ do
    get 'password_resets/new'
    get 'password_resets/edit'
    # get 'sessions/new'
    # get 'sessions/create'
    # get 'sessions/destroy'
    root 'static_pages#home'
    get '/help', to: 'static_pages#help'
    # get '/signup', to: 'users#new'
    get '/account_activation/:id/edit', to: 'account_activation#edit'
    resources :users do
      member do
        get :following, :followers
      end
    end
    as :user do
      get "signin" => "devise/sessions#new"
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
      get "signup" => "devise/registrations#new"
      get "user_unlock" => "devise/unlocks#show"
      get "unlock" => "devise/unlocks#new"
      post "user_unlock" => "devise/unlocks#create"
    end
    devise_for :users
    
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :account_activation, only: [:edit]
    resources :posts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]


    # get "/login", to: "sessions#new"
    # post "/login", to: "sessions#create"
    # delete "/logout", to: "sessions#destroy"
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
