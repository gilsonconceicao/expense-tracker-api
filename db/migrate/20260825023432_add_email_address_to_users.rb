class AddEmailAddressToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :email_address, :string unless column_exists?(:users, :email_address)
  end
end
