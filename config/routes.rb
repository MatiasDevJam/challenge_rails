Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %i[show create]
    post "login", to: "authentication#create"
    resources :characters
    resources :movies
  end
end
