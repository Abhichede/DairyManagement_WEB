json.extract! daily_collection, :id, :customer_id, :date, :time, :shift, :litre, :fat, :lacto, :snf, :water_level, :rate, :total_price, :created_at, :updated_at
json.url daily_collection_url(daily_collection, format: :json)
