VotrMachine::Application.routes.draw do

  devise_for :users

  resources :rounds, :only => [:show, :vote] do
  	# member do
  	# 	post ':item_id', :action => 'vote', :as => 'vote'
  	# end
  	resources :items, :except => [:index, :show]
  end

  resources :manage

  match 'dashboard' => 'manage#index', :as => :user_root

  root :to => 'pages#index'
end
