class CreateAllergyItems < ActiveRecord::Migration[7.0]
  def change
    create_table :allergy_items do |t|
      t.string :name  # アレルギー項目の名前
      # 追加情報が必要な場合、ここにカラムを追加
      t.timestamps
    end
  end
end
