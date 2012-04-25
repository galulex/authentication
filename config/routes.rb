Authentication::Application.routes.draw do
  resources :users, :only => [:new, :create, :edit]
  resource  :session, :only => [:new, :create, :destroy]
  resources :password_resets, :except => [:index, :show, :destroy]
  root :to => 'sessions#new'
  # match ':controller(/:action(/:id))(.:format)'
end
