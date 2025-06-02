require "test_helper"

class MothersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mothers_show_url
    assert_response :success
  end

  test "should get new" do
    get mothers_new_url
    assert_response :success
  end

  test "should get create" do
    get mothers_create_url
    assert_response :success
  end

  test "should get edit" do
    get mothers_edit_url
    assert_response :success
  end

  test "should get update" do
    get mothers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mothers_destroy_url
    assert_response :success
  end
end
