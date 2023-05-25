class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :address, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
