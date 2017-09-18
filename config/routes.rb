Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations",:omniauth_callbacks => "omniauth_callbacks" }

  resources :users, :only => :show
  match '/', to: 'home#index', constraints: { subdomain: 'www' }, via: [:get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: "home#index"
end
