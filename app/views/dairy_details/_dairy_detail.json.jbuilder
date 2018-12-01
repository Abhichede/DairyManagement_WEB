json.extract! dairy_detail, :id, :name, :address, :send_message, :created_at, :updated_at
json.url dairy_detail_url(dairy_detail, format: :json)
