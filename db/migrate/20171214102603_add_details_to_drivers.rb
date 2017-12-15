class AddDetailsToDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :location, :text
    add_column :drivers, :type, :integer
  end
end
