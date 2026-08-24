class TransactionController < ApplicationController
  def index
    @transaction = Transaction.all
    render json: @transaction, **transaction_json_object
  end

  def get_by_id
    @transaction = Transaction.find(params[:id])
    render json: @transaction, **transaction_json_object
  end

  def create
    @params_create = transaction_model_create
    @user = User.find(params[:user_id])

    if !@params_create[:purpose].blank? && (@params_create[:purpose] > 2 || @params_create[:purpose] == 0)
      render json: { error: "Send a valid value to purpose field between 1 - incoming or 2 - outgoing" }, status: :bad_request and return
    end

    transaction = CreateTransaction.call(
      user: @user,
      model: @params_create
    )

    if transaction.persisted?
      render json: transaction, status: :created
    else
      render json: {
        errors: transaction.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    @body = transaction_model_update

    updated_transaction = UpdateTransaction.call(
      transaction: @transaction,
      model: @body
    )

    if updated_transaction
      render json: {}, status: :no_content
    else
      render json: {
        errors: updated_transaction.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    head :no_content
  end

  private
  def transaction_json_object
    {
      only: [ :id, :description, :amount, :date_at ],
      include: [
        {
          user: {
            only:  [ :id, :name, :email, :created_at ]
          }
        }
      ]
    }
  end

  def transaction_model_create
    params.require(:transaction).permit(:amount, :description, :date_at, :purpose)
  end

  def transaction_model_update
    params.require(:transaction).permit(:amount, :description, :purpose)
  end
end
