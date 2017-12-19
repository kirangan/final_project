class AddDetailsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :longitude_dest, :float
    add_column :orders, :latitude_dest, :float
  end
end
