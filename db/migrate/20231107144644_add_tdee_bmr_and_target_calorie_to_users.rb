class AddTdeeBmrAndTargetCalorieToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tdee, :float
    add_column :users, :bmr, :float
    add_column :users, :target_calorie, :float
  end
end
