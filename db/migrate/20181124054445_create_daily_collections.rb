class CreateDailyCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_collections do |t|
      t.integer :customer_id
      t.date :date
      t.time :time
      t.string :shift
      t.decimal :litre, :precision => 8, :scale => 2
      t.decimal :fat, :precision => 8, :scale => 2
      t.decimal :lacto, :precision => 8, :scale => 2
      t.decimal :snf, :precision => 8, :scale => 2
      t.decimal :water_level, :precision => 8, :scale => 2
      t.decimal :rate, :precision => 8, :scale => 2
      t.decimal :total_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
