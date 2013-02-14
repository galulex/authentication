Authentication::Application.routes.draw do

  resources :users, :except => [:index, :show, :destroy]
  resource  :session, :only => [:new, :create, :destroy]
  resources :password_resets, :except => [:index, :show, :destroy]
  resources :products, only: :show

  resource :admin, only: :show
  namespace :admin do
    resource :company
    resources :people
    resources :partners
  end

  root :to => 'dashboard#index'
  # match ':controller(/:action(/:id))(.:format)'
end
