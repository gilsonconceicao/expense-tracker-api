class TransactionController < ApplicationController
  def index
    @transaction = Transaction.all
    render json: @transaction
  end

  def get_by_id
    @transaction = Transaction.find(params[:id])
    render json: @transaction
  end

  def create
    @params_create = transaction_params_create
    @new_transaction = Transaction.new(@params_create)

    if !@params_create[:date_at].blank?
      @new_transaction.date_at = @params_create[:date_at]
    else
      @new_transaction.date_at = Date.current
    end

    if !@params_create[:purpose].blank? && (@params_create[:purpose] > 2 || @params_create[:purpose] == 0)
      render json: { error: "Send a valid value to purpose field between 1 - incoming or 2 - outgoing" }, status: :bad_request and return
    end

    if @new_transaction.save
      render json: { new_transaction: @new_transaction }, status: :created
    else
      render json: @new_transaction.errors, status: :unprocessable_entity and return
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params_update)
      render json: { updated_transaction: @transaction }, status: :ok
    else
      render json: @transaction.errors, status: :unprocessable_entity and return
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    head :no_content
  end

  private
  def transaction_params_create
    params.require(:transaction).permit(:amount, :description, :date_at, :purpose)
  end

  private
  def transaction_params_update
    params.require(:transaction).permit(:amount, :description, :purpose)
  end
end
