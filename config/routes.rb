Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi|ja/ do
    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
    root 'static_pages#home'
    get '/help', to: 'static_pages#help'
    get '/signup', to: 'users#new'
    resources :posts
    resources :users do
      member do
        get :profile, to: "users#show"
      end
    end

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
