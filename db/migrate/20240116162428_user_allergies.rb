class UserAllergies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_allergies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :allergy_item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
