json.extract! customer, :id, :name, :contact, :address, :cattle_type, :created_at, :updated_at
json.url customer_url(customer, format: :json)
