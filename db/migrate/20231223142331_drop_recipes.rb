class DropRecipes < ActiveRecord::Migration[7.0]
  def change
    drop_table :recipes
  end
end
