require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get '/search'
    assert_response :success
  end

  test "should search units" do
    get '/search', mode: 'unit', term: 'mg'
    assert_response :success
  end
end
