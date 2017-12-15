class AddGopayToDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :gopay, :decimal, default:0.0, null:false
  end
end
