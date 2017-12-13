class AddDistanceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :distance, :decimal
  end
end
