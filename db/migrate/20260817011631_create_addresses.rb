class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :zipcode
      t.string :street
      t.string :state
      t.string :city
      t.integer :number

      t.timestamps
    end
  end
end
