class AddAllergyItemIdsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :allergy_item_ids, :text, array: true, default: []
  end
end
