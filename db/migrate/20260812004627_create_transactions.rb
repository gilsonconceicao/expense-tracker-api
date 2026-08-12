class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :description
      t.decimal :amount
      t.integer :purpose
      t.date :date_at

      t.timestamps
    end
  end
end
