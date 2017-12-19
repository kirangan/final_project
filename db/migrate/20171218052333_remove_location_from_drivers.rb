class RemoveLocationFromDrivers < ActiveRecord::Migration[5.1]
  def change
    remove_column :drivers, :location, :text
  end
end
