Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }


  devise_for :admins, controllers: {
  sessions: 'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }


    #home
  root to: 'homes#top'
   #about
  get "/home/about" => "homes#about"

  namespace :public do
    resources :items
    resources :customers
    resources :orders
    resources :addresses
    resources :cart_items
    patch '/customers/whithdraw' => 'customers#destroy'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'

  end


  namespace :admin do
    resources :items
    resources :genres
    resources :customers
    resources :orders
    resources :order_items
    resources :homes
  end

end