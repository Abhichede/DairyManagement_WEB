require 'test_helper'

class CustomerPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_payment = customer_payments(:one)
  end

  test "should get index" do
    get customer_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_payment_url
    assert_response :success
  end

  test "should create customer_payment" do
    assert_difference('CustomerPayment.count') do
      post customer_payments_url, params: { customer_payment: { amount: @customer_payment.amount, customer_id: @customer_payment.customer_id, date: @customer_payment.date, description: @customer_payment.description } }
    end

    assert_redirected_to customer_payment_url(CustomerPayment.last)
  end

  test "should show customer_payment" do
    get customer_payment_url(@customer_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_payment_url(@customer_payment)
    assert_response :success
  end

  test "should update customer_payment" do
    patch customer_payment_url(@customer_payment), params: { customer_payment: { amount: @customer_payment.amount, customer_id: @customer_payment.customer_id, date: @customer_payment.date, description: @customer_payment.description } }
    assert_redirected_to customer_payment_url(@customer_payment)
  end

  test "should destroy customer_payment" do
    assert_difference('CustomerPayment.count', -1) do
      delete customer_payment_url(@customer_payment)
    end

    assert_redirected_to customer_payments_url
  end
end
