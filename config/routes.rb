Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }


  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
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

  end


  namespace :admin do
    resources :items
    resources :genres
    resources :customers
    resources :orders
    resources :order_items
  end

end