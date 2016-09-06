require 'test_helper'

class RxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rx = rxes(:one)
  end

  test "should get index" do
    get rxes_url
    assert_response :success
  end

  test "should get new" do
    get new_rx_url
    assert_response :success
  end

  test "should create rx" do
    assert_difference('Rx.count') do
      post rxes_url, params: { rx: { patient_id: @rx.patient_id } }
    end

    assert_redirected_to rx_url(Rx.last)
  end

  test "should show rx" do
    get rx_url(@rx)
    assert_response :success
  end

  test "should get edit" do
    get edit_rx_url(@rx)
    assert_response :success
  end

  test "should update rx" do
    patch rx_url(@rx), params: { rx: { patient_id: @rx.patient_id } }
    assert_redirected_to rx_url(@rx)
  end

  test "should destroy rx" do
    assert_difference('Rx.count', -1) do
      delete rx_url(@rx)
    end

    assert_redirected_to rxes_url
  end
end
