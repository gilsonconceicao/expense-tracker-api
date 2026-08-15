class TransactionController < ApplicationController
  def index
    @transaction = Transaction.all
    render json: @transaction
  end

  def getById
    @transaction = Transaction.find(params[:id])
  end

  def create
    @params_create = transaction_params_create
    @new_transaction = Transaction.new(@params_create)

    if !@params_create[:date_at].blank?
      @new_transaction.date_at = @params_create[:date_at]
    else
      @new_transaction.date_at = Date.current
    end

    if @new_transaction.save
      render json: { new_transaction: @new_transaction }, status: :created
    else
      render json: @new_transaction.errors, status: :unprocessable_entity
    end

    render json: { new_transaction: @new_transaction }, status: :created
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    render json: {}, status: :no_content
  end

  private
  def transaction_params_create
    params.require(:transaction).permit(:amount, :description, :date_at)
  end
end
