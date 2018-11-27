require "application_system_test_case"

class CustomerPaymentsTest < ApplicationSystemTestCase
  setup do
    @customer_payment = customer_payments(:one)
  end

  test "visiting the index" do
    visit customer_payments_url
    assert_selector "h1", text: "Customer Payments"
  end

  test "creating a Customer payment" do
    visit customer_payments_url
    click_on "New Customer Payment"

    fill_in "Amount", with: @customer_payment.amount
    fill_in "Customer", with: @customer_payment.customer_id
    fill_in "Date", with: @customer_payment.date
    fill_in "Description", with: @customer_payment.description
    click_on "Create Customer payment"

    assert_text "Customer payment was successfully created"
    click_on "Back"
  end

  test "updating a Customer payment" do
    visit customer_payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @customer_payment.amount
    fill_in "Customer", with: @customer_payment.customer_id
    fill_in "Date", with: @customer_payment.date
    fill_in "Description", with: @customer_payment.description
    click_on "Update Customer payment"

    assert_text "Customer payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer payment" do
    visit customer_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer payment was successfully destroyed"
  end
end
