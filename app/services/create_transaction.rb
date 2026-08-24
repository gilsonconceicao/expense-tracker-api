class CreateTransaction
  def self.call(user:, model:)
    new(user, model).call
  end
  def initialize(user, model)
    @user = user
    @model = model
  end

  def call
    ActiveRecord::Base.transaction do
      transacation = @user.transactions.create!(@model)
      transacation
    end
  end
end
