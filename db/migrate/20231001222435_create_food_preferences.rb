class CreateFoodPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :food_preferences do |t|
      t.string :food_item
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
