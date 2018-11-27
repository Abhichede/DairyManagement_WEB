require 'test_helper'

class RateChartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_chart = rate_charts(:one)
  end

  test "should get index" do
    get rate_charts_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_chart_url
    assert_response :success
  end

  test "should create rate_chart" do
    assert_difference('RateChart.count') do
      post rate_charts_url, params: { rate_chart: { cattle_type: @rate_chart.cattle_type, fat: @rate_chart.fat, rate: @rate_chart.rate, snf: @rate_chart.snf } }
    end

    assert_redirected_to rate_chart_url(RateChart.last)
  end

  test "should show rate_chart" do
    get rate_chart_url(@rate_chart)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_chart_url(@rate_chart)
    assert_response :success
  end

  test "should update rate_chart" do
    patch rate_chart_url(@rate_chart), params: { rate_chart: { cattle_type: @rate_chart.cattle_type, fat: @rate_chart.fat, rate: @rate_chart.rate, snf: @rate_chart.snf } }
    assert_redirected_to rate_chart_url(@rate_chart)
  end

  test "should destroy rate_chart" do
    assert_difference('RateChart.count', -1) do
      delete rate_chart_url(@rate_chart)
    end

    assert_redirected_to rate_charts_url
  end
end
