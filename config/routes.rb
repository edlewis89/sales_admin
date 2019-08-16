Rails.application.routes.draw do
  resources :users do
    collection {post :import}
  end

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  root to: "home#index"
end
