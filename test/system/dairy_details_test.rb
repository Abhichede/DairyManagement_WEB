require "application_system_test_case"

class DairyDetailsTest < ApplicationSystemTestCase
  setup do
    @dairy_detail = dairy_details(:one)
  end

  test "visiting the index" do
    visit dairy_details_url
    assert_selector "h1", text: "Dairy Details"
  end

  test "creating a Dairy detail" do
    visit dairy_details_url
    click_on "New Dairy Detail"

    fill_in "Address", with: @dairy_detail.address
    fill_in "Name", with: @dairy_detail.name
    fill_in "Send Message", with: @dairy_detail.send_message
    click_on "Create Dairy detail"

    assert_text "Dairy detail was successfully created"
    click_on "Back"
  end

  test "updating a Dairy detail" do
    visit dairy_details_url
    click_on "Edit", match: :first

    fill_in "Address", with: @dairy_detail.address
    fill_in "Name", with: @dairy_detail.name
    fill_in "Send Message", with: @dairy_detail.send_message
    click_on "Update Dairy detail"

    assert_text "Dairy detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Dairy detail" do
    visit dairy_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dairy detail was successfully destroyed"
  end
end
