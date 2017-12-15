class RemoveGopayFromDrivers < ActiveRecord::Migration[5.1]
  def change
    remove_column :drivers, :gopay, :decimal
  end
end
