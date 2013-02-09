Authentication::Application.routes.draw do

  resources :users, :except => [:index, :show, :destroy]
  resource  :session, :only => [:new, :create, :destroy]
  resources :password_resets, :except => [:index, :show, :destroy]

  resource :admin, only: :show
  namespace :admin do
    resource :company
  end

  root :to => 'dashboard#index'
  # match ':controller(/:action(/:id))(.:format)'
end
