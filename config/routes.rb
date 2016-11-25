Rails.application.routes.draw do
  root to: "home#index"

  # OmniAuth
  get "/auth/trello", as: :trello_auth
  get "/auth/trello/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :signout

  resources :sites, only: [:create]
  get "/*id/*list" => "sites#page", as: "site_page"
  get "/*id" => "sites#show", as: "site"

  match '/webhooks/new', to: 'webhooks#verify', via: :head
  post '/webhooks/new', to: 'webhooks#new'
end
