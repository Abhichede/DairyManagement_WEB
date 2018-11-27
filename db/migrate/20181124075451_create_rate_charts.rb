class CreateRateCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_charts do |t|
      t.string :cattle_type
      t.decimal :snf, :precision => 8, :scale => 2
      t.decimal :fat, :precision => 8, :scale => 2
      t.decimal :rate, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
