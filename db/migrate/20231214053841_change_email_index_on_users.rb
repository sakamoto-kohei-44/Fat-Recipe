class ChangeEmailIndexOnUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :email
    add_index :users, [:email, :deleted_at], unique: true
  end
end
