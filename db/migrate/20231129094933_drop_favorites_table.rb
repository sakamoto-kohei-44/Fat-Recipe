class DropFavoritesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :favorites
  end
end
