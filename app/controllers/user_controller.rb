class UserController < ApplicationController
  def index
    @users = User.includes(:address).all
    render json: @users, **user_json_options
  end

  def get_user_by_Id
    @user = User.includes(:address, :transactions).find(params[:id])
    render json: @user, **user_json_options
  end

  def get_transaction_by_user_id
    @user = User.find(params[:id])
    @transactions = Transaction.where({ user_id: @user.id })
    render json: @transactions, status: :ok and return
  end

  def create
    @create_model = user_model_create
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

  def create_transaction_by_user
    @user = User.find(params[:id])
    Transaction.transaction do
      @related_transaction = Transaction.new(transaction_model_create)
      @related_transaction.user_id = @user.id
      if @related_transaction.save
        render json: @related_transaction, status: :created and return
      else
        render json: @related_transaction.errors, status: :unprocessable_entity and return
      end
    end
  end

  private
  def user_json_options
    {
      only: [ :id, :email ],
      include: [
        {
          address: {
            only: [ :id, :zipcode, :street, :city ]
          }
        },
        {
          transactions: {
            only: [ :id, :amount, :date_at ]
          }
        }
      ]
    }
  end

  def user_model_create
    params.permit(
      :name,
      :email,
      address: [ :zipcode, :city, :state, :number, :street ])
  end

  def transaction_model_create
    params.permit(:amount, :description, :date_at, :purpose)
  end
end
