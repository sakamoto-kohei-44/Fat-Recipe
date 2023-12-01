class AddTimestampsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :users, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
