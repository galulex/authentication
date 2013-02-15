Authentication::Application.routes.draw do

  resources :users, except: [:index, :show, :destroy]
  resource  :session, only:  [:new, :create, :destroy]
  resources :password_resets, except: [:index, :show, :destroy]
  resources :products, only: :show do
    resources :product_reviews, except: :index, controller: :product_reviews, as: :reviews
  end
  resources :companies, only: :show
  resources :all_logins, only: [:index, :show]

  resource :admin, only: :show
  namespace :admin do
    resource :company
    resources :people
    resources :partners
    resources :partner_products
  end

  root :to => 'dashboard#index'
  # match ':controller(/:action(/:id))(.:format)'
end
