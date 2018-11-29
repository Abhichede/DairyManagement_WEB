class AddColumnToAll < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :user_id, :integer
    add_column :daily_collections, :user_id, :integer
    add_column :customer_payments, :user_id, :integer
  end
end
