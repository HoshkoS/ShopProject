class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 5, scale: 2, null: false
      t.integer :balance, null: false

      t.timestamps
    end
  end
end
