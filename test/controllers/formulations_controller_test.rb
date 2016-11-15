require 'test_helper'

class FormulationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formulation = formulations(:one)
  end

  test "should get index" do
    get formulations_url
    assert_response :success
  end

  test "should get new" do
    get new_formulation_url
    assert_response :success
  end

  test "should create formulation" do
    assert_difference('Formulation.count') do
      post formulations_url, params: { formulation: { category_id: @formulation.category_id, comment_id: @formulation.comment_id, generic_id: @formulation.generic_id, like_id: @formulation.like_id, steps: @formulation.steps } }
    end

    assert_redirected_to formulation_url(Formulation.last)
  end

  test "should show formulation" do
    get formulation_url(@formulation)
    assert_response :success
  end

  test "should get edit" do
    get edit_formulation_url(@formulation)
    assert_response :success
  end

  test "should update formulation" do
    patch formulation_url(@formulation), params: { formulation: { category_id: @formulation.category_id, comment_id: @formulation.comment_id, generic_id: @formulation.generic_id, like_id: @formulation.like_id, steps: @formulation.steps } }
    assert_redirected_to formulation_url(@formulation)
  end

  test "should destroy formulation" do
    assert_difference('Formulation.count', -1) do
      delete formulation_url(@formulation)
    end

    assert_redirected_to formulations_url
  end
end
