class RemoveGopayFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :gopay, :decimal
  end
end
