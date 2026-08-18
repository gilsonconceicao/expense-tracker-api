class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @create_model = user_params_create
    @new_user = User.new(@create_model.except(:address))
    @new_user.name = @new_user.name.strip

    User.transaction do
      if @new_user.save
        if @create_model[:address].present?
          @new_user.create_address!(@create_model[:address])
        end

        render json: @new_user, status: :created
      else
        render json: @new_user.errors, status: :unprocessable_entity and return
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  private
  def user_params_create
    params.permit(
      :name,
      :email,
      address: [ :zipcode, :city, :state, :number, :street ])
  end
end
