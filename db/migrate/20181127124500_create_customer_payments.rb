class CreateCustomerPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_payments do |t|
      t.integer :customer_id
      t.date :date
      t.decimal :amount
      t.string :description

      t.timestamps
    end
  end
end
