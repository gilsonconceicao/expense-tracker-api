class UpdateTransaction
  def self.call(transaction:, model:)
    new(transaction, model).call
  end

  def initialize(transaction, model)
    @model = model
    @transaction = transaction
  end

  def call
    ActiveRecord::Base.transaction do
      @updated = @transaction.update!(@model)
      @updated
    end
  end
end
