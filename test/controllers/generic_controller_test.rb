require 'test_helper'

class GenericControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get generic_index_url
    assert_response :success
  end

  test "should get update" do
    get generic_update_url
    assert_response :success
  end

  test "should get edit" do
    get generic_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get generic_destroy_url
    assert_response :success
  end

  test "should get new" do
    get generic_new_url
    assert_response :success
  end

  test "should get create" do
    get generic_create_url
    assert_response :success
  end

end
