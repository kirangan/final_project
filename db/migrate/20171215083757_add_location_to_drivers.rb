class AddLocationToDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :location, :text, default:"", null:false
  end
end
