Rails.application.routes.draw do
  root to: "home#index"

  # OmniAuth
  get "/auth/trello", as: :trello_auth
  get "/auth/trello/callback", to: "sessions#create"
  get "/signout", to: "sessions#destroy", as: :signout

  resources :sites, only: [:create, :show]

end
