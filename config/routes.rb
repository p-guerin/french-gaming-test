Rails.application.routes.draw do
  
  root 'home#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  resources :users
end
