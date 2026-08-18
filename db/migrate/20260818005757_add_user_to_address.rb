class AddUserToAddress < ActiveRecord::Migration[8.1]
  def change
    add_reference :addresses, :user, null: true, foreign_key: true, type: :uuid
  end
end
