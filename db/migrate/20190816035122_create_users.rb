class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :customer_name
      t.string :item_description
      t.decimal :item_price, :precision => 8, :scale => 2
      t.integer :quantity
      t.string :merchant_name
      t.string :merchant_address

      t.timestamps
    end
  end
end
