# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token) if token

    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: "Token inválido ou ausente" }, status: :unauthorized
    end
  end

  def record_not_found(exception)
    render json: { message: "The entity #{exception.model} not found" }, status: :not_found
  end
end
