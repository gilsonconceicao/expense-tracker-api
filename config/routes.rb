Rails.application.routes.draw do
  get "/transaction", to: "transaction#index"
  get "/transaction/:id", to: "transaction#getById"
  post "/transaction", to: "transaction#create"

  get "up" => "rails/health#show", as: :rails_health_check
end
