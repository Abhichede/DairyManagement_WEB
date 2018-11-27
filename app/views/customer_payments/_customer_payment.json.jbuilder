json.extract! customer_payment, :id, :customer_id, :date, :amount, :description, :created_at, :updated_at
json.url customer_payment_url(customer_payment, format: :json)
