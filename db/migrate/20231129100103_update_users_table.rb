class UpdateUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.change :email, :string, null: false
      t.index :email, unique: true
    end

    add_timestamps :users
  end
end
