Rails.application.routes.draw do
  # User routes
  get "/user", to: "user#index"
  post "/user", to: "user#create"
  # Transaction routes
  get "/transaction", to: "transaction#index"
  get "/transaction/:id", to: "transaction#get_by_id"
  post "/transaction", to: "transaction#create"
  put "/transaction/:id", to: "transaction#update"
  delete "/transaction/:id", to: "transaction#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
