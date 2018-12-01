class CreateDairyDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :dairy_details do |t|
      t.string :name
      t.string :address
      t.boolean :send_message

      t.timestamps
    end
  end
end
