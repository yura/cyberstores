Rails.application.routes.draw do
  get '/cart' => 'orders#cart'
  resources :order_items, only: [ :create ]
  resources :products
  root 'products#index'
end
