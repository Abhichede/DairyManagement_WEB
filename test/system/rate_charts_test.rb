require "application_system_test_case"

class RateChartsTest < ApplicationSystemTestCase
  setup do
    @rate_chart = rate_charts(:one)
  end

  test "visiting the index" do
    visit rate_charts_url
    assert_selector "h1", text: "Rate Charts"
  end

  test "creating a Rate chart" do
    visit rate_charts_url
    click_on "New Rate Chart"

    fill_in "Cattle Type", with: @rate_chart.cattle_type
    fill_in "Fat", with: @rate_chart.fat
    fill_in "Rate", with: @rate_chart.rate
    fill_in "Snf", with: @rate_chart.snf
    click_on "Create Rate chart"

    assert_text "Rate chart was successfully created"
    click_on "Back"
  end

  test "updating a Rate chart" do
    visit rate_charts_url
    click_on "Edit", match: :first

    fill_in "Cattle Type", with: @rate_chart.cattle_type
    fill_in "Fat", with: @rate_chart.fat
    fill_in "Rate", with: @rate_chart.rate
    fill_in "Snf", with: @rate_chart.snf
    click_on "Update Rate chart"

    assert_text "Rate chart was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate chart" do
    visit rate_charts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate chart was successfully destroyed"
  end
end
