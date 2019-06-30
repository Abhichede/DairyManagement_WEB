class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  after_action :save_my_previous_url

  rescue_from CanCan::AccessDenied do |exception|
    session.delete(:return_to)
    session[:return_to] ||= request.referer
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end

  def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:previous_url] = URI(request.referer || '').path
  end

  def send_daily_receipt_sms(mobile_no, daily_collection)
    username = 'u43741'
    message_token = 'heJWt4'
    sender_id = 'SDAIRY'
    customer_name = daily_collection.customer.name.split(' ')
    message = CGI.escape("SHIVKRUPA DAIRY\r\n\r\nDATE:#{daily_collection.date} #{daily_collection.time.strftime("%I:%M %p")}\r
SHIFT:#{daily_collection.shift}\r
PRD.NAME:#{customer_name[0]} #{customer_name[1]}\r
ACC NO.:#{daily_collection.id}\r
MILK TYPE:#{daily_collection.customer.cattle_type}\r
LTR:#{daily_collection.litre}\r
FAT:#{daily_collection.fat}\r
SNF:#{daily_collection.snf}\r
LACTO:#{daily_collection.lacto}\r
RATE:#{daily_collection.rate}\r
AMOUNT:#{daily_collection.total_price}\r
-THANK YOU\r
Powered By LINKERITSOLUTIONS\r")
    puts message
    begin
      response = RestClient.get "http://sms.aamantran.co.in/api/send_transactional_sms.php?username=#{username}&msg_token=#{message_token}&sender_id=#{sender_id}&message=#{message}&mobile=#{mobile_no}"
      case response.code
      when 400
        puts response
      when 200
        puts response
      else
        puts "Invalid response #{response} received."
      end
    rescue => exception
      exception.response
    end
  end

  def send_payment_receipt_sms(mobile_no, customer_payment)
    username = 'u43741'
    message_token = 'heJWt4'
    sender_id = 'SDAIRY'
    customer_name = customer_payment.customer.name.split(' ')
    message = CGI.escape("Dear #{customer_name[0]} #{customer_name[1] if customer_name[1]}, Your payment of Rs. #{customer_payment.amount} is successfully paid by SHIVKRUPA DAIRY on dated #{customer_payment.date} #{customer_payment.created_at.strftime("%I:%M %p")}.THANK YOU")
    begin
      response = RestClient.get "http://sms.aamantran.co.in/api/send_transactional_sms.php?username=#{username}&msg_token=#{message_token}&sender_id=#{sender_id}&message=#{message}&mobile=#{mobile_no}"
      puts response
      case response.code
      when 400
        puts response
      when 200
        puts response
      else
        puts "Invalid response #{response} received."
      end
    rescue => exception
      puts "Invalid response #{exception} received."
    end
  end

  def check_sms_balance
    begin
      response = RestClient.get "http://sms.aamantran.co.in/api/balance_check_api.php?myuid=u43741&mytoken=heJWt4"
      case response.code
      when 400
        puts "400: "+ response
      when 200
        puts response
      else
        puts "Invalid response #{response} received."
      end
    rescue => exception
      puts exception
      response = "Something went wrong #{exception}"
    end
    response
  end
end
