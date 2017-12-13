class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :mode
      t.text :origin
      t.text :destination
      t.integer :payment
      t.decimal :total_price

      t.timestamps
    end
  end
end
