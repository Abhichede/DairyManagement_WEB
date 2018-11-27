require "application_system_test_case"

class DailyCollectionsTest < ApplicationSystemTestCase
  setup do
    @daily_collection = daily_collections(:one)
  end

  test "visiting the index" do
    visit daily_collections_url
    assert_selector "h1", text: "Daily Collections"
  end

  test "creating a Daily collection" do
    visit daily_collections_url
    click_on "New Daily Collection"

    fill_in "Customer", with: @daily_collection.customer_id
    fill_in "Date", with: @daily_collection.date
    fill_in "Fat", with: @daily_collection.fat
    fill_in "Lacto", with: @daily_collection.lacto
    fill_in "Litre", with: @daily_collection.litre
    fill_in "Rate", with: @daily_collection.rate
    fill_in "Shift", with: @daily_collection.shift
    fill_in "Snf", with: @daily_collection.snf
    fill_in "Time", with: @daily_collection.time
    fill_in "Total Price", with: @daily_collection.total_price
    fill_in "Water Level", with: @daily_collection.water_level
    click_on "Create Daily collection"

    assert_text "Daily collection was successfully created"
    click_on "Back"
  end

  test "updating a Daily collection" do
    visit daily_collections_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @daily_collection.customer_id
    fill_in "Date", with: @daily_collection.date
    fill_in "Fat", with: @daily_collection.fat
    fill_in "Lacto", with: @daily_collection.lacto
    fill_in "Litre", with: @daily_collection.litre
    fill_in "Rate", with: @daily_collection.rate
    fill_in "Shift", with: @daily_collection.shift
    fill_in "Snf", with: @daily_collection.snf
    fill_in "Time", with: @daily_collection.time
    fill_in "Total Price", with: @daily_collection.total_price
    fill_in "Water Level", with: @daily_collection.water_level
    click_on "Update Daily collection"

    assert_text "Daily collection was successfully updated"
    click_on "Back"
  end

  test "destroying a Daily collection" do
    visit daily_collections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Daily collection was successfully destroyed"
  end
end
