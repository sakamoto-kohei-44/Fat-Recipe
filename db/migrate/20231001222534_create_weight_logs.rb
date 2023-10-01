class CreateWeightLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_logs do |t|
      t.date :date
      t.float :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
