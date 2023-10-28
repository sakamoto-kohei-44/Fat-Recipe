class ModifyAllergies < ActiveRecord::Migration[7.0]
  def change
    #remove_column :allergies, :item
    #add_reference :allergies, :allergy_item, foreign_key: true
  end
end
