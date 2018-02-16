Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'

  get '/label', to: 'label#show'
  get '/pdf', to: 'label#pdf'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
