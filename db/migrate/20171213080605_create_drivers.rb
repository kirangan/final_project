class CreateDrivers < ActiveRecord::Migration[5.1]
  def change
    create_table :drivers do |t|
      t.string :username
      t.string :email
      t.decimal :gopay
      t.string :password_digest

      t.timestamps
    end
  end
end
