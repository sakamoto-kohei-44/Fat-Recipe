class DropFoodPreferences < ActiveRecord::Migration[7.0]
  def change
    drop_table :food_preferences
  end
end
