class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
