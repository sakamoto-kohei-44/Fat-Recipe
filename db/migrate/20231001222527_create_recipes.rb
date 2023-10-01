class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :total_calories
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
