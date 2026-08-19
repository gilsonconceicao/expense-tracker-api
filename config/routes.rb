Rails.application.routes.draw do
  # User routes
  get "/user", to: "user#index"
  get "/user/:id", to: "user#get_user_by_Id"
  post "/user/:id/transactions", to: "user#create_transaction_by_user"
  get "/user/:id/transactions", to: "user#get_transaction_by_user_id"
  post "/user", to: "user#create"
  # Transaction routes
  get "/transaction", to: "transaction#index"
  get "/transaction/:id", to: "transaction#get_by_id"
  post "/transaction", to: "transaction#create"
  put "/transaction/:id", to: "transaction#update"
  delete "/transaction/:id", to: "transaction#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
