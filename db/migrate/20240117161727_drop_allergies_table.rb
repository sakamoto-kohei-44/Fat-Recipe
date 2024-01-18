class DropAllergiesTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :allergies
  end

  def down
    create_table :allergies do |t|
      t.string :item
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
