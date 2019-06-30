class DashboardController < ApplicationController
  def index
    @daily_collections = DailyCollection.all
    @customers = Customer.all
    @customer_payments = CustomerPayment.all
    response = check_sms_balance

    a = response.split(':')
    t = a[4].split('<BR/>') if a.nil?
    @messages = Hash.new()
    @messages["count_m"] = !t.nil? ? t[0] : 'NA'
  end
end
