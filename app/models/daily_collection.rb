class DailyCollection < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  validates :litre, presence: :true
  validates :fat, presence: :true
  validates :lacto, presence: :true
  validates :snf, presence: :true
  validates :rate, presence: :true
  validates :total_price, presence: :true
end
