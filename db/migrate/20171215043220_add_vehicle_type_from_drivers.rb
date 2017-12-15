class AddVehicleTypeFromDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :vehicle_type, :integer
  end
end
