require 'test_helper'

class DairyDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dairy_detail = dairy_details(:one)
  end

  test "should get index" do
    get dairy_details_url
    assert_response :success
  end

  test "should get new" do
    get new_dairy_detail_url
    assert_response :success
  end

  test "should create dairy_detail" do
    assert_difference('DairyDetail.count') do
      post dairy_details_url, params: { dairy_detail: { address: @dairy_detail.address, name: @dairy_detail.name, send_message: @dairy_detail.send_message } }
    end

    assert_redirected_to dairy_detail_url(DairyDetail.last)
  end

  test "should show dairy_detail" do
    get dairy_detail_url(@dairy_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_dairy_detail_url(@dairy_detail)
    assert_response :success
  end

  test "should update dairy_detail" do
    patch dairy_detail_url(@dairy_detail), params: { dairy_detail: { address: @dairy_detail.address, name: @dairy_detail.name, send_message: @dairy_detail.send_message } }
    assert_redirected_to dairy_detail_url(@dairy_detail)
  end

  test "should destroy dairy_detail" do
    assert_difference('DairyDetail.count', -1) do
      delete dairy_detail_url(@dairy_detail)
    end

    assert_redirected_to dairy_details_url
  end
end
