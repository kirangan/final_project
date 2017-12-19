class RemoveDetailsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :longitude_dest, :float
    remove_column :orders, :latitude_dest, :float
  end
end
