class AddDetailsToDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :longitude, :float
    add_column :drivers, :latitude, :float
  end
end
