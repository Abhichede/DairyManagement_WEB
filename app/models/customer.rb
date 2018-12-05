class Customer < ApplicationRecord
  has_many :daily_collections, dependent: :destroy
  has_many :customer_payments, dependent: :destroy
  belongs_to :user
end
