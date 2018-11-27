require 'test_helper'

class DailyCollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_collection = daily_collections(:one)
  end

  test "should get index" do
    get daily_collections_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_collection_url
    assert_response :success
  end

  test "should create daily_collection" do
    assert_difference('DailyCollection.count') do
      post daily_collections_url, params: { daily_collection: { customer_id: @daily_collection.customer_id, date: @daily_collection.date, fat: @daily_collection.fat, lacto: @daily_collection.lacto, litre: @daily_collection.litre, rate: @daily_collection.rate, shift: @daily_collection.shift, snf: @daily_collection.snf, time: @daily_collection.time, total_price: @daily_collection.total_price, water_level: @daily_collection.water_level } }
    end

    assert_redirected_to daily_collection_url(DailyCollection.last)
  end

  test "should show daily_collection" do
    get daily_collection_url(@daily_collection)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_collection_url(@daily_collection)
    assert_response :success
  end

  test "should update daily_collection" do
    patch daily_collection_url(@daily_collection), params: { daily_collection: { customer_id: @daily_collection.customer_id, date: @daily_collection.date, fat: @daily_collection.fat, lacto: @daily_collection.lacto, litre: @daily_collection.litre, rate: @daily_collection.rate, shift: @daily_collection.shift, snf: @daily_collection.snf, time: @daily_collection.time, total_price: @daily_collection.total_price, water_level: @daily_collection.water_level } }
    assert_redirected_to daily_collection_url(@daily_collection)
  end

  test "should destroy daily_collection" do
    assert_difference('DailyCollection.count', -1) do
      delete daily_collection_url(@daily_collection)
    end

    assert_redirected_to daily_collections_url
  end
end
