class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.integer :gender
      t.integer :age
      t.float :height
      t.float :weight
      t.integer :activity_level
      t.integer :goal

      t.timestamps
    end
  end
end
