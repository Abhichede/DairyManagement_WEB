class Customer < ApplicationRecord
  has_many :daily_collections
  has_many :customer_payments
  belongs_to :user
end
