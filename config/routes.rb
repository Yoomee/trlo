Rails.application.routes.draw do
  # OmniAuth
  get "/auth/trello", as: :trello_auth
  get "/auth/trello/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :signout

  get "/" => "sites#show",
      as: "site",
      constraints: ->(request) { Site.exists?(name: request.subdomains(0)) }
  get "/*list" => "sites#page",
      as: "site_page",
      constraints: ->(request) { Site.exists?(name: request.subdomains(0)) }

  resources :sites, only: [:create]

  match "/webhooks/new", to: "webhooks#verify", via: :head
  post "/webhooks/new", to: "webhooks#new"
  root to: "home#index"
end
