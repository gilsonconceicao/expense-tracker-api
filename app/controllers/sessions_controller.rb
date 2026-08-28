class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: [ :create, :login ]

  def create
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user.as_json(only: [ :id, :email_address ]), token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email_address: params[:email_address])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, email_address: user.email_address }, status: :ok
    else
      render json: { error: "E-mail ou senha incorretos" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email_address, :password, :password_confirmation)
  end
end
