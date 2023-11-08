class AddSpoonacularIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :spoonacular_id, :integer
  end
end
