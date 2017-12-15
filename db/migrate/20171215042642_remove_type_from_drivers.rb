class RemoveTypeFromDrivers < ActiveRecord::Migration[5.1]
  def change
    remove_column :drivers, :type, :integer
  end
end
