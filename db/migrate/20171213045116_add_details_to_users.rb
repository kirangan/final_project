class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string
    add_column :users, :gopay, :decimal
  end
end
