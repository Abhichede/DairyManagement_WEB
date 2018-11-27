class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact
      t.string :address
      t.string :cattle_type

      t.timestamps
    end
  end
end
